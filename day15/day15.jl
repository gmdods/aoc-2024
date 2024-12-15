function day15b(f)
	fs = readlines(f)
	it = findfirst(isempty, fs)
	s = mapreduce(collect, hcat, fs[1:it-1]) |> permutedims
	m = fill('.', size(s, 1), size(s, 2) * 2)
	for i = 1:size(s, 1)
		for j = 1:size(s, 2)
			if s[i, j] == '@'
				m[i, 2j-1] = '@'
			elseif s[i, j] == 'O'
				m[i, 2j-1] = '['
				m[i, 2j] = ']'
			elseif s[i, j] == '#'
				m[i, 2j-1:2j] .= '#'
			end
		end
	end

	function findtree(i_, d)
		bit = falses(size(m))
		function _findtree(i)
			checkbounds(Bool, bit, i) || return false
			bit[i] && return true
			if m[i] == '@'
				bit[i] = true
				_findtree(i+d)
			elseif m[i] == '['
				bit[i] = true
				bit[i+CartesianIndex(0, 1)] = true
				_findtree(i+d) && _findtree(i+CartesianIndex(0, 1)+d)
			elseif m[i] == ']'
				bit[i] = true
				bit[i+CartesianIndex(0, -1)] = true
				_findtree(i+d) && _findtree(i+CartesianIndex(0, -1)+d)
			elseif m[i] == '.'
				true
			elseif m[i] == '#'
				false
			end
		end
		ok = _findtree(i_)
		ok ? bit : nothing
	end

	i = findfirst(m .== '@')
	dir = Dict{Char, CartesianIndex}(
		'<' => CartesianIndex(0, -1),
		'>' => CartesianIndex(0, 1),
		'^' => CartesianIndex(-1, 0),
		'v' => CartesianIndex(1, 0),
	)
	for d = mapreduce(collect, vcat, fs[it+1:end])
		c = m[i + dir[d]]
		c != '#' || continue
		if d == '<'
			e = findprev(==('.'), m[i[1], :], i[2])
			!isnothing(e) || continue
			all(m[i[1], e:i[2]] .!= '#') || continue
			m[i[1], e:i[2]] .= circshift(m[i[1], e:i[2]], -1)
		elseif d == '>'
			e = findnext(==('.'), m[i[1], :], i[2])
			!isnothing(e) || continue
			all(m[i[1], i[2]:e] .!= '#') || continue
			m[i[1], i[2]:e] .= circshift(m[i[1], i[2]:e], 1)
		elseif d == 'v'
			e = findtree(i, dir[d])
			!isnothing(e) || continue
			t = m[e]
			m[e] .= '.'
			m[circshift(e, (1, 0))] .= t
		elseif d == '^'
			e = findtree(i, dir[d])
			!isnothing(e) || continue
			t = m[e]
			m[e] .= '.'
			m[circshift(e, (-1, 0))] .= t
		else
			@assert false
		end
		i += dir[d]
	end
	return mapreduce(a -> 100 * a[1] + a[2], +, findall(m .== '[') .- CartesianIndex(1, 1))
end

function day15a(f)
	fs = readlines(f)
	it = findfirst(isempty, fs)
	s = mapreduce(collect, hcat, fs[1:it-1]) |> permutedims
	i = findfirst(s .== '@')
	dir = Dict{Char, CartesianIndex}(
		'<' => CartesianIndex(0, -1),
		'>' => CartesianIndex(0, 1),
		'^' => CartesianIndex(-1, 0),
		'v' => CartesianIndex(1, 0),
	)
	o = sum(s .== 'O')
	for d = mapreduce(collect, vcat, fs[it+1:end])
		@assert o == sum(s .== 'O')
		c = s[i + dir[d]]
		c != '#' || continue
		if d == '<'
			e = findprev(==('.'), s[i[1], :], i[2])
			!isnothing(e) || continue
			all(s[i[1], e:i[2]] .!= '#') || continue
			s[i[1], e:i[2]] .= circshift(s[i[1], e:i[2]], -1)
		elseif d == '>'
			e = findnext(==('.'), s[i[1], :], i[2])
			!isnothing(e) || continue
			all(s[i[1], i[2]:e] .!= '#') || continue
			s[i[1], i[2]:e] .= circshift(s[i[1], i[2]:e], 1)
		elseif d == 'v'
			e = findnext(==('.'), s[:, i[2]], i[1])
			!isnothing(e) || continue
			all(s[i[1]:e, i[2]] .!= '#') || continue
			s[i[1]:e, i[2]] .= circshift(s[i[1]:e, i[2]], 1)
		elseif d == '^'
			e = findprev(==('.'), s[:, i[2]], i[1])
			!isnothing(e) || continue
			all(s[e:i[1], i[2]] .!= '#') || continue
			s[e:i[1], i[2]] .= circshift(s[e:i[1], i[2]], -1)
		else
			@assert false
		end
		i += dir[d]
	end
	return mapreduce(a -> 100 * a[1] + a[2], +, findall(s .== 'O') .- CartesianIndex(1, 1))
end

function main()
	f = (length(ARGS) > 0) ? ARGS[1] : "day15/ex15.txt"
	println("Day15a : ", day15a(f))
	println("Day15b : ", day15b(f))
end

main()
