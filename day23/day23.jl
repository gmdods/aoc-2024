function day23b(f)
	e = Dict{String, Vector{String}}()
	for s = split.(readlines(f), '-')
		push!(get!(e, s[1], String[]), s[2])
		push!(get!(e, s[2], String[]), s[1])
	end
	cliq = Set{String}()
	for v = keys(e)
		c = Set{String}([v])
		for n = e[v] # Greedy
			all(n in e[t] for t = c) || continue
			push!(c, n)
		end
		if length(c) > length(cliq)
			cliq = c
		end
	end
	return join(sort!(collect(cliq)), ',')
end

function day23a(f)
	e = Dict{String, Vector{String}}()
	for s = split.(readlines(f), '-')
		push!(get!(e, s[1], String[]), s[2])
		push!(get!(e, s[2], String[]), s[1])
	end
	tri = Set{Set{String}}()
	for v = keys(e)
		't' == v[1] || continue
		n = e[v]
		for i = 1:length(n) # Brute-force
			for j = i+1:length(n)
				n[i] in e[n[j]] || continue
				n[j] in e[n[i]] || continue
				push!(tri, Set([v, n[i], n[j]]))
			end
		end
	end
	return length(tri)
end

function main()
	f = (length(ARGS) > 0) ? ARGS[1] : "day23/ex23.txt"
	println("Day23a : ", day23a(f))
	println("Day23b : ", day23b(f))
end

main()
