#GPO�����N�ݒ�
#giji_gpo_link.ps1

param($org,[switch]$help,[switch]$proxy,[switch]$logon)

function HelpMe
{
 Write-Host
 Write-Host " gpo_link.ps1:" -fore Green
 Write-Host "   create GPO link"
 Write-Host
 Write-Host " Parameters:" -fore Green
 Write-Host "   -org [�g�DOU��]"
 Write-Host "   -help"
 Write-Host "   -proxy  proxyGPO�������N������ꍇ�̃t���O"
 Write-Host "   -logon  ���O�I������|���V�[�������N������ꍇ�̃t���O"
 Write-Host
 Write-Host " Examples:" -fore Green
 Write-Host "   OU'NTT�l�I���C�g'�Ɋ����GPO�������N����" -fore White
 Write-Host "     .\gpo_link.ps1 -org 'NTT�l�I���C�g'" -fore Yellow
 Write-Host
}

if(!$org -or $help)
{
 HelpMe;return
}

$strdom = "ad2008r2-1.local"

$gpm = new-object -ComObject GPMgmt.GPM
$gpmConstants = $gpm.GetConstants()
$gpmPDC = $gpm.GetDomain($strDom, "", $gpmConstants.UsePDC)

$gpmDom = $gpm.GetDomain($strDom, "", $gpmConstants.UseAnyDC)
$gpmGsc = $gpm.CreateSearchCriteria()
$GPOs = $gpmDom.SearchGPOs($gpmGsc)

if($proxy){
$strGPO = $null
$strGPO = "�v���L�V�ݒ�|���V�[($org)"
$strLINK = "OU=Users,OU=$org,DC=ad2008r2-1,DC=local"



foreach($GPO in $GPOs)
{
 if($GPO.Displayname -eq $strGPO)
 {
  $LinkGPO = $GPO
  $GPODisp = $GPO.Displayname
  $gpmSom = $gpmPDC.GetSom($strLink)
  $gpmLink = $gpmSom.CreateGPOLink(-1,$LinkGPO)
  Write-Host "$strGPO �������N�ݒ肵�܂���"
 }
}


}

if($logon){
$strGPO = $null
$strGPO = "����PC�ւ̃��O�I������|���V�[($org)"
$strLINK = "OU=Computers,OU=$org,DC=ad2008r2-1,DC=local"

foreach($GPO in $GPOs)
{
 if($GPO.Displayname -eq $strGPO)
 {
  $LinkGPO = $GPO
  $GPODisp = $GPO.Displayname
  $gpmSom = $gpmPDC.GetSom($strLink)
  $gpmLink = $gpmSom.CreateGPOLink(-1,$LinkGPO)
  Write-Host "$strGPO �������N�ݒ肵�܂���"
 }
}



}

$strGPO = $null
$strGPO = "Outlook����|���V�[ver.2.0"
$strLINK = "OU=Users,OU=$org,DC=ad2008r2-1,DC=local"

foreach($GPO in $GPOs)
{
 if($GPO.Displayname -eq $strGPO)
 {
  $LinkGPO = $GPO
  $GPODisp = $GPO.Displayname
  $gpmSom = $gpmPDC.GetSom($strLink)
  $gpmLink = $gpmSom.CreateGPOLink(-1,$LinkGPO)
  Write-Host "$strGPO �������N�ݒ肵�܂���"
 }
}



$strGPO = $null
$strGPO = "�O���}�̐�������|���V�[(C)ver.2.0"
$strLINK = "OU=pc_kiseikaijo_c,OU=Computers,OU=$org,DC=ad2008r2-1,DC=local"

foreach($GPO in $GPOs)
{
 if($GPO.Displayname -eq $strGPO)
 {
  $LinkGPO = $GPO
  $GPODisp = $GPO.Displayname
  $gpmSom = $gpmPDC.GetSom($strLink)
  $gpmLink = $gpmSom.CreateGPOLink(-1,$LinkGPO)
  Write-Host "$strGPO �������N�ݒ肵�܂���"
 }
}


$strGPO = $null
$strGPO = "�O���}�̐�������|���V�[(CF)ver.2.0"
$strLINK = "OU=pc_kiseikaijo_cf,OU=Computers,OU=$org,DC=ad2008r2-1,DC=local"

foreach($GPO in $GPOs)
{
 if($GPO.Displayname -eq $strGPO)
 {
  $LinkGPO = $GPO
  $GPODisp = $GPO.Displayname
  $gpmSom = $gpmPDC.GetSom($strLink)
  $gpmLink = $gpmSom.CreateGPOLink(-1,$LinkGPO)
  Write-Host "$strGPO �������N�ݒ肵�܂���"
 }
}


$strGPO = $null
$strGPO = "�O���}�̐�������|���V�[(CFU)ver.2.0"
$strLINK = "OU=pc_kiseikaijo_cfu,OU=Computers,OU=$org,DC=ad2008r2-1,DC=local"

foreach($GPO in $GPOs)
{
 if($GPO.Displayname -eq $strGPO)
 {
  $LinkGPO = $GPO
  $GPODisp = $GPO.Displayname
  $gpmSom = $gpmPDC.GetSom($strLink)
  $gpmLink = $gpmSom.CreateGPOLink(-1,$LinkGPO)
  Write-Host "$strGPO �������N�ݒ肵�܂���"
 }
}



$strGPO = $null
$strGPO = "�O���}�̐�������|���V�[(CU)ver.2.0"
$strLINK = "OU=pc_kiseikaijo_cu,OU=Computers,OU=$org,DC=ad2008r2-1,DC=local"

foreach($GPO in $GPOs)
{
 if($GPO.Displayname -eq $strGPO)
 {
  $LinkGPO = $GPO
  $GPODisp = $GPO.Displayname
  $gpmSom = $gpmPDC.GetSom($strLink)
  $gpmLink = $gpmSom.CreateGPOLink(-1,$LinkGPO)
  Write-Host "$strGPO �������N�ݒ肵�܂���"
 }
}


$strGPO = $null
$strGPO = "�O���}�̐�������|���V�[(F)ver.2.0"
$strLINK = "OU=pc_kiseikaijo_f,OU=Computers,OU=$org,DC=ad2008r2-1,DC=local"

foreach($GPO in $GPOs)
{
 if($GPO.Displayname -eq $strGPO)
 {
  $LinkGPO = $GPO
  $GPODisp = $GPO.Displayname
  $gpmSom = $gpmPDC.GetSom($strLink)
  $gpmLink = $gpmSom.CreateGPOLink(-1,$LinkGPO)
  Write-Host "$strGPO �������N�ݒ肵�܂���"
 }
}



$strGPO = $null
$strGPO = "�O���}�̐�������|���V�[(FU)ver.2.0"
$strLINK = "OU=pc_kiseikaijo_fu,OU=Computers,OU=$org,DC=ad2008r2-1,DC=local"

foreach($GPO in $GPOs)
{
 if($GPO.Displayname -eq $strGPO)
 {
  $LinkGPO = $GPO
  $GPODisp = $GPO.Displayname
  $gpmSom = $gpmPDC.GetSom($strLink)
  $gpmLink = $gpmSom.CreateGPOLink(-1,$LinkGPO)
  Write-Host "$strGPO �������N�ݒ肵�܂���"
 }
}


$strGPO = $null
$strGPO = "�O���}�̐�������|���V�[(U)ver.2.0"
$strLINK = "OU=pc_kiseikaijo_u,OU=Computers,OU=$org,DC=ad2008r2-1,DC=local"

foreach($GPO in $GPOs)
{
 if($GPO.Displayname -eq $strGPO)
 {
  $LinkGPO = $GPO
  $GPODisp = $GPO.Displayname
  $gpmSom = $gpmPDC.GetSom($strLink)
  $gpmLink = $gpmSom.CreateGPOLink(-1,$LinkGPO)
  Write-Host "$strGPO �������N�ݒ肵�܂���"
 }
}
