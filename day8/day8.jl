function day8b(f)
	s = reduce(hcat, collect.(filter(!isempty, readlines(f))))
	anti = falses(size(s))
	for c = filter!(!=('.'), unique(s))
		m = findall(c .== s)
		for i = 1:length(m)
			for j = i+1:length(m)
				d = m[i] - m[j]
				# d = CartesianIndex(div.(d.I, gcd(d.I...))...)
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

function day8a(f)
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
	f = (length(ARGS) > 0) ? ARGS[1] : "day8/ex8.txt"
	println("Day8a : ", day8a(f))
	println("Day8b : ", day8b(f))
end

main()
