function day08b(f)
	s = reduce(hcat, collect.(filter(!isempty, readlines(f))))
	anti = falses(size(s))
	for c = filter!(!=('.'), unique(s))
		m = findall(c .== s)
		for i = 1:length(m)
			for j = i+1:length(m)
				d = m[i] - m[j]
				# d = CartesianIndex0(div.(d.I, gcd(d.I...))...)
				a = m[i]
				while checkbounds(Bool, anti, a);
					anti[a] = true
					a -= d
				end
				a = m[i]
				while checkbounds(Bool, anti, a);
					anti[a] = true
					a += d
				end
			end
		end
	end
	return sum(anti)
end

function day08a(f)
	s = reduce(hcat, collect.(filter(!isempty, readlines(f))))
	anti = falses(size(s))
	for c = filter!(!=('.'), unique(s))
		m = findall(c .== s)
		for i = 1:length(m)
			for j = i+1:length(m)
				d = m[i] - m[j]
				a = m[j] - d
				b = d + m[i]
				if checkbounds(Bool, anti, a);
					anti[a] = true
				end
				if checkbounds(Bool, anti, b);
					anti[b] = true
				end
			end
		end
	end
	return sum(anti)
end

function main()
	f = (length(ARGS) > 0) ? ARGS[1] : "day08/ex08.txt"
	println("Day08a : ", day08a(f))
	println("Day08b : ", day08b(f))
end

main()
