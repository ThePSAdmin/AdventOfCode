$exInput = Get-Content $PsScriptRoot\..\..\Input\Day5.txt

function _destroyReactingUnits {
    [cmdletBinding()]
    param(
        [System.Collections.Generic.List[char]]$CharList
    )

    do {
        $searchComplete = $true

        for ($i = 1; $i -lt $CharList.Count; $i++) {
            if ([math]::Abs([int]$CharList[$i] - [int]$CharList[$i - 1]) -eq 32) {

                [void]$CharList.RemoveRange($i - 1, 2)
                $searchComplete = $false
                $i--
            }   
        }
    } until ($searchComplete)

    -join $CharList
    
}

$part1 = (_destroyReactingUnits $exInput).length
$part2 = 97..122 | foreach-Object {
    $polymerRemoved = $exInput -replace [char]$_,""
    _destroyReactingUnits -CharList $polymerRemoved
}
 

[PSCustomObject]@{
    Part1 = $part1
    Part2 = $part2 | Sort-Object -Property Length | Select-Object -first 1 -ExpandProperty Length
}


