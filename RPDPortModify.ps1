# 此脚本是修改RDP默认端口的脚本，未完成,重启服务那块需要修复

Clear 
Write-Host 
Write-Host 1、自定义远程桌面端口 -ForegroundColor 10 
Write-Host 2、恢复系统默认的远程桌面端口 -ForegroundColor 11 
Write-Host 
Write-Host 
Write-Host "请从上面的列表选择一个选项...[1-2]“ 
$opt=Read-Host 
Switch ($opt) 
    { 
        1 { 
            Write-Host 
            Write-Host 修改远程桌面（Remote Desktop）的默认端口... -ForegroundColor Red 
            Write-Host 
            Write-Host 下来将会提示输入要指定的端口号，请参考端口范围输入一个指定的端口号（范围：1024~65535） 
            Write-Host 该脚本修改注册表“HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp”下“PortNumber”的键值。 
            Write-Host 
            # 输入指定的端口号并修改RDP默认端口 
            $PortNumber=Read-Host "现在请输入要指定的端口号（范围：1024~65535）" 
            $original=Get-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp' -Name 'portnumber' 
            Write-Host 当前RDP默认端口为$original.PortNumber 
            Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp' -Name 'portnumber' -Value $PortNumber 
            $result=Get-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp' -Name 'portnumber' 
            if($result.PortNumber -eq $PortNumber) 
            { 
                Write-Host 已经完成 RDP 端口的修改！ -ForegroundColor Green 
            } 
            else 
            { 
                Write-Host 修改RDP 端口失败！ -ForegroundColor Red 
            } 
            #重启远程桌面服务 
            Write-Host 正在重启 Remote Desktop Services ... -ForegroundColor DarkYellow 
            Restart-Service termservice -Force 
            #允许自定义端口通过防火墙 
            Write-Host 添加防火墙策略，允许现有 RDP 端口 $PortNumber 入站。 
            $result=New-NetFirewallRule -DisplayName "Allow Custom RDP PortNumber" -Direction Inbound -Protocol TCP -LocalPort $PortNumber -Action Allow 
            if($result.PrimaryStatus -eq 'OK') 
            { 
                Write-Host 已经完成 RDP 端口对应防火墙策略的添加！ -ForegroundColor Green 
            } 
            else 
            { 
                Write-Host 添加RDP 端口对应防火墙策略失败！ -ForegroundColor Red 
            } 
            Write-Host 
            Write-Host 完成 RDP 端口修改！ 
            } 
        2 { 
            Write-Host 
            Write-Host 正在恢复系统默认端口... 
            Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp' -Name 'portnumber' -Value 3389 
            Write-Host 正在重启 Remote Desktop Services... 
            Restart-Service termservice -Force 
            Write-Host 正在删除防火墙设置... 
            Remove-NetFirewallRule -DisplayName "Allow Custom RDP PortNumber" 
            write-host 完成恢复！ 
           } 
     }
