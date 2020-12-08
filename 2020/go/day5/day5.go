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
	var seatArray [128][8]bool
	for _, v := range input {
		seatids = append(seatids, GetSeat(v, &seatArray))
	}
	sort.Ints(seatids)

	for i := 2; i < 122; i++ {
		fmt.Print()
		for j := 0; j < 8; j++ {
			if !seatArray[i][j] {
				fmt.Printf("Found available seat in row: %v seat: %v with id: %v\n", i, j, ((i * 8) + j))
			}
		}
	}

	return seatids[len(seatids)-1]
}

// func Part2(input []string) int {
// 	var seatArray [127][7]bool
// }

func GetSeat(s string, arr *[128][8]bool) int {
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

	(*arr)[row][seat] = true

	return (row * 8) + seat

}
