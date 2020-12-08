package main

import (
	"fmt"
	"strings"

	"github.com/thepsadmin/adventofcode/2020/go/utils"
)

func main() {
	fmt.Println(Part1(utils.ParseFileS("../inputs/day6")))
}

func Part1(input []string) int {
	groups := parseInput(input)
	var sum int
	for _, v := range groups {
		groupAnswers := strings.Join(v, "\n")
		sum = sum + getUniqueCount(groupAnswers)
	}
	return sum
}

func getUniqueCount(s string) int {
	seen := make(map[byte]bool)
	var count int
	for _, v := range []byte(s) {
		if _, ok := seen[v]; !ok {
			count = count + 1
			seen[v] = true
		}
	}
	fmt.Printf("Unique count for: %v is %v\n", s, count)
	return count
}

func parseInput(input []string) [][]string {
	groups := splitGroups(input)
	groupArray := make([][]string, len(groups))
	for i, v := range groups {
		people := strings.Split(v, "\n")
		groupArray[i] = make([]string, len(people))
		for j, p := range people {
			groupArray[i][j] = p
		}
	}
	return groupArray
}

func splitGroups(input []string) []string {
	var result []string
	var next string
	for _, v := range input {
		if v == "" {
			result = append(result, next)
			next = ""
			continue
		}
		next = next + v
	}
	result = append(result, next)
	return result
}
