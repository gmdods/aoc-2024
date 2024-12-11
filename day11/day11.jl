# using DataStructures
function counter(a)
	local d = Dict{Int, Int}()
	for elt in a; d[elt] = get(d, elt, 0) + 1 end
	return d
end

function blink(n::Int)
	n == 0 && return [1]
	d = Int(floor(log10(n)))
	(h, r) = divrem(d + 1, 2)
	if r == 0
		return collect(divrem(n, 10^h))
	end
	return [n * 2024]
end

function day11b(f)
	s = parse.(Int, split(readlines(f)[1]))
	K = 30
	for i = 1:K
		s = mapreduce(blink, vcat, s)
	end
	c = counter(s)
	Threads.@threads for r = collect(keys(c))
		a = r
		for i = (K+1):2K
			r = mapreduce(blink, vcat, r)
		end
		d = counter(r)
		for t = collect(keys(d))
			b = t
			for i = (2K+1):75
				t = mapreduce(blink, vcat, t)
			end
			d[b] = d[b] * length(t)
		end
		c[a] = c[a] * sum(values(d))
	end
	return sum(values(c))
end

function day11a(f)
	s = parse.(Int, split(readlines(f)[1]))
	for i = 1:25
		s = mapreduce(blink, vcat, s)
	end
	return length(s)
end

function main()
	f = (length(ARGS) > 0) ? ARGS[1] : "day11/ex11.txt"
	println("Day11a : ", day11a(f))
	println("Day11b : [slow: uncomment in file]")
	# println("Day11b : ", day11b(f))
end

main()
