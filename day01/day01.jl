# using DataStructures
function counter(a)
	local d = Dict{Int, Int}()
	for elt in a; d[elt] = get(d, elt, 0) + 1 end
	return d
end

function day01b(f)
	t = broadcast(readlines(f)) do s
		s = split(s)
		(parse(Int, s[1]), parse(Int, s[2]))
	end
	t1 = broadcast(p -> p[1], t)
	t2 = broadcast(p -> p[2], t)
	c = counter(t2)
	sum(t1 .* broadcast(n -> get(c, n, 0), t1))
end

function day01a(f)
	t = broadcast(readlines(f)) do s
		s = split(s)
		(parse(Int, s[1]), parse(Int, s[2]))
	end
	t1 = broadcast(p -> p[1], t)
	t2 = broadcast(p -> p[2], t)
	sum(abs.(sort!(t1) .- sort!(t2)))
end

function main()
	f = (length(ARGS) > 0) ? ARGS[1] : "day01/ex01.txt"
	println("Day01a : ", day01a(f))
	println("Day01b : ", day01b(f))
end

main()
