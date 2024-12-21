const keypad0 = Dict(
	'A' => CartesianIndex(4, 3),
	'0' => CartesianIndex(4, 2),
	'1' => CartesianIndex(3, 1),
	'2' => CartesianIndex(3, 2),
	'3' => CartesianIndex(3, 3),
	'4' => CartesianIndex(2, 1),
	'5' => CartesianIndex(2, 2),
	'6' => CartesianIndex(2, 3),
	'7' => CartesianIndex(1, 1),
	'8' => CartesianIndex(1, 2),
	'9' => CartesianIndex(1, 3),
)

const keypad1 = Dict(
	'A' => CartesianIndex(1, 3),
	'^' => CartesianIndex(1, 2),
	'<' => CartesianIndex(2, 1),
	'v' => CartesianIndex(2, 2),
	'>' => CartesianIndex(2, 3),
)

Base.abs(a::CartesianIndex) = sum(abs.(a.I))

const dirs =  (Dict(1 => 'v', -1 => '^'), Dict(1 => '>', -1 => '<'))
const move =  Dict(
	'v' => CartesianIndex(1, 0),
	'^' => CartesianIndex(-1, 0),
	'>' => CartesianIndex(0, 1),
	'<' => CartesianIndex(0, -1),
	'A' => CartesianIndex(0, 0)
)

function route(fin::CartesianIndex{2}, init::CartesianIndex{2}; bad=CartesianIndex(1, 1))
	delta = fin - init
	ctrl = keypad1['A']
	dir = get.(dirs, sign.(delta.I), nothing)
	n = findall(!isnothing, dir)
	@assert sum(abs.(delta)) <= 4
	if length(n) == 0;
		return [['A']]
	elseif length(n) == 1
		i = n[1]
		return [ [fill(dir[i], abs(delta[i])); 'A'] ]
	else
		t1 = [fill(dir[1], abs(delta[1])); fill(dir[2], abs(delta[2])); 'A']
		t2 = [fill(dir[2], abs(delta[2])); fill(dir[1], abs(delta[1])); 'A']
		if any(accumulate((a, t) -> a + move[t], t1; init) .== bad)
			t1 = nothing
		end
		if any(accumulate((a, t) -> a + move[t], t2; init) .== bad)
			t2 = nothing
		end
		return filter(!isnothing, [ t1, t2 ])
	end
end

function day21b(f)
	bad = CartesianIndex(4, 1)

	mem = Dict{Tuple{String, Int}, Int}()
	function recur(r1::Vector{Char}, n::Int)
		n < 0 && return 1
		k = (String(r1), n)
		if haskey(mem, k); return mem[k] end
		i1 = keypad1['A']
		a1 = 0
		for c1 = r1
			a1 += minimum(route(keypad1[c1], i1)) do r2
				return recur(r2, n - 1)
			end
			i1 = keypad1[c1]
		end
		mem[k] = a1
		return a1
	end
	return sum(broadcast(readlines(f)) do s
		n = parse(Int, filter(isdigit, s))
		i0 = keypad0['A']
		a0 = 0
		for c0 = collect(s)
			a0 += minimum(route(keypad0[c0], i0; bad)) do r1
				return recur(r1, 25)
			end
			i0 = keypad0[c0]
		end
		a0 * n
	end)
end

function day21a(f)
	bad = CartesianIndex(4, 1)
	return sum(broadcast(readlines(f)) do s
		n = parse(Int, filter(isdigit, s))
		i0 = keypad0['A']
		a0 = 0
		for c0 = collect(s)
			a0 += minimum(route(keypad0[c0], i0; bad)) do r1
				i1 = keypad1['A']
				a1 = 0
				for c1 = r1
					a1 += minimum(route(keypad1[c1], i1)) do r2
						i2 = keypad1['A']
						a2 = 0
						for c2 = r2
							a2 += length(route(keypad1[c2], i2)[1])
							i2 = keypad1[c2]
						end
						return a2
					end
					i1 = keypad1[c1]
				end
				return a1
			end
			i0 = keypad0[c0]
		end
		a0 * n
	end)
end

function main()
	f = (length(ARGS) > 0) ? ARGS[1] : "day21/ex21.txt"
	println("Day21a : ", day21a(f))
	println("Day21b : ", day21b(f))
end

main()
