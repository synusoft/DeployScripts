# 此脚本是帮助siteserver初始化IIS_IUSRS和NETWORK SERVICE目录的权限，安装IIS服务以及添加端口防火墙例外
# FolderName是文件夹名称，如果为当前目录，输入"."，否则填写绝对路径
$FolderName = "."
# DisplayName 是在IIS和防火墙配置显示的标识符，应当唯一
$DisplayName = "CMSv5_89"
# PortNo 是站点端口号(1-65535)
$PortNo = "89"

if($FolderName -eq "."){$AbsolatePath=(Get-Location).Path}else{$AbsolatePath=$FolderName}

# 配置目录权限
$acl = Get-Acl $FolderName
# 添加第一个规则:
$person = [System.Security.Principal.NTAccount]"IIS_IUSRS"
$access = [System.Security.AccessControl.FileSystemRights]"FullControl"
$inheritance = [System.Security.AccessControl.InheritanceFlags] "ObjectInherit,ContainerInherit"
$propagation = [System.Security.AccessControl.PropagationFlags]"None"
$type = [System.Security.AccessControl.AccessControlType]"Allow"
$rule = New-Object System.Security.AccessControl.FileSystemAccessRule( $person,$access,$inheritance,$propagation,$type)
$acl.AddAccessRule($rule)
# 添加第二个规则:
$person = [System.Security.Principal.NTAccount]"NETWORK SERVICE"
$access = [System.Security.AccessControl.FileSystemRights]"FullControl"
$inheritance = [System.Security.AccessControl.InheritanceFlags] "ObjectInherit,ContainerInherit"
$propagation = [System.Security.AccessControl.PropagationFlags]"None"
$type = [System.Security.AccessControl.AccessControlType]"Allow"
$rule = New-Object System.Security.AccessControl.FileSystemAccessRule( $person,$access,$inheritance,$propagation,$type)
$acl.AddAccessRule($rule)
# 保存权限更新:
Set-Acl $FolderName $acl


#创建IIS站点
#导入IIS管理模块
Import-Module WebAdministration

#新建应用程序池 $DisplayName
New-Item iis:\AppPools\$DisplayName
#更改应用程序池版本为4.0
Set-ItemProperty iis:\AppPools\$DisplayName managedRuntimeVersion v4.0
#新建站点 $DisplayName
New-Item iis:\Sites\$DisplayName -bindings @{protocol="http";bindingInformation="*:"+$PortNo+":"} -physicalPath $AbsolatePath
#为站点更改应用程序池
Set-ItemProperty IIS:\Sites\$DisplayName -name applicationPool -value $DisplayName

#创建防火墙例外规则
New-NetFirewallRule -Name $DisplayName-$PortNo-tcp-in -Direction Inbound -DisplayName $DisplayName -LocalPort $PortNo -Protocol 'TCP'
New-NetFirewallRule -Name $DisplayName-$PortNo-tcp-out -Direction Outbound -DisplayName $DisplayName -LocalPort $PortNo -Protocol 'TCP'
