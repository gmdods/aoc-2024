function day13b(f)
	fs = filter!(!isempty, readlines(f))
	s = reshape(fs, (3, length(fs)÷3))
	t = broadcast(s) do r
		m = match(r".*: X[+=](\d+), Y[+=](\d+)", r)
		parse.(Int, m.captures)
	end
	return sum(broadcast(eachcol(t)) do c
		a, b, p = c
		p .+= 10_000_000_000_000
		x = Int.(round.([a b] \ p))
		if [a b] * x == p
			([3 1] * x)[1]
		else
			0
		end
	end)
end

function day13a(f)
	fs = filter!(!isempty, readlines(f))
	s = reshape(fs, (3, length(fs)÷3))
	t = broadcast(s) do r
		m = match(r".*: X[+=](\d+), Y[+=](\d+)", r)
		parse.(Int, m.captures)
	end
	return sum(broadcast(eachcol(t)) do c
		a, b, p = c
		x = Int.(round.([a b] \ p))
		if [a b] * x == p
			@assert sum(x) <= 200
			([3 1] * x)[1]
		else
			0
		end
	end)
end

function main()
	f = (length(ARGS) > 0) ? ARGS[1] : "day13/ex13.txt"
	println("Day13a : ", day13a(f))
	println("Day13b : ", day13b(f))
end

main()
