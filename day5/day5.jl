function day5b(f)
	s = readlines(f)
	i = findfirst(isempty, s)
	rule = broadcast(split.(s[1:i-1], '|')) do r
		parse(Int, r[1]), parse(Int, r[2])
	end
	ref = sort!(unique!([map(t -> t[1], rule); map(t -> t[2], rule)]))
	n = length(ref)
	c = falses(n, n)
	for r = rule
		t = map(a -> findfirst(==(a), ref)::Int, r)
		c[CartesianIndex(t)] = true
	end
	@assert all(t -> t[1] == t[2], findall(.!(c .| c'))) # closure

	sum(broadcast(s[i+1:end]) do u
		up = parse.(Int, split(u, ','))
		ord = sort(up; lt = function(a, b)
			ia = findfirst(>=(a), ref)
			!isnothing(ia) || return 0
			ib = findfirst(>=(b), ref)
			!isnothing(ib) || return 1
			c[ia, ib]
		end)
		ord != up || return 0
		ord[1+length(up)÷2]
	end)
end

function day5a(f)
	s = readlines(f)
	i = findfirst(isempty, s)
	rule = broadcast(split.(s[1:i-1], '|')) do r
		parse(Int, r[1]), parse(Int, r[2])
	end
	sum(broadcast(s[i+1:end]) do u
		up = parse.(Int, split(u, ','))
		for (a, b) = rule
			ia = findfirst(==(a), up)
			!isnothing(ia) || continue
			ib = findfirst(==(b), up)
			!isnothing(ib) || continue
			if ia > ib
				return 0
			end
		end
		up[1+length(up)÷2]
	end)
end

function main()
	f = (length(ARGS) > 0) ? ARGS[1] : "day5/ex5.txt"
	println("Day5a : ", day5a(f))
	println("Day5b : ", day5b(f))
end

main()
