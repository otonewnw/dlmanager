@echo off

echo DaaS PC OU�쐬�����{���܂��B
set command_input1=
set/p command_input1="�g�DOU������͂��Ă�������:"

echo OU���́A"%command_input1%"�ł��B


choice /c YN /m ��L�ݒ��OU�쐬�����s���܂���
if errorlevel 2 goto no
echo "Y"��I�����܂����B
echo OU�쐬�����s���܂��B
powershell .\ad_daaspc_ou_create.ps1 %command_input1%
goto end
:no
echo "N"��I�����܂����B
echo OU�쐬���s�𒆎~���܂�
goto end
:end

pause