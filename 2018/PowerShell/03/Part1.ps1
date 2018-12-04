$exInput = Get-Content $PsScriptRoot\..\..\Input\Day3.txt

$claims = [System.Collections.Generic.List[PSObject]]::New()

[string[, ]]$grid = [string[, ]]::new(1000, 1000)
$doubleClaimed = 0

foreach ($i in $exInput) {
    $strMatch = [regex]::Match($i, "(#\d+) @ (\d+),(\d+): (\d+)x(\d+)")
    $claim = [PSCustomObject]@{
        Id        = $strMatch.Groups[1].Value
        XLocation = [int]$strMatch.Groups[2].Value
        YLocation = [int]$strMatch.Groups[3].Value
        XSize     = [int]$strMatch.Groups[4].Value
        YSize     = [int]$strMatch.Groups[5].Value
    }

    for ($i = $claim.XLocation; $i -lt $claim.XSize + $claim.xLocation; $i++) {
        for ($j = $claim.YLocation; $j -lt $claim.YSize + $claim.YLocation; $j++) {
            
            switch -Regex ($grid[$i, $j]) {
                "^#" {
                    $doubleClaimed++
                    $grid[$i, $j] = 'X' 
                }
                "^X" {
                    # Do nothing
                }
                Default {
                    $grid[$i, $j] = $claim.Id
                }
            }
        }
    }
}

$doubleClaimed
