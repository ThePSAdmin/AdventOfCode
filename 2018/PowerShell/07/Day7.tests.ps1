Describe "Day 7 tests" {
    $sampleInput = Get-Content $PSScriptRoot\SampleInput.txt

    $result = & $PSScriptRoot\Solution.ps1 -PuzzleInput $sampleInput

    it "Should solve Day 7 Part 1 with sample input" {
        $Result.Part1 | Should -Be "CABDFE"
    }
}