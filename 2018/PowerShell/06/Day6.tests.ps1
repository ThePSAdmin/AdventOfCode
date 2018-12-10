Describe "Day 6 tests" {
    It "Should solve sample input of Day 6 Part 1" {
        $sampleInput = Get-Content $PSScriptRoot\SampleInput.txt

        $result = & $PSScriptRoot\Part1.ps1 -PuzzleInput $sampleInput 

        $result.Part1 | Should -be 17
    }
}