function day24b(f)
	fs = readlines(f)
	i = findfirst(isempty, fs)
	m = Dict(broadcast(fs[i+1:end]) do r
		m = match(r"([a-z\d]+) ([A-Z]+) ([a-z\d]+) -> ([a-z\d]+)", r)
		c = m.captures
		c[4] => (c[2], c[1], c[3])
	end)

	K = nothing
	function it(op, x, y)
		for (k, v) = pairs(m)
			v[1] == op || continue
			(x, y) == v[2:3] && return k
			(y, x) == v[2:3] && return k
			if x in v || y in v
				if isnothing(K)
					K = (x, y, v)
					throw("SWAP")
				end
				return k
			end
		end
		throw("ERROR: $op($x, $y)")
	end

	function ha(x, y)
		s0 = it("XOR", x, y)
		c0 = it("AND", x, y)
		s0, c0
	end
	function fa(x, y, c)
		s0, c0 = ha(x, y)
		s1, c1 = ha(s0, c)
		s1, it("OR", c1, c0)
	end

	mcopy = deepcopy(m)
	swaps = AbstractString[]
	function csa(n::Int)
		s, c = ha("x00", "y00")
		for i = 1:n-1
			idx = string(i; pad=2)
			z = 'z'*idx
			s, c0 = fa('x'*idx, 'y'*idx, c)
			while s[1] != 'z'
				a = m[s]; b = m[z]
				# println('z' => (s => a, z => b))
				push!(swaps, s, z)
				m[s] = b; m[z] = a
				s, c0 = fa('x'*idx, 'y'*idx, c)
			end
			c = c0
			@assert s == z
		end
		@assert c == 'z'*string(n; pad=2)
	end
	try
		csa(45)
	catch
		m = mcopy
		empty!(swaps)
		(x, y, v) = K
		if x == v[2]
			s = y; z = v[3]
		elseif x == v[3]
			s = y; z = v[2]
		elseif y == v[2]
			s = x; z = v[3]
		elseif y == v[3]
			s = x; z = v[2]
		end
		a = m[s]; b = m[z]
		# println('z' => (s => a, z => b))
		push!(swaps, s, z)
		m[s] = b; m[z] = a
		csa(45)
	end
	return join(sort!(swaps), ',')
end

function day24a(f)
	fs = readlines(f)
	i = findfirst(isempty, fs)
	t = Dict(broadcast(fs[1:i-1]) do r
		m = match(r"([a-z\d]+): (\d+)", r)
		c = m.captures
		c[1] => parse(Int, c[2])
	end)
	m = Dict(broadcast(fs[i+1:end]) do r
		m = match(r"([a-z\d]+) ([A-Z]+) ([a-z\d]+) -> ([a-z\d]+)", r)
		c = m.captures
		c[4] => (c[2], c[1], c[3])
	end)
	function _recur(s::AbstractString)
		if haskey(t, s); return t[s] end

		p = m[s]
		lhs = _recur(p[2])
		rhs = _recur(p[3])

		if p[1] == "OR"
			a = lhs | rhs
		elseif p[1] == "XOR"
			a = xor(lhs,  rhs)
		elseif p[1] == "AND"
			a = lhs & rhs
		else
			@assert false
		end

		t[s] = a
		return a
	end
	c = [_recur(k) for k = sort!(collect(keys(m))) if k[1] == 'z']
	return evalpoly(2, c)
end

function main()
	f = (length(ARGS) > 0) ? ARGS[1] : "day24/ex24.txt"
	println("Day24a : ", day24a(f))
	println("Day24b : ", day24b(f))
end

main()
