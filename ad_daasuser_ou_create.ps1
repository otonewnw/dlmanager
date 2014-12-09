#OU�쐬���ݒ�
#daasuser_ou_create.ps1

Param($org,[switch]$help,$prefix,$ou)

function HelpMe
{
 Write-Host
 Write-Host " daasuser_ou_create.ps1:" -fore Green
 Write-Host "   create OU"
 Write-Host
 Write-Host " Parameters:" -fore Green
 Write-Host "   -org [�g�DOU��]"
 Write-Host "   -help"
 Write-Host "   -ou [ou��]"

}

if(!$org -or $help)
{
 HelpMe;return
}

##OU���݊m�F
$dom = [adsi] "LDAP://ad2008r2-1.local/DC=ad2008r2-1,DC=local"
$ds = New-Object System.DirectoryServices.DirectorySearcher
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

##DaaS user OU���݊m�F
$dom = [adsi] "LDAP://ad2008r2-1.local/OU=Users,OU=$org,DC=ad2008r2-1,DC=local"
$ds = New-Object System.DirectoryServices.DirectorySearcher -argumentList $dom
$ds.Filter = [string]::Format("(&(ObjectCategory=OrganizationalUnit))")
#$ds.findall()
foreach($OrgOU in $ds.findall())
{

 $ouname = $OrgOU.properties.name

 if($OUName -eq $ou)
 {
  write-host "$org DaaS user OU exists"
  exit
 }
}



#UsersOU�z���̍쐬
$dom04 = [adsi] "LDAP://ad2008r2-1.local/OU=Users,OU=$org,DC=ad2008r2-1,DC=local"
$newOU201 = $dom04.Create("OrganizationalUnit","OU=$ou")
$newOU201.SetInfo()


##OU��ACL�ݒ�
#DN�ݒ�
$DnPath = "OU=$Org,DC=ad2008r2-1,DC=local"
$DnPathTemp = "OU=NTT�l�I���C�g,DC=ad2008r2-1,DC=local"


#UsersOU����єz����ACL�ݒ�
#�e���v���[�gOU�����SDDL��ACL�f�[�^�̎�
$DnTemp20 = [adsi]"LDAP://ad2008r2-1.local/ou=user_daas_c01,ou=Users,$DNPathTemp"
$Acl20 = $DnTemp20.psbase.ObjectSecurity
$Sddl20 = $Acl20.GetSecurityDescriptorSddlForm([System.Security.AccessControl.AccessControlSections]::All)

#�e���v���[�gOU��ACL�f�[�^���쐬OU�ւ̏�������
$Dn20 = [adsi]"LDAP://ad2008r2-1.local/ou=$ou,ou=Users,$DNPath"
$Dn20.psbase.ObjectSecurity.SetSecurityDescriptorSddlForm($Sddl20)
$Dn20.psbase.commitchanges()

Write-Host "$org DaaS user OU $ou Created!"
