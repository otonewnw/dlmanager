#OU作成＆設定
#ou_create.ps1

Param($org,[switch]$help,$prefix)

function HelpMe
{
 Write-Host
 Write-Host " ou_create.ps1:" -fore Green
 Write-Host "   create OU & link GPO"
 Write-Host
 Write-Host " Parameters:" -fore Green
 Write-Host "   -org [組織OU名]"
 Write-Host "   -help"
 Write-Host "   -prefix [組織識別子]"
 Write-Host
 Write-Host " Examples:" -fore Green
 Write-Host "   OU'NTTネオメイト'を作成およびログオン制御グループ作成" -fore White
 Write-Host "     .\ou_create.ps1 -org 'NTTネオメイト'　-prefix 'neo'" -fore Yellow
 Write-Host
}

if(!$org -or $help)
{
 HelpMe;return
}

##OU存在確認
$dom = [adsi] "LDAP://ad2008r2-1.local/DC=ad2008r2-1,DC=local"
$ds = New-Object System.DirectoryServices.DirectorySearcher
$ds.Filter = [string]::Format("(&(ObjectCategory=OrganizationalUnit))")

foreach($OrgOU in $ds.findall())
{

 $ouname = $OrgOU.properties.name


 if($OUName -eq $org)
 {
  write-host "$org OU exists"
  exit
 }
}

##OUの作成
#組織OUの作成
$dom01 = [adsi] "LDAP://ad2008r2-1.local/DC=ad2008r2-1,DC=local"
$newOU = $dom01.Create("OrganizationalUnit","OU=$org")
$newOU.SetInfo()

#ComputersOUの作成
$dom02 = [adsi] "LDAP://ad2008r2-1.local/OU=$org,DC=ad2008r2-1,DC=local"
$newOU10 = $dom02.Create("OrganizationalUnit","OU=Computers")
$newOU10.SetInfo()

#UsersOUの作成
$newOU20 = $dom02.Create("OrganizationalUnit","OU=Users")
$newOU20.SetInfo()

#ComputersOU配下の作成
$dom03 = [adsi] "LDAP://ad2008r2-1.local/OU=Computers,OU=$org,DC=ad2008r2-1,DC=local"
$newOU11 = $dom03.Create("OrganizationalUnit","OU=device")
$newOU11.SetInfo()
$newOU12 = $dom03.Create("OrganizationalUnit","OU=pc_default")
$newOU12.SetInfo()
$newOU13 = $dom03.Create("OrganizationalUnit","OU=pc_kiseikaijo_c")
$newOU13.SetInfo()
$newOU14 = $dom03.Create("OrganizationalUnit","OU=pc_kiseikaijo_cf")
$newOU14.SetInfo()
$newOU15 = $dom03.Create("OrganizationalUnit","OU=pc_kiseikaijo_cfu")
$newOU15.SetInfo()
$newOU16 = $dom03.Create("OrganizationalUnit","OU=pc_kiseikaijo_cu")
$newOU16.SetInfo()
$newOU17 = $dom03.Create("OrganizationalUnit","OU=pc_kiseikaijo_f")
$newOU17.SetInfo()
$newOU18 = $dom03.Create("OrganizationalUnit","OU=pc_kiseikaijo_fu")
$newOU18.SetInfo()
$newOU19 = $dom03.Create("OrganizationalUnit","OU=pc_kiseikaijo_u")
$newOU19.SetInfo()

#UsersOU配下の作成
$dom04 = [adsi] "LDAP://ad2008r2-1.local/OU=Users,OU=$org,DC=ad2008r2-1,DC=local"
$newOU21 = $dom04.Create("OrganizationalUnit","OU=mail_contact")
$newOU21.SetInfo()
$newOU22 = $dom04.Create("OrganizationalUnit","OU=ML_contact")
$newOU22.SetInfo()
$newOU23 = $dom04.Create("OrganizationalUnit","OU=resource")
$newOU23.SetInfo()
$newOU24 = $dom04.Create("OrganizationalUnit","OU=user_default")
$newOU24.SetInfo()



##OUのACL設定
#DN設定
$DnPath = "OU=$Org,DC=ad2008r2-1,DC=local"
$DnPathTemp = "OU=NTTネオメイト,DC=ad2008r2-1,DC=local"


#組織OUのACL設定
#テンプレートOUからのSDDL版ACLデータ採取
$DnTemp01 = [adsi]"LDAP://ad2008r2-1.local/$DNPathTemp"
$Acl01 = $DnTemp01.psbase.ObjectSecurity
$Sddl01 = $Acl01.GetSecurityDescriptorSddlForm([System.Security.AccessControl.AccessControlSections]::All)

#テンプレートOUのACLデータを作成OUへの書き込み
$Dn01 = [adsi]"LDAP://ad2008r2-1.local/$DNPath"
$Dn01.psbase.ObjectSecurity.SetSecurityDescriptorSddlForm($Sddl01)
$Dn01.psbase.commitchanges()





#ComputersOU配下のACL設定
#テンプレートOUからのSDDL版ACLデータ採取
#$DnTemp11 = [adsi]"LDAP://ad2008r2-1.local/ou=pc_default,ou=Computers,$DNPathTemp"
$DnTemp11 = [adsi]"LDAP://ad2008r2-1.local/$DNPathTemp"
$Acl11 = $DnTemp11.psbase.ObjectSecurity
$Sddl11 = $Acl11.GetSecurityDescriptorSddlForm([System.Security.AccessControl.AccessControlSections]::All)

#テンプレートOUのACLデータを作成OUへの書き込み
$Dn11 = [adsi]"LDAP://ad2008r2-1.local/ou=device,ou=Computers,$DNPath"
$Dn11.psbase.ObjectSecurity.SetSecurityDescriptorSddlForm($Sddl11)
$Dn11.psbase.commitchanges()

$Dn12 = [adsi]"LDAP://ad2008r2-1.local/ou=pc_default,ou=Computers,$DNPath"
$Dn12.psbase.ObjectSecurity.SetSecurityDescriptorSddlForm($Sddl11)
$Dn12.psbase.commitchanges()

$Dn13 = [adsi]"LDAP://ad2008r2-1.local/ou=pc_kiseikaijo_c,ou=Computers,$DNPath"
$Dn13.psbase.ObjectSecurity.SetSecurityDescriptorSddlForm($Sddl11)
$Dn13.psbase.commitchanges()

$Dn14 = [adsi]"LDAP://ad2008r2-1.local/ou=pc_kiseikaijo_cf,ou=Computers,$DNPath"
$Dn14.psbase.ObjectSecurity.SetSecurityDescriptorSddlForm($Sddl11)
$Dn14.psbase.commitchanges()

$Dn15 = [adsi]"LDAP://ad2008r2-1.local/ou=pc_kiseikaijo_cfu,ou=Computers,$DNPath"
$Dn15.psbase.ObjectSecurity.SetSecurityDescriptorSddlForm($Sddl11)
$Dn15.psbase.commitchanges()

$Dn16 = [adsi]"LDAP://ad2008r2-1.local/ou=pc_kiseikaijo_cu,ou=Computers,$DNPath"
$Dn16.psbase.ObjectSecurity.SetSecurityDescriptorSddlForm($Sddl11)
$Dn16.psbase.commitchanges()

$Dn17 = [adsi]"LDAP://ad2008r2-1.local/ou=pc_kiseikaijo_f,ou=Computers,$DNPath"
$Dn17.psbase.ObjectSecurity.SetSecurityDescriptorSddlForm($Sddl11)
$Dn17.psbase.commitchanges()

$Dn18 = [adsi]"LDAP://ad2008r2-1.local/ou=pc_kiseikaijo_fu,ou=Computers,$DNPath"
$Dn18.psbase.ObjectSecurity.SetSecurityDescriptorSddlForm($Sddl11)
$Dn18.psbase.commitchanges()

$Dn19 = [adsi]"LDAP://ad2008r2-1.local/ou=pc_kiseikaijo_u,ou=Computers,$DNPath"
$Dn19.psbase.ObjectSecurity.SetSecurityDescriptorSddlForm($Sddl11)
$Dn19.psbase.commitchanges()



#ComputersOUのACL設定
#テンプレートOUからのSDDL版ACLデータ採取
$DnTemp10 = [adsi]"LDAP://ad2008r2-1.local/ou=Computers,$DNPathTemp"
$Acl10 = $DnTemp10.psbase.ObjectSecurity
$Sddl10 = $Acl10.GetSecurityDescriptorSddlForm([System.Security.AccessControl.AccessControlSections]::All)

#テンプレートOUのACLデータを作成OUへの書き込み
$Dn10 = [adsi]"LDAP://ad2008r2-1.local/ou=Computers,$DNPath"
$Dn10.psbase.ObjectSecurity.SetSecurityDescriptorSddlForm($Sddl10)
$Dn10.psbase.commitchanges()




#UsersOUおよび配下のACL設定
#テンプレートOUからのSDDL版ACLデータ採取
$DnTemp20 = [adsi]"LDAP://ad2008r2-1.local/ou=Users,$DNPathTemp"
$Acl20 = $DnTemp20.psbase.ObjectSecurity
$Sddl20 = $Acl20.GetSecurityDescriptorSddlForm([System.Security.AccessControl.AccessControlSections]::All)

#テンプレートOUのACLデータを作成OUへの書き込み
$Dn20 = [adsi]"LDAP://ad2008r2-1.local/ou=Users,$DNPath"
$Dn20.psbase.ObjectSecurity.SetSecurityDescriptorSddlForm($Sddl20)
$Dn20.psbase.commitchanges()

$Dn21 = [adsi]"LDAP://ad2008r2-1.local/ou=mail_contact,ou=Users,$DNPath"
$Dn21.psbase.ObjectSecurity.SetSecurityDescriptorSddlForm($Sddl20)
$Dn21.psbase.commitchanges()

$Dn22 = [adsi]"LDAP://ad2008r2-1.local/ou=ML_contact,ou=Users,$DNPath"
$Dn22.psbase.ObjectSecurity.SetSecurityDescriptorSddlForm($Sddl20)
$Dn22.psbase.commitchanges()

$Dn23 = [adsi]"LDAP://ad2008r2-1.local/ou=resource,ou=Users,$DNPath"
$Dn23.psbase.ObjectSecurity.SetSecurityDescriptorSddlForm($Sddl20)
$Dn23.psbase.commitchanges()

$Dn24 = [adsi]"LDAP://ad2008r2-1.local/ou=user_default,ou=Users,$DNPath"
$Dn24.psbase.ObjectSecurity.SetSecurityDescriptorSddlForm($Sddl20)
$Dn24.psbase.commitchanges()

Write-Host "$Org OU Created!"


##Groupアカウント存在確認
$dom = [adsi] "LDAP://ad2008r2-1.local/DC=ad2008r2-1,DC=local"
$ds = New-Object System.DirectoryServices.DirectorySearcher
$ds.Filter = [string]::Format("(&(ObjectCategory=Group))")

foreach($OrgGroup in $ds.findall())
{

 $GroupName = $OrgGroup.properties.name


 if($GroupName -eq "$prefix-logon_restriction")
 {
  write-host "$org Group $prefix-logon_restriction exists"
  exit
 }
}

#グローバルグループアカウント作成
if($prefix -ne $null){
$OU = [adsi]"LDAP://ad2008r2-1.local/OU=user_default,OU=Users,OU=$org,DC=ad2008r2-1,DC=local"
$Group = $OU.Create("Group","cn=$prefix-logon_restriction")
$Group.Put("sAMAccountName","$prefix-logon_restriction")
$Group.Put("GroupType",0x80000002)
$Group.SetInfo()
Write-Host "$Prefix GrobalGroup Created!"
}else{
Write-Host "$Prefix GrobalGroup Not Created!"
}

