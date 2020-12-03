package day1

import (
	"testing"
)

func TestDay1(t *testing.T) {
	actual, _ := GetResult("test_input")
	expected := 514579
	if actual != expected {
		t.Errorf("Expected %v, but got %v", expected, actual)
	}
}
