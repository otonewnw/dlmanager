#GPOリンク設定
#giji_gpo_link.ps1

param($org,[switch]$help,[switch]$proxy,[switch]$logon)

function HelpMe
{
 Write-Host
 Write-Host " gpo_link.ps1:" -fore Green
 Write-Host "   create GPO link"
 Write-Host
 Write-Host " Parameters:" -fore Green
 Write-Host "   -org [組織OU名]"
 Write-Host "   -help"
 Write-Host "   -proxy  proxyGPOをリンクさせる場合のフラグ"
 Write-Host "   -logon  ログオン制御ポリシーをリンクさせる場合のフラグ"
 Write-Host
 Write-Host " Examples:" -fore Green
 Write-Host "   OU'NTTネオメイト'に既定のGPOをリンクする" -fore White
 Write-Host "     .\gpo_link.ps1 -org 'NTTネオメイト'" -fore Yellow
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
$strGPO = "プロキシ設定ポリシー($org)"
$strLINK = "OU=Users,OU=$org,DC=ad2008r2-1,DC=local"



foreach($GPO in $GPOs)
{
 if($GPO.Displayname -eq $strGPO)
 {
  $LinkGPO = $GPO
  $GPODisp = $GPO.Displayname
  $gpmSom = $gpmPDC.GetSom($strLink)
  $gpmLink = $gpmSom.CreateGPOLink(-1,$LinkGPO)
  Write-Host "$strGPO をリンク設定しました"
 }
}


}

if($logon){
$strGPO = $null
$strGPO = "他社PCへのログオン制御ポリシー($org)"
$strLINK = "OU=Computers,OU=$org,DC=ad2008r2-1,DC=local"

foreach($GPO in $GPOs)
{
 if($GPO.Displayname -eq $strGPO)
 {
  $LinkGPO = $GPO
  $GPODisp = $GPO.Displayname
  $gpmSom = $gpmPDC.GetSom($strLink)
  $gpmLink = $gpmSom.CreateGPOLink(-1,$LinkGPO)
  Write-Host "$strGPO をリンク設定しました"
 }
}



}

$strGPO = $null
$strGPO = "Outlook制御ポリシーver.2.0"
$strLINK = "OU=Users,OU=$org,DC=ad2008r2-1,DC=local"

foreach($GPO in $GPOs)
{
 if($GPO.Displayname -eq $strGPO)
 {
  $LinkGPO = $GPO
  $GPODisp = $GPO.Displayname
  $gpmSom = $gpmPDC.GetSom($strLink)
  $gpmLink = $gpmSom.CreateGPOLink(-1,$LinkGPO)
  Write-Host "$strGPO をリンク設定しました"
 }
}



$strGPO = $null
$strGPO = "外部媒体制御解除ポリシー(C)ver.2.0"
$strLINK = "OU=pc_kiseikaijo_c,OU=Computers,OU=$org,DC=ad2008r2-1,DC=local"

foreach($GPO in $GPOs)
{
 if($GPO.Displayname -eq $strGPO)
 {
  $LinkGPO = $GPO
  $GPODisp = $GPO.Displayname
  $gpmSom = $gpmPDC.GetSom($strLink)
  $gpmLink = $gpmSom.CreateGPOLink(-1,$LinkGPO)
  Write-Host "$strGPO をリンク設定しました"
 }
}


$strGPO = $null
$strGPO = "外部媒体制御解除ポリシー(CF)ver.2.0"
$strLINK = "OU=pc_kiseikaijo_cf,OU=Computers,OU=$org,DC=ad2008r2-1,DC=local"

foreach($GPO in $GPOs)
{
 if($GPO.Displayname -eq $strGPO)
 {
  $LinkGPO = $GPO
  $GPODisp = $GPO.Displayname
  $gpmSom = $gpmPDC.GetSom($strLink)
  $gpmLink = $gpmSom.CreateGPOLink(-1,$LinkGPO)
  Write-Host "$strGPO をリンク設定しました"
 }
}


$strGPO = $null
$strGPO = "外部媒体制御解除ポリシー(CFU)ver.2.0"
$strLINK = "OU=pc_kiseikaijo_cfu,OU=Computers,OU=$org,DC=ad2008r2-1,DC=local"

foreach($GPO in $GPOs)
{
 if($GPO.Displayname -eq $strGPO)
 {
  $LinkGPO = $GPO
  $GPODisp = $GPO.Displayname
  $gpmSom = $gpmPDC.GetSom($strLink)
  $gpmLink = $gpmSom.CreateGPOLink(-1,$LinkGPO)
  Write-Host "$strGPO をリンク設定しました"
 }
}



$strGPO = $null
$strGPO = "外部媒体制御解除ポリシー(CU)ver.2.0"
$strLINK = "OU=pc_kiseikaijo_cu,OU=Computers,OU=$org,DC=ad2008r2-1,DC=local"

foreach($GPO in $GPOs)
{
 if($GPO.Displayname -eq $strGPO)
 {
  $LinkGPO = $GPO
  $GPODisp = $GPO.Displayname
  $gpmSom = $gpmPDC.GetSom($strLink)
  $gpmLink = $gpmSom.CreateGPOLink(-1,$LinkGPO)
  Write-Host "$strGPO をリンク設定しました"
 }
}


$strGPO = $null
$strGPO = "外部媒体制御解除ポリシー(F)ver.2.0"
$strLINK = "OU=pc_kiseikaijo_f,OU=Computers,OU=$org,DC=ad2008r2-1,DC=local"

foreach($GPO in $GPOs)
{
 if($GPO.Displayname -eq $strGPO)
 {
  $LinkGPO = $GPO
  $GPODisp = $GPO.Displayname
  $gpmSom = $gpmPDC.GetSom($strLink)
  $gpmLink = $gpmSom.CreateGPOLink(-1,$LinkGPO)
  Write-Host "$strGPO をリンク設定しました"
 }
}



$strGPO = $null
$strGPO = "外部媒体制御解除ポリシー(FU)ver.2.0"
$strLINK = "OU=pc_kiseikaijo_fu,OU=Computers,OU=$org,DC=ad2008r2-1,DC=local"

foreach($GPO in $GPOs)
{
 if($GPO.Displayname -eq $strGPO)
 {
  $LinkGPO = $GPO
  $GPODisp = $GPO.Displayname
  $gpmSom = $gpmPDC.GetSom($strLink)
  $gpmLink = $gpmSom.CreateGPOLink(-1,$LinkGPO)
  Write-Host "$strGPO をリンク設定しました"
 }
}


$strGPO = $null
$strGPO = "外部媒体制御解除ポリシー(U)ver.2.0"
$strLINK = "OU=pc_kiseikaijo_u,OU=Computers,OU=$org,DC=ad2008r2-1,DC=local"

foreach($GPO in $GPOs)
{
 if($GPO.Displayname -eq $strGPO)
 {
  $LinkGPO = $GPO
  $GPODisp = $GPO.Displayname
  $gpmSom = $gpmPDC.GetSom($strLink)
  $gpmLink = $gpmSom.CreateGPOLink(-1,$LinkGPO)
  Write-Host "$strGPO をリンク設定しました"
 }
}
