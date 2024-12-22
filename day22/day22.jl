mix(n, m) = xor(n, m)
prune(n) = mod(n, 16777216)

function secret(n)
	n = prune(mix(64n, n))
	n = prune(mix(n÷32, n))
	n = prune(mix(2048n, n))
	return n
end

function day22b(f)
	s = parse.(Int, readlines(f))
	t = Vector{Int}[s]
	for _ = 1:2000
		s = secret.(s)
		push!(t, s)
	end
	p = mapreduce(r -> mod.(r, 10), hcat, t)
	d = diff(p; dims=2)
	K = 4
	mem = Dict{Vector{Int}, Vector{Int}}()
	fn = fill(0, size(d, 1))
	for h = 1:size(d, 1)
		r = d[h, :]
		for i = 1:2000-K+1
			q = r[i:i+K-1]
			e = copy(get(mem, q, fn))
			if e[h] == 0
				e[h] = p[h, i+K]
				mem[q] = e
			end
		end
	end
	return maximum(kv -> sum(kv[2]), mem)
end

function day22a(f)
	s = parse.(Int, readlines(f))
	for _ = 1:2000
		s = secret.(s)
	end
	return sum(s)
end

function main()
	f = (length(ARGS) > 0) ? ARGS[1] : "day22/ex22.txt"
	println("Day22a : ", day22a(f))
	println("Day22b : ", day22b(f))
end

main()
