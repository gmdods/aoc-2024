all: day01 day02 day03 day04 day05 day06 day07 day08 day09 day10 day11

.PHONY: day01
day01:
	julia day01/day01.jl day01/day01.txt

.PHONY: day02
day02:
	julia day02/day02.jl day02/day02.txt

.PHONY: day03
day03:
	julia day03/day03.jl day03/day03.txt

.PHONY: day04
day04:
	julia day04/day04.jl day04/day04.txt

.PHONY: day05
day05:
	julia day05/day05.jl day05/day05.txt

.PHONY: day06
day06:
	julia day06/day06.jl day06/day06.txt

.PHONY: day07
day07:
	julia day07/day07.jl day07/day07.txt

.PHONY: day08
day08:
	julia day08/day08.jl day08/day08.txt

.PHONY: day09
day09:
	julia day09/day09.jl day09/day09.txt

.PHONY: day10
day10:
	julia day10/day10.jl day10/day10.txt

.PHONY: day11
day11:
	julia --threads 8 day11/day11.jl day11/day11.txt

.PHONY: day12
day12:
	julia day12/day12.jl day12/day12.txt

