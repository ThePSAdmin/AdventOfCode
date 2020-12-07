package main

import (
	"fmt"
	"regexp"
	"strconv"

	"github.com/thepsadmin/adventofcode/2020/go/utils"
)

type Password struct {
	Min      int
	Max      int
	Char     byte
	Password []byte
}

func parsePassword(s string) Password {
	r := regexp.MustCompile(`(\d+)-(\d+) (\w): (\w*)`)
	p := r.FindStringSubmatch(s)
	min, _ := strconv.Atoi(p[1])
	max, _ := strconv.Atoi(p[2])
	char := byte(p[3][0])
	password := []byte(p[4])
	return Password{
		Min:      min,
		Max:      max,
		Char:     char,
		Password: password,
	}
	fmt.pr
}

func main() {
	fmt.Println(Part1(utils.ParseFileS("../inputs/day2")))
	fmt.Println(Part2(utils.ParseFileS("../inputs/day2")))
}

func Part1(input []string) int {
	result := 0
	for _, v := range input {
		if isValidPassword(parsePassword(v)) {
			result = result + 1
		}
	}
	return result
}

func Part2(input []string) int {
	result := 0
	for _, v := range input {
		p := parsePassword(v)
		var first bool
		var second bool
		if p.Password[p.Min-1] == p.Char {
			first = true
		}

		if p.Password[p.Max-1] == p.Char {
			second = true
		}

		if first != second {
			result = result + 1
		}
	}
	return result
}

func isValidPassword(p Password) bool {
	count := 0
	for _, v := range p.Password {
		if v == p.Char {
			count = count + 1
		}
	}
	if count >= p.Min && count <= p.Max {
		return true
	}
	return false
}
