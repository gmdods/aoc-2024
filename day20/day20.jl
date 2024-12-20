const g = typemax(Int)
const dir = [CartesianIndex(1, 0), CartesianIndex(0, 1),
		CartesianIndex(-1, 0), CartesianIndex(0, -1)]

function shortest(m, init)
	dist = fill(g, size(m))
	dist[init] = 0
	for _ = 2:length(m) # Bellman-Ford
		for v = eachindex(IndexCartesian(), m)
			for d = dir
				checkbounds(Bool, m, v + d) || continue
				m[v + d] && continue
				if dist[v] < dist[v + d] - 1
					dist[v + d] = dist[v] + 1
				end
			end

		end
	end
	return dist
end

Base.abs(a::CartesianIndex) = sum(abs.(a.I))

function day20b(f)
	s = mapreduce(collect, hcat, readlines(f)) |> permutedims
	init = findfirst(s .== 'S')
	fin = findfirst(s .== 'E')
	m = s .== '#'

	goal = shortest(m, fin)
	dist = shortest(m, init)
	vs = findall(!, m)

	local a = 0
	for v = vs
		for u = vs
			d = abs(u - v)
			d <= 20 || continue
			sv = dist[fin] - (dist[v] + goal[u] + d)
			a += (sv >= 100)
		end
	end
	return a
end

function day20a(f)
	s = mapreduce(collect, hcat, readlines(f)) |> permutedims
	init = findfirst(s .== 'S')
	fin = findfirst(s .== 'E')
	m = s .== '#'

	goal = shortest(m, fin)
	dist = shortest(m, init)
	save = zeros(Int, size(m))
	for v = findall(m)
		c = minimum(goal[v + d] for d = dir if checkbounds(Bool, m, v + d))
		c != g || continue
		t = minimum(dist[v + d] for d = dir if checkbounds(Bool, m, v + d))
		t != g || continue
		save[v] = dist[fin] - (c + t + 2)
	end
	return sum(save .>= 100)
end

function main()
	f = (length(ARGS) > 0) ? ARGS[1] : "day20/ex20.txt"
	println("Day20a : ", day20a(f))
	println("Day20b : ", day20b(f))
end

main()
