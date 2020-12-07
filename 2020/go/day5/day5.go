package main

import (
	"fmt"
	"sort"

	"github.com/thepsadmin/adventofcode/2020/go/utils"
)

func main() {
	fmt.Println(Part1(utils.ParseFileS("../inputs/day5")))
	//fmt.Println(Part2(utils.ParseFileS("../inputs/day4")))
}

func Part1(input []string) int {
	var seatids []int
	for _, v := range input {
		seatids = append(seatids, GetSeat(v))
	}
	sort.Ints(seatids)
	return seatids[len(seatids)-1]
}

func GetSeat(s string) int {
	row := 0
	for i := 0; i < 7; i++ {
		row = row << 1
		if []byte(s)[i] == 'B' {
			row = row + 1
		}
	}

	seat := 0
	for i := 7; i < 10; i++ {
		seat = seat << 1
		if []byte(s)[i] == 'R' {
			seat = seat + 1
		}
	}

	return (row * 8) + seat

}
