package day1

import (
	"bufio"
	"os"
	"strconv"
)

func parseFile(filename string) ([]int, error) {
	file, err := os.Open(filename)
	if err != nil {
		return nil, err
	}
	defer file.Close()

	var r []int
	scanner := bufio.NewScanner(file)
	scanner.Split(bufio.ScanLines)
	for scanner.Scan() {
		i, err := strconv.Atoi(scanner.Text())
		if err != nil {
			return nil, err
		}

		r = append(r, i)
	}
	return r, nil
}

func GetResult(filename string) (int, error) {
	input, err := parseFile(filename)
	if err != nil {
		return 0, err
	}

	for _, v := range input {
		second := 2020 - v
		if sliceContains(input, second) {
			return (v * second), nil
		}
	}

	return 0, nil
}

func GetResultPart2(filename string) (int, error) {
	input, err := parseFile(filename)
	if err != nil {
		return 0, err
	}

	for i, v := range input {
		for j, w := range input[i:] {
			for _, x := range input[j:] {
				if v+w+x == 2020 {
					return (v * w * x), nil
				}
			}
		}
	}

	return 0, nil
}

func sliceContains(arr []int, val int) bool {
	for _, v := range arr {
		if v == val {
			return true
		}
	}
	return false
}
