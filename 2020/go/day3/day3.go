package main

import (
	"fmt"

	"github.com/thepsadmin/adventofcode/2020/go/utils"
)

func main() {
	fmt.Println(Part1(utils.ParseFileS("../inputs/day3")))
}

// func parseInput(input []string) [][]byte {

// }

func Part1(input []string) int {
	treecount := 0
	rpos := 3
	for i := 1; i < len(input); i++ {
		if []byte(input[i])[rpos] == '#' {
			treecount = treecount + 1
		}
		rpos = rpos + 3
		if rpos >= len(input[0]) {
			rpos = rpos - len(input[0])
		}

	}
	return treecount
}
