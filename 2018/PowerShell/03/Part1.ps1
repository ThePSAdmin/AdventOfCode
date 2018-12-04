$exInput = Get-Content $PsScriptRoot\..\..\Input\Day3.txt

$uniqueClaims = [System.Collections.Generic.List[int]]::New()

$grid = [int[, ]]::new(1000, 1000)
$doubleClaimed = 0

foreach ($i in $exInput) {
    $strMatch = [regex]::Match($i, "#(\d+) @ (\d+),(\d+): (\d+)x(\d+)")
    $claim = [PSCustomObject]@{
        Id        = [int]$strMatch.Groups[1].Value
        XLocation = [int]$strMatch.Groups[2].Value
        YLocation = [int]$strMatch.Groups[3].Value
        XSize     = [int]$strMatch.Groups[4].Value
        YSize     = [int]$strMatch.Groups[5].Value
    }

    $uniqueClaims.add($claim.Id)
    
    for ($i = $claim.XLocation; $i -lt $claim.XSize + $claim.xLocation; $i++) {
        for ($j = $claim.YLocation; $j -lt $claim.YSize + $claim.YLocation; $j++) {
           
            $currentGridValue = $grid[$i, $j]
            
            switch ($currentGridValue) {
                -1 {
                    [void]$uniqueClaims.Remove($claim.Id)
                }
                0 {
                    $grid[$i, $j] = $claim.Id
                }
                Default {
                    $doubleClaimed++
                    [void]$uniqueClaims.Remove($currentGridValue)
                    [void]$uniqueClaims.Remove($claim.Id)
                    $grid[$i, $j] = -1 
                }
            }
        }
    }

}

[PSCustomObject]@{
    DoubleClaimed = $doubleClaimed
    UniqueClaim  = $uniqueClaims[0]
}
