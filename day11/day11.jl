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
	d = Dict{Int, Dict{Int, Int}}()
	K = 15
	function blink_chunk(r::Int)
		v = get(d, r, nothing)
		if !isnothing(v)
			return v
		end
		t = [r]
		for i = 1:K
			t = mapreduce(blink, vcat, t)
		end
		c = counter(t)
		d[r] = c
		return c
	end
	function recur(r::Int, N)
		N <= 0 && return 1
		c = blink_chunk(r)
		n = 0
		for (t, v) = pairs(c)
			n += v * recur(t, N - K)
		end
		return n
	end
	a = Threads.Atomic{Int}(0)
	Threads.@threads for r = s
		Threads.atomic_add!(a, recur(r, 75))
	end
	return a[]
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
	print("Day11b : [30s] ")
	println(day11b(f))
end

main()
