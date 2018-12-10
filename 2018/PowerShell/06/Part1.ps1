[cmdletbinding()]
param(
    [Parameter()]
    [string[]]
    $PuzzleInput
)

function _getNearestCoord ([int]$x, [int]$y) {
    $closestPos = [int]::MaxValue
    foreach ($coord in $coordList) {
        $position = [math]::abs($x - $coord.x) + [math]::abs($y - $coord.y)

        if ($position -eq $closestPos) {
            $closestCoord = $null
        } elseif ($position -lt $closestPos) {
            $closestCoord = $coord
            $closestPos = $position
        }
    }
    
    return $closestCoord
    
}

$coordList = [System.Collections.Generic.List[PSObject]]::New()
foreach ($i in $PuzzleInput) {
    $coords = $i.Split(",").Trim()
    $coordsObject = [PsCustomObject]@{
        x            = [int]$coords[0]
        y            = [int]$coords[1]
        isEdge       = $false
        totalSquares = 0
    }
    $coordList.Add($coordsObject)
}

$xSorted = $coordList | Sort-Object -property x 
$ySorted = $coordList | Sort-Object -property y 

$maxX = $xSorted[-1].x
$minX = $xSorted[0].x
$maxY = $ySorted[-1].y
$minY = $ySorted[0].y

Write-Verbose "Min X: $minX"
Write-Verbose "Max X: $maxX"
Write-Verbose "Min Y: $minY"
Write-Verbose "Max Y: $maxY"

for ($i = $minX; $i -le $maxX; $i++) {
    for ($j = $minY; $j -le $maxY; $j++) {
        
        Write-Verbose "Calculating nearest closest coord to $i, $J"
        $nearestCoord = _getNearestCoord -x $i -y $j
        
        if ($null -ne $nearestCoord) {
            if (($maxX, $minX) -contains $i -or ($maxy, $miny) -contains $j) {
                $nearestCoord.isEdge = $true
            } 
        
            $nearestCoord.totalSquares++  
        }

    }
}

$part1 = $coordList | Where-Object {$_.isEdge -eq $false} | Sort-Object -Property totalSquares -Descending | Select-Object -ExpandProperty totalSquares -First 1

[PSCustomObject]@{
    Part1 = $part1
}




