all: day1 day2 day3 day4 day5 day6 day7

.PHONY: day1
day1:
	julia day1/day1.jl day1/day1.txt

.PHONY: day2
day2:
	julia day2/day2.jl day2/day2.txt

.PHONY: day3
day3:
	julia day3/day3.jl day3/day3.txt

.PHONY: day4
day4:
	julia day4/day4.jl day4/day4.txt

.PHONY: day5
day5:
	julia day5/day5.jl day5/day5.txt

.PHONY: day6
day6:
	julia day6/day6.jl day6/day6.txt

.PHONY: day7
day7:
	julia day7/day7.jl day7/day7.txt

