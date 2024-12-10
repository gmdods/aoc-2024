function day10b(f)
	s = reduce(hcat, broadcast(t -> parse.(Int, t),
				collect.(filter(!isempty, readlines(f)))))
	d = [
		CartesianIndex(1, 0),
		CartesianIndex(-1, 0),
		CartesianIndex(0, 1),
		CartesianIndex(0, -1),
	]
	function forward(inds, n::Int64)
		filter!(i -> checkbounds(Bool, s, i), inds)
		inds[findall(s[inds] .== n)]
	end
	sum(broadcast(findall(s .== 0)) do r
		t = [r]
		for n = 1:9
			t = reduce(vcat, [forward(e .+ d, n) for e in t]; init=[])
		end
		length(t) # only difference
	end)

end

function day10a(f)
	s = reduce(hcat, broadcast(t -> parse.(Int, t),
				collect.(filter(!isempty, readlines(f)))))
	d = [
		CartesianIndex(1, 0),
		CartesianIndex(-1, 0),
		CartesianIndex(0, 1),
		CartesianIndex(0, -1),
	]
	function forward(inds, n::Int64)
		filter!(i -> checkbounds(Bool, s, i), inds)
		inds[findall(s[inds] .== n)]
	end
	sum(broadcast(findall(s .== 0)) do r
		t = [r]
		for n = 1:9
			t = reduce(vcat, [forward(e .+ d, n) for e in t]; init=[])
		end
		length(unique!(t))
	end)
end

function main()
	f = (length(ARGS) > 0) ? ARGS[1] : "day10/ex10.txt"
	println("Day10a : ", day10a(f))
	println("Day10b : ", day10b(f))
end

main()
