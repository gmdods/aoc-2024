# using DataStructures
function counter(a)
	local d = Dict{Int, Int}()
	for elt in a; d[elt] = get(d, elt, 0) + 1 end
	return d
end

function day1b(f)
	t = broadcast(readlines(f)) do s
		s = split(s)
		(parse(Int, s[1]), parse(Int, s[2]))
	end
	t1 = broadcast(p -> p[1], t)
	t2 = broadcast(p -> p[2], t)
	c = counter(t2)
	sum(t1 .* broadcast(n -> get(c, n, 0), t1))
end

function day1a(f)
	t = broadcast(readlines(f)) do s
		s = split(s)
		(parse(Int, s[1]), parse(Int, s[2]))
	end
	t1 = broadcast(p -> p[1], t)
	t2 = broadcast(p -> p[2], t)
	sum(abs.(sort!(t1) .- sort!(t2)))
end

function main()
	f = (length(ARGS) > 0) ? ARGS[1] : "day1/ex1.txt"
	println("Day1a : ", day1a(f))
	println("Day1b : ", day1b(f))
end

main()
