<#
.SYNOPSIS
    Adds non-null optional parameters to a target hashtable.

.DESCRIPTION
    The Add-OptionalParameters function efficiently adds non-null values from an optional 
    parameters hashtable to a target hashtable. This is a common pattern used across 
    multiple CIPP API functions to handle optional parameters.

.PARAMETER TargetHashtable
    The hashtable to add the optional parameters to.

.PARAMETER OptionalParameters
    A hashtable containing optional parameter names and values.

.EXAMPLE
    $body = @{ tenantFilter = $CustomerTenantID }
    $optionalParams = @{ City = $City; Department = $Department }
    Add-OptionalParameters -TargetHashtable $body -OptionalParameters $optionalParams
    
    Adds non-null values from $optionalParams to $body.

.NOTES
    This helper function reduces code duplication across the module.
#>

function Add-OptionalParameters {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [hashtable]$TargetHashtable,
        
        [Parameter(Mandatory = $true)]
        [hashtable]$OptionalParameters
    )
    
    foreach ($key in $OptionalParameters.Keys) {
        if ($null -ne $OptionalParameters[$key]) {
            $TargetHashtable[$key] = $OptionalParameters[$key]
        }
    }
}
