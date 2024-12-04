function day4b(f)
	s = reduce(hcat, collect.(readlines(f)))
	sum(broadcast(findall(s .== 'A')) do r
		dirs = [
			CartesianIndex.(r[1]-1:r[1]+1, r[2]-1:r[2]+1),
			CartesianIndex.(r[1]+1:-1:r[1]-1, r[2]-1:r[2]+1),
			CartesianIndex.(r[1]+1:-1:r[1]-1, r[2]+1:-1:r[2]-1),
			CartesianIndex.(r[1]-1:r[1]+1, r[2]+1:-1:r[2]-1),
		]
		t = [checkbounds(Bool, s, d) && join(s[d]) == "MAS" for d = dirs]
		sum([ t[1] & t[2], t[1] & t[4], t[3] & t[2], t[3] & t[4] ])
	end)
end

function day4a(f)
	s = reduce(hcat, collect.(readlines(f)))
	sum(broadcast(findall(s .== 'X')) do r
		dirs = [
			CartesianIndex.(r[1]:r[1]+3, r[2]),
			CartesianIndex.(r[1]:-1:r[1]-3, r[2]),
			CartesianIndex.(r[1], r[2]:r[2]+3),
			CartesianIndex.(r[1], r[2]:-1:r[2]-3),
			CartesianIndex.(r[1]:r[1]+3, r[2]:r[2]+3),
			CartesianIndex.(r[1]:-1:r[1]-3, r[2]:r[2]+3),
			CartesianIndex.(r[1]:-1:r[1]-3, r[2]:-1:r[2]-3),
			CartesianIndex.(r[1]:r[1]+3, r[2]:-1:r[2]-3),
		]
		sum(join(s[d]) == "XMAS" for d = dirs if checkbounds(Bool, s, d);init=0)
	end)
end

function main()
	f = (length(ARGS) > 0) ? ARGS[1] : "day4/ex4.txt"
	println("Day4a : ", day4a(f))
	println("Day4b : ", day4b(f))
end

main()
