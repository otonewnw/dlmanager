@echo off

echo OU�쐬�����{���܂��B
set command_input1=
set/p command_input1="OU������͂��Ă�������:"

echo OU���́A"%command_input1%"�ł��B


set command_input2=
set/p command_input2="�g�D���ʎq����͂��Ă�������:"

echo �g�D���ʎq�́A"%command_input2%"�ł��B


echo OU����"%command_input1%"�ŁA�g�D���ʎq��"%command_input2%"�ł��B

choice /c YN /m ��L�ݒ��OU�쐬�����s���܂���
if errorlevel 2 goto no
echo "Y"��I�����܂����B
echo OU�쐬�����s���܂��B
powershell .\ad_ou_create.ps1 %command_input1% %command_input2%
goto end
:no
echo "N"��I�����܂����B
echo OU�쐬���s�𒆎~���܂�
goto end
:end

pause