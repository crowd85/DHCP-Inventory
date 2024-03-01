$OutputPath = "C:\Temp"
$OutFileName = "DHCP-Output.txt"
$FullOutPath = ($OutputPath + "\" + $OutFileName)

if (!(Test-Path -Path $OutputPath -PathType Container))
{
    New-Item -ItemType Directory -Force -Path $OutputPath
}

"################# DhcpServerSetting #################" | Out-File -FilePath $FullOutPath
Get-DhcpServerSetting | Out-File -FilePath $FullOutPath -Append

"################# DhcpServerv4Statistics #################" | Out-File -FilePath $FullOutPath -Append
Get-DhcpServerv4Statistics | Out-File -FilePath $FullOutPath -Append

"################# DhcpServerDatabase #################" | Out-File -FilePath $FullOutPath -Append
Get-DhcpServerDatabase | Out-File -FilePath $FullOutPath -Append

"################# DhcpServerInDC #################" | Out-File -FilePath $FullOutPath -Append
Get-DhcpServerInDC | Out-File -FilePath $FullOutPath -Append

"################# DhcpServerv4Binding #################" | Out-File -FilePath $FullOutPath -Append
Get-DhcpServerv4Binding | Out-File -FilePath $FullOutPath -Append

"################# DhcpServerv4DnsSetting #################" | Out-File -FilePath $FullOutPath -Append
Get-DhcpServerv4DnsSetting | Out-File -FilePath $FullOutPath -Append

"################# DhcpServerv4Scope #################" | Out-File -FilePath $FullOutPath -Append
Get-DhcpServerv4Scope | ft -AutoSize | Out-File -FilePath $FullOutPath -Append

"################# DhcpServerv4ScopeStatistics #################" | Out-File -FilePath $FullOutPath -Append
Get-DhcpServerv4ScopeStatistics | Out-File -FilePath $FullOutPath -Append

$Scopes = Get-DhcpServerv4Scope
foreach ($Scope in $Scopes)
{
    ("################# DhcpServerv4Reservation " + $Scope.Name + " #################") | Out-File -FilePath $FullOutPath -Append
    Get-DhcpServerv4Reservation -ScopeId $Scope.ScopeId | ft -AutoSize | Out-File -FilePath $FullOutPath -Append
}

("#################################################################") | Out-File -FilePath $FullOutPath -Append

foreach ($Scope in $Scopes)
{
    ("################# DhcpServerv4OptionValue " + $Scope.Name + " #################") | Out-File -FilePath $FullOutPath -Append
    Get-DhcpServerv4OptionValue -ScopeId $Scope.ScopeId | ft -AutoSize | Out-File -FilePath $FullOutPath -Append
}

("#################################################################") | Out-File -FilePath $FullOutPath -Append
cls
Write-Host "DHCP-Inventory abgeschlossen" -ForegroundColor Green
Write-Host "Die LOG-Datei liegt unter: " $FullOutPath -ForegroundColor Green
Write-Host ""
