$exInput = Get-Content $PsScriptRoot\..\..\Input\Day2.txt
$twos = 0
$threes = 0

foreach ($i in $exInput) {
    $charGroup = [char[]]$i | Group-Object | Select-Object -ExpandProperty Count

    if ($charGroup -contains 2) {
        $twos++
    }

    if ($charGroup -contains 3) {
        $threes++
    }
}

$twos * $threes
