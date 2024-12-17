Base.@kwdef mutable struct M
	A::UInt
	B::UInt
	C::UInt
	I::UInt=0
end

function combo(m::M, rnd::UInt)
	if rnd in 0:3
		rnd
	elseif rnd == 4
		m.A
	elseif rnd == 5
		m.B
	elseif rnd == 6
		m.C
	else
		@assert false
	end
end

function instn(m::M, op::UInt, rnd::UInt)
	if op == 0 # adv
		m.A = m.A >> combo(m, rnd)
		m.I += 2
	elseif op == 1 # bxl
		m.B = xor(m.B, rnd)
		m.I += 2
	elseif op == 2 # bst
		m.B = combo(m, rnd) & 0x7
		m.I += 2
	elseif op == 3 # jnz
		m.I = (m.A == 0) ? m.I + 2 : rnd
	elseif op == 4 # bxc
		m.B = xor(m.B, m.C)
		m.I += 2
	elseif op == 5 # out
		m.I += 2
		return combo(m, rnd) & 0x7
	elseif op == 6 # bdv
		m.B = m.A >> combo(m, rnd)
		m.I += 2
	elseif op == 7 # cdv
		m.C = m.A >> combo(m, rnd)
		m.I += 2
	else
		@assert false
	end
	return nothing
end

function day17b(f)
	s = readlines(f)
	r = broadcast(s[1:end-2]) do r
		m = match(r"(\d+)", r)
		parse(UInt, m.captures[1])
	end
	p = parse.(UInt, [m.captures[1] for m = eachmatch(r"(\d+)", s[end])])

	@assert p[end-5] == 0
	@assert p[end-4] == 3
	@assert p[end-3] == 5
	@assert p[end-1] == 3
	@assert p[end] == 0

	function machine(a::Int)
		m = M(A=a, B=r[2], C=r[3])
		out = UInt[]
		while m.I < length(p)
			o = instn(m, p[1+m.I],p[2+m.I])
			if !isnothing(o); push!(out, o) end
		end
		return out
	end

	function recur(i::Int, r::Int)
		i > 0 || return r
		for k = 0:7
			c = (r << 3) | k
			if machine(c) == p[i:end]
				t = recur(i - 1, c)
				if !isnothing(t)
					return t
				end
			end
		end
		return nothing
	end
	a = recur(length(p), 0)
	@assert machine(a) == p
	return a
end

function day17a(f)
	s = readlines(f)
	r = broadcast(s[1:end-2]) do r
		m = match(r"(\d+)", r)
		parse(UInt, m.captures[1])
	end
	p = parse.(UInt, [m.captures[1] for m = eachmatch(r"(\d+)", s[end])])

	m = M(A=r[1], B=r[2], C=r[3])
	out = UInt[]
	while m.I < length(p)
		o = instn(m, p[1+m.I],p[2+m.I])
		if !isnothing(o); push!(out, o) end
	end
	return join(out, ',')
end

function main()
	f = (length(ARGS) > 0) ? ARGS[1] : "day17/ex17.txt"
	println("Day17a : ", day17a(f))
	println("Day17b : ", day17b(f))
end

main()
