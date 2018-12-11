[cmdletbinding()]
param(
    [Parameter()]
    [string[]]
    $PuzzleInput
)

$ht = @{}

foreach ($i in $PuzzleInput) {
    [char]$step = $i.SubString(5, 1)
    [char]$dependency = $i.SubString(36, 1)

    if (-not $ht[$dependency]) {
        $ht[$dependency] = [char[]]$step
    } else {
        $ht[$dependency] += $step
    }
}

foreach ($i in $ht.Clone().GetEnumerator()) {
    foreach ($v in $i.Value) {
        if (-not $ht[$v]) {
            $ht[$v] = [char[]]::New(0)
        }
    }
}

$outString = ""
while ($ht.Keys.Count -ne 0) {
    foreach ($h in $ht.Keys | Sort-Object) {
    
        if ($ht[$h].Count -eq 0) {
            $currChar = $h
            $outString += $currChar
            foreach ($char in $($ht.Keys)) {
                $ht[$char] = $ht[$char] -ne $currChar
            }
            $ht.Remove($currChar)
            break
        }
    }
}

[PsCustomObject]@{
    Part1 = $outString
}
