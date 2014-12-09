#OU�쐬���ݒ�
#daaspc_ou_create.ps1

Param($org,[switch]$help,$prefix)

function HelpMe
{
 Write-Host
 Write-Host " daaspc_ou_create.ps1:" -fore Green
 Write-Host "   create OU"
 Write-Host
 Write-Host " Parameters:" -fore Green
 Write-Host "   -org [�g�DOU��]"
 Write-Host "   -help"
 Write-Host
 Write-Host
}

if(!$org -or $help)
{
 HelpMe;return
}

##OU���݊m�F
$dom = [adsi] "LDAP://ad2008r2-1.local/DC=ad2008r2-1,DC=local"
$ds = New-Object System.DirectoryServices.DirectorySearcher -argumentList $dom
$ds.Filter = [string]::Format("(&(ObjectCategory=OrganizationalUnit))")
$r = 1

foreach($OrgOU in $ds.findall())
{

 $ouname = $OrgOU.properties.name


 if($OUName -eq $org)
 {
  #write-host "$org OU not exists"
  $r = 0
  continue

 }
}

if($r -eq 1){
  write-host "$org OU not exists"
  exit
}

##DaaS pc OU���݊m�F
$dom = [adsi] "LDAP://ad2008r2-1.local/OU=$org,DC=ad2008r2-1,DC=local"
$ds = New-Object System.DirectoryServices.DirectorySearcher -argumentList $dom
$ds.Filter = [string]::Format("(&(ObjectCategory=OrganizationalUnit))")
#$ds.findall()
foreach($OrgOU in $ds.findall())
{

 $ouname = $OrgOU.properties.name

 if($OUName -eq "system_daas")
 {
  write-host "$org DaaS pc OU exists"
  exit
 }
}

#DaaS�pComputersOU�z���̍쐬
$dom03 = [adsi] "LDAP://ad2008r2-1.local/OU=Computers,OU=$org,DC=ad2008r2-1,DC=local"

$newOU110 = $dom03.Create("OrganizationalUnit","OU=pc_daas_c")
$newOU110.SetInfo()
$newOU111 = $dom03.Create("OrganizationalUnit","OU=pc_daas_s")
$newOU111.SetInfo()
$newOU112 = $dom03.Create("OrganizationalUnit","OU=pc_daas_m")
$newOU112.SetInfo()
$newOU113 = $dom03.Create("OrganizationalUnit","OU=system_daas")
$newOU113.SetInfo()


##OU��ACL�ݒ�
#DN�ݒ�
$DnPath = "OU=$Org,DC=ad2008r2-1,DC=local"
$DnPathTemp = "OU=NTT�l�I���C�g,DC=ad2008r2-1,DC=local"


#DaaSOU��ACL�ݒ�
#�e���v���[�gOU�����SDDL��ACL�f�[�^�̎�
$DnTemp110 = [adsi]"LDAP://ad2008r2-1.local/ou=pc_daas_s,ou=Computers,$DNPathTemp"
$Acl110 = $DnTemp110.psbase.ObjectSecurity
$Sddl110 = $Acl110.GetSecurityDescriptorSddlForm([System.Security.AccessControl.AccessControlSections]::All)

#�e���v���[�gOU��ACL�f�[�^���쐬OU�ւ̏�������
$Dn110 = [adsi]"LDAP://ad2008r2-1.local/ou=pc_daas_s,ou=Computers,$DNPath"
$Dn110.psbase.ObjectSecurity.SetSecurityDescriptorSddlForm($Sddl110)
$Dn110.psbase.commitchanges()

$Dn111 = [adsi]"LDAP://ad2008r2-1.local/ou=pc_daas_m,ou=Computers,$DNPath"
$Dn111.psbase.ObjectSecurity.SetSecurityDescriptorSddlForm($Sddl110)
$Dn111.psbase.commitchanges()

$Dn112 = [adsi]"LDAP://ad2008r2-1.local/ou=system_daas,ou=Computers,$DNPath"
$Dn112.psbase.ObjectSecurity.SetSecurityDescriptorSddlForm($Sddl110)
$Dn112.psbase.commitchanges()

Write-Host "$Org DaaS pc OU Created!"