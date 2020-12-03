package utils

import (
	"bufio"
	"os"
)

// ParseFileS parses a file and returns a slice of strings
func ParseFileS(filename string) []string {
	file, _ := os.Open(filename)
	defer file.Close()

	var r []string
	scanner := bufio.NewScanner(file)
	scanner.Split(bufio.ScanLines)
	for scanner.Scan() {
		r = append(r, scanner.Text())
	}
	return r
}
