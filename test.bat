@echo off


:loop
choice /c YN /m DaaS用ユーザーOU作成を実行しますか
if errorlevel 2 goto no
if errorlevel 1 goto yes

:yes
echo "Y"を選択しました。
echo OU作成を実行します

goto loop


:no
echo "N"を選択しました。
echo OU作成実行を終了します
goto end


:end
pause