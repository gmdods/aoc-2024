function day19b(f)
	s = readlines(f)
	@assert isempty(s[2])

	pat = strip.(split(s[1], ','))
	mem = Dict{AbstractString, Int}()
	function possibility(d::AbstractString)
		if haskey(mem, d); return mem[d] end
		isempty(d) && return 1
		local a = 0
		for p = pat
			startswith(d, p) || continue
			a += possibility(chopprefix(d, p))
		end
		mem[d] = a
		return a
	end
	sum(possibility.(s[3:end]))
end

function day19a(f)
	s = readlines(f)
	@assert isempty(s[2])

	pat = strip.(split(s[1], ','))
	function possible(d::AbstractString)
		isempty(d) && return true
		for p = pat
			startswith(d, p) || continue
			possible(chopprefix(d, p)) || continue
			return true
		end
		return false
	end
	sum(possible.(s[3:end]))
end

function main()
	f = (length(ARGS) > 0) ? ARGS[1] : "day19/ex19.txt"
	println("Day19a : ", day19a(f))
	println("Day19b : ", day19b(f))
end

main()
