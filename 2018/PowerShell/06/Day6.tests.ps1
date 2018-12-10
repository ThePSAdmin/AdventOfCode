Describe "Day 6 tests" {
    $sampleInput = Get-Content $PSScriptRoot\SampleInput.txt
    $result = & $PSScriptRoot\Part1.ps1 -PuzzleInput $sampleInput -RegionSize 32

    It "Should solve sample input of Day 6 Part 1" {
        $result.Part1 | Should -be 17
    }

    It "Should solve sample input of Day 6 Part 2" {
        $result.Part2 | Should -be 16
    }
}