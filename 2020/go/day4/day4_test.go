package main

import (
	"testing"

	"github.com/thepsadmin/adventofcode/2020/go/utils"
)

func TestDay4(t *testing.T) {
	input := utils.ParseFileS("test_input")
	// t.Run("Part 1", func(t *testing.T) {
	// 	actual := Part1(input)
	// 	expected := 8
	// 	if actual != expected {
	// 		t.Errorf("Expected %v but got %v", expected, actual)
	// 	}
	// })
	t.Run("Part 2", func(t *testing.T) {
		actual := Part1(input)
		expected := 4
		if actual != expected {
			t.Errorf("Expected %v but got %v", expected, actual)
		}
	})
}
