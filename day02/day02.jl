function day02b(f)
	function safe(di)
		sg = sign.(di)
		allequal(sg) && sg[1] != 0 && all(abs.(di) .<= 3)
	end

	sum(broadcast(readlines(f)) do s
		t = parse.(Int, split(s))
		di = diff(t)
		sg = sign.(di)
		err0 = (abs.(di) .> 3)
		err1 = (sg .!= sg[1])

		e0, e1 = sum(err0), sum(err1)
		if e0 == 0 && e1 == 0
			return sg[1] != 0
		elseif e0 <= 1
			for i = 2:length(di)
				dn = di[i]
				# di[i-1] + di[i] = t[i+1] - t[i-1]
				di[i-1] += dn
				di[i] = sign(di[i-1])
				safe(di) && return true
				di[i] = dn
				di[i-1] -= dn
			end
			return safe(di[2:length(di)]) || safe(di[1:length(di)-1])
		else
			return false
		end
	end)
end

function day02a(f)
	sum(broadcast(readlines(f)) do s
		t = parse.(Int, split(s))
		di = diff(t)
		sg = sign.(di)
		allequal(sg) && sg[1] != 0 && all(abs.(di) .<= 3)
	end)
end

function main()
	f = (length(ARGS) > 0) ? ARGS[1] : "day02/ex02.txt"
	println("Day02a : ", day02a(f))
	println("Day02b : ", day02b(f))
end

main()
