Describe "Day 8 tests" {
    $sampleInput = Get-Content $PSScriptRoot\SampleInput.txt

    $result = & $PSScriptRoot\Solution.ps1 -PuzzleInput $sampleInput 

    it "Should solve Day 8 Part 1 with sample input" {
        $Result.Part1 | Should -Be 138
    }
    
    it "Should solve Day 8 Part 2 with sample input" {
        $Result.Part2 | Should -Be 66
    }

}