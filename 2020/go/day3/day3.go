package main

import (
	"fmt"

	"github.com/thepsadmin/adventofcode/2020/go/utils"
)

func main() {
	fmt.Println(Part1(utils.ParseFileS("../inputs/day3")))
	fmt.Println(Part2(utils.ParseFileS("../inputs/day3")))
}

// func parseInput(input []string) [][]byte {

// }

func Part1(input []string) int {
	return traverseSlope(input, 3, 1)

}

func Part2(input []string) int {
	result := traverseSlope(input, 1, 1)
	result = result * traverseSlope(input, 3, 1)
	result = result * traverseSlope(input, 5, 1)
	result = result * traverseSlope(input, 7, 1)
	result = result * traverseSlope(input, 1, 2)
	return result
}

func traverseSlope(input []string, right int, down int) int {
	treecount := 0
	rpos := right
	for i := 1; i < len(input); i++ {
		i = i + (down - 1)
		if []byte(input[i])[rpos] == '#' {
			treecount = treecount + 1
		}
		rpos = rpos + right
		if rpos >= len(input[0]) {
			rpos = rpos - len(input[0])
		}

	}
	return treecount
}
