all: day1 day2

.PHONY: day1
day1:
	julia day1/day1.jl day1/day1.txt

.PHONY: day2
day2:
	julia day2/day2.jl day2/day2.txt
