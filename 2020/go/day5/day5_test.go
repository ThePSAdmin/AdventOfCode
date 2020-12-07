package main

import (
	"testing"
)

var seatTests = []struct {
	in  string
	out int
}{
	{"FBFBBFFRLR", 357},
	{"BFFFBBFRRR", 567},
	{"FFFBBBFRRR", 119},
	{"BBFFBBFRLL", 820},
}

func TestGetSeat(t *testing.T) {
	for _, tt := range seatTests {
		t.Run(tt.in, func(t *testing.T) {
			actual := GetSeat(tt.in)
			if actual != tt.out {
				t.Errorf("Expected %v but got %v", tt.out, actual)
			}
		})
	}
}
