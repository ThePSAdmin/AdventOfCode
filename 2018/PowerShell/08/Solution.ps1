[CmdletBinding()]
param(
    [Parameter()]
    [string[]]
    $PuzzleInput
)

$PuzzleInput = -split $PuzzleInput
$script:currentPosition = 0
$nodeList = [System.Collections.Generic.List[PSObject]]::New()

function _getNodes {
    param(
        [int]
        $StartPosition,
        [int]
        $parentNodeID
    )
    $parentNodeID++
    Write-Verbose "Start Position: $StartPosition CurrentPosition: $currentPosition"
    $currentNode = @{
        PSTypeName     = "AoC.Node"
        ChildNodeCount = $PuzzleInput[$StartPosition]
        MetaDataCount  = $PuzzleInput[$StartPosition + 1]
        ParentNodeID = $parentNodeID
        ChildNodeLocation = @()
    }


    $script:currentPosition = $script:currentPosition + 2
    for ($i = 0; $i -lt $currentNode.ChildNodeCount; $i++) {
        $childNode = _getNodes -StartPosition $script:currentPosition -parentNodeID $parentNodeID | select-Object -last 1 
        $currentNode.ChildNodeLocation += $nodeList.IndexOf($childNode)
    }

    $currentNode.MetaData = $PuzzleInput[$currentPosition..$($currentPosition + $currentNode.MetaDataCount - 1)]
    $script:currentPosition = $script:currentPosition + $currentNode.MetaDataCount

    $nodeSum = 0
    if ($currentNode.ChildNodeCount -eq 0) {
        $nodeSum = ([int[]]$currentNode.MetaData | Measure-Object -Sum).Sum
    } else {
        foreach ($md in $CurrentNode.Metadata) {
            if ([int]$md -le [int]$CurrentNode.ChildNodeCount) {
                $nodeSum += $NodeList[$currentNode.ChildNodeLocation[$md - 1]].NodeValue
            } 
        }
    }
    $currentNode.NodeValue = $nodeSum

    $nodeObj = [PSCustomObject]$currentNode
    $nodeList.Add($nodeObj)
    $nodeObj
    
}

$null = _getNodes -StartPosition 0 -parentNodeID 0

Update-TypeData -TypeName 'AoC.Node' -MemberType ScriptProperty -MemberName MetadataSum -Value {
    ([int[]]$this.MetaData | Measure-Object -Sum).Sum   
}

[PSCustomObject]@{
    Part1 = ($nodeList | Measure-Object -Property MetadataSum -Sum)[0].Sum
    Part2 = ($nodeList | Where-Object ParentNodeId -eq 1)[0].NodeValue
}