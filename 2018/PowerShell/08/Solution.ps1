[CmdletBinding()]
param(
    [Parameter()]
    [string[]]
    $PuzzleInput
)

$PuzzleInput = -split $PuzzleInput
$script:currentPosition = 0

function _getNodes {
    param(
        [int]
        $StartPosition
    )
    WRite-verbose "Start Position: $StartPosition CurrentPosition: $currentPosition"
    $currentNode = @{
        PSTypeName = "AoC.Node"
        ChildNodeCount = $PuzzleInput[$StartPosition]
        MetaDataCount = $PuzzleInput[$StartPosition + 1]
    }

    $script:currentPosition = $script:currentPosition + 2
    for ($i = 0; $i -lt $currentNode.ChildNodeCount; $i++) {
        _getNodes -StartPosition $script:currentPosition
    }

    $currentNode.MetaData = $PuzzleInput[$currentPosition..$($currentPosition + $currentNode.MetaDataCount -1)]
    $script:currentPosition = $script:currentPosition + $currentNode.MetaDataCount
    [PSCustomObject]$currentNode
}

$result = _getNodes -StartPosition 0

Update-TypeData -TypeName 'AoC.Node' -MemberType ScriptProperty -MemberName MetadataSum -Value {
    ([int[]]$this.MetaData | Measure-Object -Sum).Sum   
}

[PSCustomObject]@{
    Part1 = ($result | Measure-Object -Property MetadataSum -Sum).Sum
}