# 此脚本是帮助开启虚拟机防火墙的某一个端口,未完成
# PortNo是端口号
$PortNo = "3306"



New-NetFirewallRule -Name %PortNo-tcp -Direction Inbound -DisplayName 'PowerShell远程连接 TCP' -LocalPort 5985-5996 -Protocol 'TCP'


New-NetFirewallRule -Name powershell-remote-tcp -Direction Outbound -DisplayName 'PowerShell远程连接 TCP' -LocalPort 5985-5996 -Protocol 'TCP'
