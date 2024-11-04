﻿<#
.SYNOPSIS
Removes a user from a specified tenant.

.DESCRIPTION
The Remove-CIPPUser function deletes a user identified by their UserID from a specified tenant identified by the CustomerTenantID. 
It sends a request to the '/api/RemoveUser' endpoint to perform the deletion.

.PARAMETER CustomerTenantID
The ID of the tenant from which the user will be removed. This parameter is mandatory.

.PARAMETER User
The unique identifier (GUID) or UserPrincipalName(UPN) of the user to be removed. This parameter is mandatory.

.EXAMPLE
Remove-CIPPUser -CustomerTenantID "tenant123.domain.com" -UserID "e7402930-efc9-4ba8-a959-ae7fc6c15021"
This command removes the user with the specified UserID from the tenant with the specified CustomerTenantID.

.EXAMPLE
Remove-CIPPUser -CustomerTenantID "3939eb14-06b3-4287-aea7-defe129c6741" -UserID "user@domaion.com"
This command removes the user with the specified UserID from the tenant with the specified CustomerTenantID.

.NOTES
The function uses the Invoke-CIPPRestMethod cmdlet to send the request to the API endpoint. 
There is a note indicating that the original code uses a GET request, but it might be more appropriate to use a DELETE request.
#>
function Remove-CIPPUser {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory = $true)]
        [string]$CustomerTenantID,
        [Parameter(Mandatory = $true)]
        [guid]$User
    )

    Write-Verbose "Deleting user $userID for tenant $CustomerTenantID"

    $endpoint = '/api/RemoveUser'
    $params = @{
        TenantFilter = $CustomerTenantID
        ID           = $User
    }
    # HACK: This is a GET request in the original code, but it should probably be a DELETE request? -Bobby
    # Modules\CIPPCore\Public\Invoke-RemoveUser.ps1
    Invoke-CIPPRestMethod -Endpoint $endpoint -Params $params
}