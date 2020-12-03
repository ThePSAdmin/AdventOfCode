package day1

import (
	"testing"
)

func TestDay1(t *testing.T) {

	t.Run("Part 1", func(t *testing.T) {
		actual, _ := GetResult("test_input")
		expected := 514579
		if actual != expected {
			t.Errorf("Expected %v, but got %v", expected, actual)
		}
	})

	t.Run("Part 2", func(t *testing.T) {
		actual, _ := GetResultPart2("test_input")
		expected := 241861950
		if actual != expected {
			t.Errorf("Expected %v, but got %v", expected, actual)

		}
	})
}
