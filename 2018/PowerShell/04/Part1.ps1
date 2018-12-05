$exInput = Get-Content $PsScriptRoot\..\..\Input\Day4.txt

$records = [System.Collections.Generic.List[PSObject]]::New()
$guardLog = @{}

foreach ($record in $exInput) {
    $m = [regex]::Match($record, "\[(.*)\] (\w+) (#(\d+))?")
    
    $currentRecord = [PSCustomObject]@{
        TimeStamp = [DateTime]$m.Groups[1].Value
        Event = $m.Groups[2].Value
        GuardID = $m.Groups[4].Value
    }

    if ($currentRecord.GuardID -and (-not $guardLog[$currentRecord.GuardID])) {
        $guardLog[$currentRecord.GuardID] = [PSCustomObject]@{
            MinutesAsleep = @()
            TotalMinutesAsleep = 0
        }
    }

    $records.Add($currentRecord)

}

$records = $records | Sort-Object -Property TimeStamp 

foreach ($record in $records) {
    switch -Regex ($record.Event) {
        "^Guard" {
            $currentGuard = $record.GuardID
        }

        "^falls" {
            $startSleepTime = $record.TimeStamp
        }

        "^wakes" {
            $endSleepTime = $record.TimeStamp.AddMinutes(-1)
            $guardLog[$currentGuard].TotalMinutesAsleep += [int](New-TimeSpan -Start $startSleepTime -End $endSleepTime).TotalMinutes
            $guardLog[$currentGuard].MinutesAsleep += ($startSleepTime.Minute)..($endSleepTime.Minute)
        }
    }
}

$sleepiestGuard = $guardLog.GetEnumerator() | 
    Sort-Object {$_.Value.TotalMinutesAsleep} -Descending | 
    Select-Object -First 1 

[int]$minuteMostAsleep = $sleepiestGuard.Value.MinutesAsleep | 
    Group-Object | 
    Sort-Object -Property Count -Descending |
    Select-Object -First 1 -ExpandProperty Name

[int]$sleepiestGuard.Name * $minuteMostAsleep
