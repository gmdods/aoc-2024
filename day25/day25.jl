function day25(f)
	fs = readlines(f)
	i = findall(isempty, fs)
	keys, locks = Vector{Int}[], Vector{Int}[]
	for r = range.([0; i] .+ 1, [i .- 1; length(fs)])
		char = fs[r][1][1]
		height = [findlast(==(char), c) - 1
			for c = eachrow(mapreduce(collect, hcat, fs[r]))]
		if char == '#'
			push!(locks, height)
		else
			push!(keys, 5 .- height)
		end
	end
	return sum(all(k .+ l .<= 5) for l = locks for k = keys)
end

function main()
	f = (length(ARGS) > 0) ? ARGS[1] : "day25/ex25.txt"
	println("Day25 : ", day25(f))
end

main()
