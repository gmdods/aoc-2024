function day9b(f)
	s = parse.(Int, collect(readlines(f)[1]))
	w = s[1:2:end]
	d = s[2:2:end]
	p = fill.(0:length(w)-1, w)
	q = reshape(permutedims([p fill.(nothing, [d; 0])]), length(s)+1)
	for id = length(w)-1:-1:0
		i = findfirst(t -> !isempty(t) && t[1] == id, q)
		r = q[i]
		!all(isnothing, r) || continue
		e = length(r)
		j = findfirst(t -> all(isnothing, t) && length(t) >= e, q)
		!isnothing(j) || continue
		j < i || continue
		q[i] = fill(nothing, length(r))
		if i != length(q) && all(isnothing, q[i+1])
			append!(q[i], popat!(q, i+1))
		end
		if i != 1 && all(isnothing, q[i-1])
			append!(q[i-1], popat!(q, i))
		end
		u = q[j]
		q[j] = r
		insert!(q, j+1, fill(nothing, length(u) - e))
	end
	g = something.(reduce(vcat, q), 0)
	return sum(g .* (0:length(g)-1))
end

function day9a(f)
	s = parse.(Int, collect(readlines(f)[1]))
	a = accumulate(+, s)
	w = s[1:2:end]
	e = findfirst(>(sum(w)), a)
	d = s[2:2:e]
	q = reduce(vcat, fill.(0:length(w)-1, w))
	t = reverse!(q[end+1-sum(d):end])
	u = q[1:end-sum(d)]

	g = zeros(Int, sum(w))
	b = 0
	tl, ul = 0, 0
	for i = 1:length(s[1:2:e])-1
		g[b+1:b+w[i]] .=  u[ul+1:ul+w[i]]
		b += w[i]
		g[b+1:b+d[i]] .=  t[tl+1:tl+d[i]]
		b += d[i]
		ul += w[i]
		tl += d[i]
	end
	g[b+1:end] .=  u[ul+1:end]
	return sum(g .* (0:length(g)-1))
end

function main()
	f = (length(ARGS) > 0) ? ARGS[1] : "day9/ex9.txt"
	println("Day9a : ", day9a(f))
	println("Day9b : ", day9b(f))
end

main()
