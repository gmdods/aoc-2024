const d = [
	CartesianIndex(1, 0),
	CartesianIndex(-1, 0),
	CartesianIndex(0, 1),
	CartesianIndex(0, -1),
]

function regions(m)
	r = Dict{Int, Set{CartesianIndex}}()
	local t = Dict{CartesianIndex, Int}()
	local i = 0
	for f = findall(m)
		k = [t[g] for g = f .+ d
			if checkbounds(Bool, m, g) && haskey(t, g)]
		if length(k) == 0
			i += 1
			r[i] = Set{CartesianIndex{2}}([f])
			t[f] = i
		elseif length(k) == 1
			push!(r[k[1]], f)
			t[f] = k[1]
		else
			u = reduce(union, getindex.(Ref(r), k))
			push!(u, f)
			for a in k; delete!(r, a) end
			r[k[1]] = u
			for a in u; t[a] = k[1] end
		end
	end
	collect.(values(r))
end

const c = [
	CartesianIndex(1, 1) => (CartesianIndex(0, 1), CartesianIndex(1, 0)),
	CartesianIndex(1, -1) => (CartesianIndex(0, -1), CartesianIndex(1, 0)),
	CartesianIndex(-1, 1) => (CartesianIndex(0, 1), CartesianIndex(-1, 0)),
	CartesianIndex(-1, -1) => (CartesianIndex(0, -1), CartesianIndex(-1, 0)),
]

function day12b(f)
	s = reduce(hcat, collect.(filter(!isempty, readlines(f))))

	function corner(f, r)
		t = 0
		for (x, ds) = c
			diag, (lhs, rhs) = any(r .== f + x), [any(r .== f + di) for di = ds]
			t += ((lhs + rhs) != 2 || !diag) & ((lhs + rhs) % 2 == 0)
		end
		return t
	end
	a = 0
	for e = unique(s)
		m = s .== e
		for r::Vector{CartesianIndex} = regions(m)
			p = 0
			for f::CartesianIndex in r
				p += corner(f, r)
			end
			a += length(r) * p
		end
	end
	return a
end

function day12a(f)
	s = reduce(hcat, collect.(filter(!isempty, readlines(f))))
	function per(f, m)
		4 - sum(m[g] for g = f .+ d if checkbounds(Bool, m, g))
	end
	a = 0
	for e = unique(s)
		m = s .== e
		for r::Vector{CartesianIndex} = regions(m)
			p = 0
			for f::CartesianIndex in r
				p += per(f, m)
			end
			a += length(r) * p
		end
	end
	return a
end

function main()
	f = (length(ARGS) > 0) ? ARGS[1] : "day12/ex12.txt"
	println("Day12a : ", day12a(f))
	println("Day12b : ", day12b(f))
end

main()
