function Start-CompPatchQuery {
    param
    (
        [parameter(Mandatory = $true)]
        [string]$Query,
        [parameter(Mandatory = $true)]
        [string]$SQLServer,
        [parameter(Mandatory = $true)]
        [string]$Database,
        [Parameter(Mandatory = $false, ParameterSetName = 'Log')]
        [switch]$Log,
        [Parameter(Mandatory = $false, ParameterSetName = 'Log')]
        [switch]$Component,
        [Parameter(Mandatory = $false, ParameterSetName = 'Log')]
        [switch]$FileName,
        [Parameter(Mandatory = $false, ParameterSetName = 'Log')]
        [switch]$Folder,
        [Parameter(Mandatory = $false)]
        [switch]$AlwaysEncrypted
    )
    if ($Log) {
        $writeCMLogEntrySplat = @{
            Folder    = $Folder
            Component = $Component
            FileName  = $FileName
            Value     = "Executing Query: `"$Query`""
        }
        Write-CMLogEntry @writeCMLogEntrySplat
    }
    $invokeSqlcmd2Splat = @{
        Query          = $Query
        ServerInstance = $SQLServer
        Database       = $Database
    }
    if ($AlwaysEncrypted) {
        $invokeSqlcmd2Splat.Add('AlwaysEncrypted', $true)
    }
    Invoke-Sqlcmd2 @invokeSqlcmd2Splat
}