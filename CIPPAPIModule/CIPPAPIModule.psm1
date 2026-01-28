# Optimize function loading by using a single Get-ChildItem call with multiple paths
$Functions = Get-ChildItem -Path "$PSScriptRoot\public", "$PSScriptRoot\private" -Filter *.ps1 -Recurse -ErrorAction SilentlyContinue
foreach ($import in $Functions) {
    try {
        . $import.FullName
    } catch {
        Write-Error -Message "Failed to import function $($import.FullName): $_"
    }
}