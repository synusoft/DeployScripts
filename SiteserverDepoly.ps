# 此脚本是帮助siteserver初始化IIS_IUSRS和NETWORK SERVICE目录的权限
# foldername是文件夹名称，如果为当前目录，输入"."
$foldername = "."
# $foldername = "siteserver5"
$acl = Get-Acl $foldername
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
Set-Acl $foldername $acl
