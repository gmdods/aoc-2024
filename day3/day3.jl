function mul(s, r)
	s[r.stop + 1] == '(' || return nothing
	t = findnext(!isdigit, s, r.stop + 2)
	!isnothing(t) || return nothing
	s[t] == ',' || return nothing
	e = findnext(!isdigit, s, t+1)
	!isnothing(e) || return nothing
	s[e] == ')' || return nothing
	lhs = parse(Int, s[r.stop+2:t-1])
	rhs = parse(Int, s[t+1:e-1])
	(;lhs, rhs)
end

function day3b(f)
	s = read(f, String)
	a = 0
	does = findall("do()", s)
	dont = findall("don't()", s)
	for r = findall("mul", s)
		stop = findlast(d -> d.stop < r.start, dont)
		redo = findlast(d -> d.stop < r.start, does)
		!isnothing(stop) && isnothing(redo) && continue
		!isnothing(stop) && !isnothing(redo) &&
			dont[stop].stop >= does[redo].stop && continue

		m = mul(s, r)
		!isnothing(m) || continue
		a += m.lhs * m.rhs
	end
	return a
end

function day3a(f)
	s = read(f, String)
	a = 0
	for r = findall("mul", s)
		m = mul(s, r)
		!isnothing(m) || continue
		a += m.lhs * m.rhs
	end
	return a
end

function main()
	f = (length(ARGS) > 0) ? ARGS[1] : "day3/ex3a.txt"
	println("Day3a : ", day3a(f))
	f = (length(ARGS) > 0) ? ARGS[1] : "day3/ex3b.txt"
	println("Day3b : ", day3b(f))
end

main()
