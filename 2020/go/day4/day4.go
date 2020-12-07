package main

import (
	"fmt"
	"regexp"
	"strconv"
	"strings"

	"github.com/thepsadmin/adventofcode/2020/go/utils"
)

type passport struct {
	byr string
	iyr string
	eyr string
	hgt string
	hcl string
	ecl string
	pid string
	cid string
}

func main() {
	fmt.Println(Part1(utils.ParseFileS("../inputs/day4")))
	//fmt.Println(Part2(utils.ParseFileS("../inputs/day4")))
}

func parsePassports(input []string) []passport {
	var p []passport
	next := passport{}
	for i := 0; i < len(input); i++ {
		if input[i] == "" {
			p = append(p, next)
			next = passport{}
		}
		lineElements := strings.Split(input[i], " ")
		for _, v := range lineElements {
			kv := strings.Split(v, ":")
			switch kv[0] {
			case "byr":
				next.byr = kv[1]
			case "iyr":
				next.iyr = kv[1]
			case "eyr":
				next.eyr = kv[1]
			case "hgt":
				next.hgt = kv[1]
			case "hcl":
				next.hcl = kv[1]
			case "ecl":
				next.ecl = kv[1]
			case "pid":
				next.pid = kv[1]
			case "cid":
				next.cid = kv[1]
			}
		}

	}

	p = append(p, next)
	fmt.Printf("Number of passports: %v \n", len(p))
	return p
}

func (p *passport) isValid() bool {
	if !isValidYearRange(p.byr, 1920, 2002) {
		return false
	}
	if !isValidYearRange(p.iyr, 2010, 2020) {
		return false
	}
	if !isValidYearRange(p.eyr, 2020, 2030) {
		return false
	}
	if !isValidHeight(p.hgt) {
		return false
	}
	if !isValidHairColor(p.hcl) {
		return false
	}
	if !isValidEyeColor(p.ecl) {
		return false
	}
	if !isValidPassportNr(p.pid) {
		return false
	}
	return true
}

func Part1(input []string) int {
	passports := parsePassports(input)
	validPassports := 0
	for _, v := range passports {
		if v.isValid() {
			validPassports = validPassports + 1
		}
	}
	return validPassports
}

func isValidYearRange(s string, start int, end int) bool {
	v, err := strconv.Atoi(s)
	if err != nil {
		return false
	}

	if v >= start && v <= end {
		return true
	}
	return false
}

func isValidHeight(s string) bool {
	re := regexp.MustCompile(`^(\d*)(cm|in)$`)
	matches := re.FindStringSubmatch(s)
	if len(matches) != 3 {
		return false
	}

	n, err := strconv.Atoi(matches[1])
	if err != nil {
		return false
	}
	switch matches[2] {
	case "cm":
		if n >= 150 && n <= 193 {
			return true
		}
	case "in":
		if n >= 59 && n <= 76 {
			return true
		}
	}
	return false
}

func isValidHairColor(s string) bool {
	result, err := regexp.Match(`^#[0-9a-f]{6}`, []byte(s))
	if err != nil {
		return false
	}
	return result
}

func isValidEyeColor(s string) bool {
	validColors := []string{"amb", "blu", "brn", "gry", "grn", "hzl", "oth"}
	for _, v := range validColors {
		if s == v {
			return true
		}
	}
	return false
}

func isValidPassportNr(s string) bool {
	result, err := regexp.Match(`^\d{9}$`, []byte(s))
	if err != nil {
		return false
	}
	return result
}
