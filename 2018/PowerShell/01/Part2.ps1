$exInput = Get-Content $PsScriptRoot\..\..\Input\Day1.txt

$freqArray = [System.Collections.Generic.List[int]]::New()
$freq = 0

:loop while ($true) {
    foreach ($i in $exInput) {
        $freq += $i
        if ($freqArray.Contains($freq)) {
            $freq
            break loop
        }

        $freqArray.Add($freq)
    }
}