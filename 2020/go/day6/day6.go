package main

import (
	"fmt"
	"strings"

	"github.com/thepsadmin/adventofcode/2020/go/utils"
)

func main() {
	fmt.Println(Part1(utils.ParseFileS("../inputs/day6")))
	fmt.Println(Part2(utils.ParseFileS("../inputs/day6")))
}

func Part1(input []string) int {
	groups := splitGroups(input)
	var sum int
	for _, v := range groups {
		groupAnswers := strings.Join(v, "")
		sum = sum + getUniqueCount(groupAnswers)
	}
	return sum
}

func Part2(input []string) int {
	groups := splitGroups(input)
	var sum int
	for _, v := range groups {
		answerCount := make(map[byte]int)
		for _, p := range v {
			for _, a := range []byte(p) {
				answerCount[a] = answerCount[a] + 1
			}
		}
		for b, c := range answerCount {
			if c == len(v) {
				fmt.Printf("%v found %v times\n", string(b), len(v))
				sum = sum + 1
			}
		}
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
	//fmt.Printf("Unique count for: %v is %v\n", s, count)
	return count
}

func splitGroups(input []string) [][]string {
	var result [][]string
	var next []string
	for _, v := range input {
		if v == "" {
			result = append(result, next)
			next = make([]string, 0)
			continue
		}
		next = append(next, v)
	}
	result = append(result, next)
	return result
}
