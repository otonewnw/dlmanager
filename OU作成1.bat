@echo off

echo OU作成を実施します。
set command_input1=
set/p command_input1="OU名を入力してください:"

echo OU名は、"%command_input1%"です。


set command_input2=
set/p command_input2="組織識別子を入力してください:"

echo 組織識別子は、"%command_input2%"です。


echo OU名は"%command_input1%"で、組織識別子は"%command_input2%"です。

choice /c YN /m 上記設定でOU作成を実行しますか
if errorlevel 2 goto no
echo "Y"を選択しました。
echo OU作成を実行します。
powershell .\ad_ou_create.ps1 %command_input1% %command_input2%
goto end
:no
echo "N"を選択しました。
echo OU作成実行を中止します
goto end
:end

pause