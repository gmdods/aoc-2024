const g = typemax(Int)
const dir = [CartesianIndex(1, 0), CartesianIndex(0, 1),
		CartesianIndex(-1, 0), CartesianIndex(0, -1)]

function shortest(m)
	fin = CartesianIndex(size(m)...)
	dist = fill(g, size(m)...)
	dist[1, 1] = 0
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
	return dist[fin]
end

function day18b(f)
	s = broadcast(readlines(f)) do r
		m = match(r"(\d+),(\d+)", r)
		CartesianIndex((1 .+ parse.(Int, m.captures))...)
	end
	m = falses(maximum(r -> r[1], s), maximum(r -> r[2], s))
	K = 1024
	m[s[1:K]] .= true

	for j = 1:100:lastindex(s)-K
		m[s[K:K+j]] .= true
		shortest(m) == g || continue
		for i = 0:100
			m[s[K+j-i]] = false
			shortest(m) != g || continue
			return join(s[K+j-i].I .- (1, 1), ',')
		end
	end
end

function day18a(f)
	s = broadcast(readlines(f)) do r
		m = match(r"(\d+),(\d+)", r)
		CartesianIndex((1 .+ parse.(Int, m.captures))...)
	end
	m = falses(maximum(r -> r[1], s), maximum(r -> r[2], s))
	K = 1024
	m[s[1:K]] .= true
	return shortest(m)
end

function main()
	f = (length(ARGS) > 0) ? ARGS[1] : "day18/ex18.txt"
	println("Day18a : ", day18a(f))
	println("Day18b : ", day18b(f))
end

main()
