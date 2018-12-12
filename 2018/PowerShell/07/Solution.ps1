[cmdletbinding()]
param(
    [Parameter()]
    [string[]]
    $PuzzleInput,

    [Parameter()]
    [int]
    $StepDuration,

    [Parameter()]
    [int]
    $NumWorkers
)

# This really needs to be refactored, but I just wanted to solve the puzzle as I'm already 4 days behind....

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

$part2Ht = $Ht.clone()

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

#part 2
$totalSecondsElapsed = 0
$availableChars = [char[]]::New(0)
$workers = [PSCustomObject[]]::New($NumWorkers)
$part2OutString = ""
while ($part2Ht.Keys.Count -ne 0 -or (($workers | Where-Object {$_.IsBusy}))) {
    #Finds free chars to start work on.
    foreach ($h in $part2Ht.Keys | Sort-Object) {
        if ($part2Ht[$h].Count -eq 0) {
            $availableChars += $h
        }
    }

    foreach ($availableChar in $availableChars) {
        for ($j = 0; $j -lt $workers.count; $j++) {
            if (-not $workers[$j].IsBusy) {
                $workers[$j] = [PSCustomObject]@{
                    WorkerChar     = [char]$availableChar
                    ElapsedSeconds = 1
                    IsBusy         = $true
                }
                $availableChars = $availableChars -ne $availableChar
                $part2ht.Remove($availableChar)
                break
            }
        }
    }

    foreach ($worker in $workers | Where-Object {$_.IsBusy}) {
        Write-Verbose "Char: $($worker.WorkerChar) Should complete after $(([int]$worker.WorkerChar - 64) + $StepDuration). Elapsed Seconds: $($worker.ElapsedSeconds)"
        if (([int]$worker.WorkerChar - 64) + $StepDuration -le $worker.ElapsedSeconds) {
            $part2OutString += $worker.WorkerChar
            foreach ($char in $($part2ht.Keys)) {
                $part2ht[$char] = $part2ht[$char] -ne $worker.WorkerChar
            }
    
            $worker.IsBusy = $false
        } else {
            $worker.ElapsedSeconds++
        }
    }

    $totalSecondsElapsed++
}

[PsCustomObject]@{
    Part1 = $outString
    Part2 = $totalSecondsElapsed
}  