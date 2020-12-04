package main

import (
	"testing"

	"github.com/thepsadmin/adventofcode/2020/go/utils"
)

func TestDay3(t *testing.T) {
	input := utils.ParseFileS("test_input")
	t.Run("Part 1", func(t *testing.T) {
		actual := Part1(input)
		expected := 7
		if actual != expected {
			t.Errorf("Expected %v but got %v", expected, actual)
		}
	})
	t.Run("Part 2", func(t *testing.T) {
		actual := Part2(input)
		expected := 336
		if actual != expected {
			t.Errorf("Expected %v but got %v", expected, actual)
		}
	})
}
