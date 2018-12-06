$exInput = Get-Content $PsScriptRoot\..\..\Input\Day5.txt

$regexString = '(aA)|(bB)|(cC)|(dD)|(eE)|(fF)|(gG)|(hH)|(iI)|(jJ)|(kK)|(lL)|(mM)|(nN)|(oO)|(pP)|(qQ)|(rR)|(sS)|(tT)|(uU)|(vV)|(wW)|(xX)|(yY)|(zZ)|(Aa)|(Bb)|(Cc)|(Dd)|(Ee)|(Ff)|(Gg)|(Hh)|(Ii)|(Jj)|(Kk)|(Ll)|(Mm)|(Nn)|(Oo)|(Pp)|(Qq)|(Rr)|(Ss)|(Tt)|(Uu)|(Vv)|(Ww)|(Xx)|(Yy)|(Zz)'

function _removeElements {
    param(
        [string]$string
    )
    $newString = $string -replace $regexString, ""
    if ($newString.Length -ne $string.Length) {
        _removeElements $newString
    } else {
        $newString
    }
}

_removeElements $exInput