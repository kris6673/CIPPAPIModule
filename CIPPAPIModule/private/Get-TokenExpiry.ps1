<#
.SYNOPSIS
Calculates the expiry date and time for a token.

.DESCRIPTION
The Get-TokenExpiry function calculates the expiry date and time for a token based on the token's expiration time in seconds.
The calculated expiry is cached to avoid redundant calculations on every API call.

.PARAMETER ExpiresIn
Specifies the expiration time of the token in seconds. If not provided, the function uses the default expiration time stored in the $script:ExpiresIn variable.

.OUTPUTS
System.DateTime
The calculated expiry date and time for the token.

.EXAMPLE
Get-TokenExpiry -ExpiresIn 3600
Calculates the expiry date and time for a token that expires in 3600 seconds (1 hour).

#>

function Get-TokenExpiry {
    [CmdletBinding()]
    [OutputType([DateTime])]
    param (
        [Parameter(Mandatory = $false)]
        [int64]$ExpiresIn = $script:ExpiresIn
    )
    if ($script:ExpiresIn -eq $null) {
        return
    }
    
    # Only recalculate if ExpiryDateTime is not already set or if token acquisition time changed
    if (-not $Script:ExpiryDateTime -or $Script:LastCalculatedTokenTime -ne $script:TokenAcquiredTime) {
        $Script:ExpiryDateTime = $script:TokenAcquiredTime.AddSeconds($script:ExpiresIn)
        $Script:LastCalculatedTokenTime = $script:TokenAcquiredTime
        Write-Verbose "Calculated token expiry as $Script:ExpiryDateTime"
    }
}