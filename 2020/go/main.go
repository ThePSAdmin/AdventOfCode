package main

import (
	"fmt"

	day1 "github.com/thepsadmin/adventofcode/2020/go/day1"
)

func main() {
	day1p1result, _ := day1.GetResult("inputs/day1")
	fmt.Printf("Day 1 Part 1: %v \n", day1p1result)

	day1p2result, _ := day1.GetResultPart2("inputs/day1")
	fmt.Printf("Day 1 Part 2: %v \n", day1p2result)
}
