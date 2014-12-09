@echo off

echo DaaS PC OU作成を実施します。
set command_input1=
set/p command_input1="組織OU名を入力してください:"

echo OU名は、"%command_input1%"です。


choice /c YN /m 上記設定でOU作成を実行しますか
if errorlevel 2 goto no
echo "Y"を選択しました。
echo OU作成を実行します。
powershell .\ad_daaspc_ou_create.ps1 %command_input1%
goto end
:no
echo "N"を選択しました。
echo OU作成実行を中止します
goto end
:end

pause