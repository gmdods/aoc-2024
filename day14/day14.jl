function day14b(f)
	s = broadcast(readlines(f)) do r
		m = match(r"p=(\d+),(\d+) v=(-?\d+),(-?\d+)", r)
		parse.(Int, m.captures)
	end
	n = mapreduce(r -> r[1], max, s) + 1
	m = mapreduce(r -> r[2], max, s) + 1

	function layout(Ind)
           w = falses(n, m)
	   w[Ind] .= true
           w
	end
	function move(r, t)
           v = (r[1], r[2]) .+ t .* (r[3], r[4])
           CartesianIndex(1 .+ mod.(v, (n, m)))
	end
	K = 10
	for t = 0:n*m
		w = layout(move.(s, t))
		if any([all(w[i-K:i, j]) for i = 1+K:n for j = 2:m-1])
			return t
		end
	end
	return -1
end

function day14a(f)
	s = broadcast(readlines(f)) do r
		m = match(r"p=(\d+),(\d+) v=(-?\d+),(-?\d+)", r)
		parse.(Int, m.captures)
	end
	n = mapreduce(r -> r[1], max, s) + 1
	m = mapreduce(r -> r[2], max, s) + 1
	w = zeros(Int, n, m)
	for r = s
		v = (r[1], r[2]) .+ 100 .* (r[3], r[4])
		w[CartesianIndex(1 .+ mod.(v, (n, m)))] += 1
	end
	sum(w[1:div(n, 2), 1:div(m, 2)]) *
	sum(w[1:div(n, 2), 1+m-div(m,2):m]) *
	sum(w[1+n-div(n, 2):n, 1+m-div(m,2):m]) *
	sum(w[1+n-div(n, 2):n, 1:div(m,2)])
end

function main()
	f = (length(ARGS) > 0) ? ARGS[1] : "day14/ex14.txt"
	println("Day14a : ", day14a(f))
	println("Day14b : ", day14b(f))
end

main()
