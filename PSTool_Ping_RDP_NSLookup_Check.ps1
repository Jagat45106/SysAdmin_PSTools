$list = Get-Content -Path C:\temp\server.txt

$output = ""

foreach ($server in $list){

$result = Test-NetConnection -ComputerName $server -Port 3389

$output  = [PSCustomObject]@{


"Hostname" = $server
"Ping_Pass_?" = $result.PingSucceeded
"RDP_Pass_?" = $result.TcpTestSucceeded
"DNS_Resolved_?" = $result.NameResolutionSucceeded


}

$output | select -Property Hostname,Ping_Pass_?,RDP_Pass_?,DNS_Resolved_? | Export-Csv C:\temp\ping_rdp_nslookup_result.csv -Append

}