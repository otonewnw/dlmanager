@echo off

:loop

echo DaaS���[�U�[OU�쐬�����{���܂��B
set command_input1=
set/p command_input1="�g�DOU������͂��Ă�������:"
echo �g�DOU���́A"%command_input1%"�ł��B

set command_input2=
set/p command_input2="DaaS���[�U�[OU������͂��Ă�������:"
echo �g�D���ʎq�́A"%command_input2%"�ł��B
echo �g�DOU����"%command_input1%"�ŁADaaS���[�U�[OU����"%command_input2%"�ł��B


choice /c YN /m DaaS�p���[�U�[OU�쐬�����s���܂���
if errorlevel 2 goto no
if errorlevel 1 goto yes

:yes
echo "Y"��I�����܂����B
echo OU�쐬�����s���܂�
powershell .\ad_daasuser_ou_create.ps1 -org %command_input1% -ou %command_input2%
choice /c YN /m �����DaaS�p���[�U�[OU�쐬�����܂���
if errorlevel 2 goto no
if errorlevel 1 goto loop

:no
echo "N"��I�����܂����B
echo OU�쐬���s���I�����܂�
goto end

:end
pause