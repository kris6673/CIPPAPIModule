<#
.SYNOPSIS
Calculates and caches the expiry date and time for a token.

.DESCRIPTION
The Get-TokenExpiry function calculates the expiry date and time for a token based on the token's expiration time in seconds.
The calculated expiry is cached in $Script:ExpiryDateTime to avoid redundant calculations on every API call.

This function sets the script-level variable $Script:ExpiryDateTime but does not return a value.

.PARAMETER ExpiresIn
Specifies the expiration time of the token in seconds. If not provided, the function uses the default expiration time stored in the $script:ExpiresIn variable.

.EXAMPLE
Get-TokenExpiry -ExpiresIn 3600
Calculates and caches the expiry date and time for a token that expires in 3600 seconds (1 hour).

#>

function Get-TokenExpiry {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [int64]$ExpiresIn = $script:ExpiresIn
    )
    if ($script:ExpiresIn -eq $null) {
        return
    }
    
    # Only recalculate if ExpiryDateTime is not already set or if token acquisition time changed
    if (-not $script:ExpiryDateTime -or $script:LastCalculatedTokenTime -ne $script:TokenAcquiredTime) {
        $script:ExpiryDateTime = $script:TokenAcquiredTime.AddSeconds($script:ExpiresIn)
        $script:LastCalculatedTokenTime = $script:TokenAcquiredTime
        Write-Verbose "Calculated token expiry as $script:ExpiryDateTime"
    }
}