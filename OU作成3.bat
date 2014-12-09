@echo off

:loop

echo DaaSユーザーOU作成を実施します。
set command_input1=
set/p command_input1="組織OU名を入力してください:"
echo 組織OU名は、"%command_input1%"です。

set command_input2=
set/p command_input2="DaaSユーザーOU名を入力してください:"
echo 組織識別子は、"%command_input2%"です。
echo 組織OU名は"%command_input1%"で、DaaSユーザーOU名は"%command_input2%"です。


choice /c YN /m DaaS用ユーザーOU作成を実行しますか
if errorlevel 2 goto no
if errorlevel 1 goto yes

:yes
echo "Y"を選択しました。
echo OU作成を実行します
powershell .\ad_daasuser_ou_create.ps1 -org %command_input1% -ou %command_input2%
choice /c YN /m さらにDaaS用ユーザーOU作成をしますか
if errorlevel 2 goto no
if errorlevel 1 goto loop

:no
echo "N"を選択しました。
echo OU作成実行を終了します
goto end

:end
pause