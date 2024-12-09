function path(s)
	n,m = size(s)
	local dir0 = falses(n,m)
	local dir1 = falses(n,m)
	local dir2 = falses(n,m)
	local dir3 = falses(n,m)
	local dir = 0
	local i = findfirst(s .== '^')
	t = ==('#')
	while !(i[1] in (1, n) || i[2] in (1, m))
		if dir == 0
			b = 1 + something(findprev(t,  s[i[1], :], i[2]), 0)
			if dir0[i[1], b]; return nothing end
			dir0[i[1], b:i[2]] .= true
			i = CartesianIndex(i[1], b)
		elseif dir == 1
			b = -1 + something(findnext(t,  s[:, i[2]], i[1]), n+1)
			if dir1[b, i[2]]; return nothing end
			dir1[i[1]:b, i[2]] .= true
			i = CartesianIndex(b, i[2])
		elseif dir == 2
			b = -1 + something(findnext(t,  s[i[1], :], i[2]), m+1)
			if dir2[i[1], b]; return nothing end
			dir2[i[1], i[2]:b] .= true
			i = CartesianIndex(i[1], b)
		elseif dir == 3
			b = 1 + something(findprev(t, s[:, i[2]], i[1]), 0)
			if dir3[b, i[2]]; return nothing end
			dir3[b:i[1], i[2]] .= true
			i = CartesianIndex(b, i[2])
		end
		dir = mod(dir + 1, 4)
	end
	return sum(dir0 .| dir1 .| dir2 .| dir3)

end

function day06b(f)
	s = reduce(hcat, collect.(filter(!isempty, readlines(f))))

	sum(broadcast(findall(s .== '.')) do u
		s[u] = '#'
		t = isnothing(path(s))
		s[u] = '.'
		t
	end)
end

function day06a(f)
	s = reduce(hcat, collect.(filter(!isempty, readlines(f))))
	return path(s)
end

function main()
	f = (length(ARGS) > 0) ? ARGS[1] : "day06/ex06.txt"
	println("Day06a : ", day06a(f))
	println("Day06b : ", day06b(f))
end

main()
