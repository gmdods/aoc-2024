function day07b(f)
	function recur(r::Int, t::Vector{Int})
		length(t) == 0 && return (r == 0)
		length(t) == 1 && return (r == t[1])
		rhs = t[end]
		(a, b) = divrem(r, rhs)
		if b == 0 && recur(a, t[1:end-1])
			return true
		end
		a = r - rhs
		if a >= 0 && recur(a, t[1:end-1])
			return true
		end
		b = string(rhs)
		a = string(r)
		prefix = chopsuffix(a, b)
		if prefix != a && recur(parse(Int, '0' * prefix), t[1:end-1])
			return true
		end
		return false
	end

	sum(broadcast(readlines(f)) do s
		p = split(s, ':')
		r = parse(Int, p[1])
		t = parse.(Int, split(p[2]))
		if recur(r, t)
			return r
		else
			return 0
		end
	end)
end

function day07a(f)
	function recur(r::Int, t::Vector{Int})
		length(t) == 0 && return (r == 0)
		length(t) == 1 && return (r == t[1])
		rhs = t[end]
		(a, b) = divrem(r, rhs)
		if b == 0 && recur(a, t[1:end-1])
			return true
		end
		a = r - rhs
		if a >= 0 && recur(a, t[1:end-1])
			return true
		end
		return false
	end

	sum(broadcast(readlines(f)) do s
		p = split(s, ':')
		r = parse(Int, p[1])
		t = parse.(Int, split(p[2]))
		if recur(r, t)
			return r
		else
			return 0
		end
	end)
end

function main()
	f = (length(ARGS) > 0) ? ARGS[1] : "day07/ex07.txt"
	println("Day07a : ", day07a(f))
	println("Day07b : ", day07b(f))
end

main()
