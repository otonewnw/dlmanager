@echo off
echo GPOリンク設定を実施します。

set command_input1=
set/p command_input1="OU名を入力してください:"

echo OU名は、"%command_input1%"です。

choice /c YN /m ログオン制御ポリシーをリンクしますか
if errorlevel 2 goto no
echo "N"を選択しました。
goto end
:no
echo "Y"を選択しました。
set command_input_l="-logon"
set command_input_l2=ログオン制御ポリシーをリンクしない、
goto end
:end

choice /c YN /m プロキシ設定ポリシーをリンクしますか
if errorlevel 2 goto no
echo "N"を選択しました。
goto end
:no
echo "Y"を選択しました。
set command_input_p="-proxy"
set command_input_p2=プロキシ設定ポリシーをリンクしない、
goto end
:end

echo OU名は"%command_input1%"、%command_input_l2%%command_input_p2%で設定します。

choice /c YN /m 上記設定でOU作成を実行しますか
if errorlevel 2 goto no
echo "Y"を選択しました。
echo OU作成を実行します
powershell .\ad_gpo_link.ps1 -org %command_input1% %command_input_l% %command_input_p%
goto end
:no
echo "N"を選択しました。
echo OU作成実行を中止します
goto end
:end

pause