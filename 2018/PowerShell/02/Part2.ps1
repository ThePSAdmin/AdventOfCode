$exInput = Get-Content $PsScriptRoot\..\..\Input\Day2.txt

$sortedInput = $exInput | Sort-Object

for ($i = 1; $i -lt $sortedInput.Length; $i++) {
    
    [char[]]$refCharArray = $sortedInput[$i]
    [char[]]$diffCharArray = $sortedInput[$i - 1]
    
    $diff = Compare-Object -ReferenceObject $refCharArray -DifferenceObject $diffCharArray -IncludeEqual | 
        Where-Object 'SideIndicator' -eq '=='

    if ($diff.Count -eq ($refCharArray.Length - 1)) {
        -join $diff.InputObject
        break
    }
}
