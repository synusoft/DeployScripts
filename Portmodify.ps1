Write-Host 此脚本的功能是帮助开启虚拟机防火墙的某一个端口
$PortNo = Read-Host 输入要开启的端口号
$DisplayName = Read-Host 输入协议名称
New-NetFirewallRule -Name $DisplayName-$PortNo-tcp-in -Direction Inbound -DisplayName $DisplayName -LocalPort $PortNo -Protocol 'TCP'
New-NetFirewallRule -Name $DisplayName-$PortNo-tcp-out -Direction Outbound -DisplayName $DisplayName -LocalPort $PortNo -Protocol 'TCP'
