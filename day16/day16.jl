function day16b(f)
	s = reduce(hcat, collect.(filter(!isempty, readlines(f))))
	init = findfirst(s .== 'S')
	fin = findfirst(s .== 'E')
	m = s .!= '#'
	dir = [CartesianIndex(1, 0), CartesianIndex(-1, 0),
		CartesianIndex(0, 1), CartesianIndex(0, -1)]
	g = typemax(Int)
	mem = fill(g, size(m)..., 4)
	path = CartesianIndex{2}[]
	paths = []
	function recur(i::CartesianIndex{2}, a::Int, r::Int)::Int
		if mem[i, a] < r; return g end
		mem[i, a] = r
		if i == fin;
			push!(paths, r => copy(path))
			return r
		end
		push!(path, i)
		local v = g
		for d = 1:4
			if dir[d] != -dir[a] && m[i + dir[d]]
				vm = recur(i + dir[d], d, (((d == a) ? 1 : 1001) + r))
				if vm < v; v = vm end
			end
		end
		pop!(path)
		return v
	end
	v = recur(init, 2, 0) # East
	best = falses(size(m))
	for pair = paths
		pair[1] == v || continue
		best[pair[2]] .= true
	end
	return 1 + sum(best)
end

function day16a(f)
	s = reduce(hcat, collect.(filter(!isempty, readlines(f))))
	init = findfirst(s .== 'S')
	fin = findfirst(s .== 'E')
	m = s .!= '#'
	dir = [CartesianIndex(1, 0), CartesianIndex(-1, 0),
		CartesianIndex(0, 1), CartesianIndex(0, -1)]
	g = typemax(Int)
	mem = fill(g, size(m)..., 4)
	function recur(i::CartesianIndex{2}, a::Int, r::Int)::Int
		if mem[i, a] < r; return g end
		mem[i, a] = r
		if i == fin; return r end
		return minimum(recur(i + dir[d], d,
			(((d == a) ? 1 : 1001) + r))
			for d = 1:4 if dir[d] != -dir[a] && m[i + dir[d]]; init=g)
	end
	return recur(init, 2, 0) # East
end

function main()
	f = (length(ARGS) > 0) ? ARGS[1] : "day16/ex16.txt"
	println("Day16a : ", day16a(f))
	println("Day16b : ", day16b(f))
end

main()
