@echo off
echo GPO�����N�ݒ�����{���܂��B

set command_input1=
set/p command_input1="OU������͂��Ă�������:"

echo OU���́A"%command_input1%"�ł��B

choice /c YN /m ���O�I������|���V�[�������N���܂���
if errorlevel 2 goto no
echo "N"��I�����܂����B
goto end
:no
echo "Y"��I�����܂����B
set command_input_l="-logon"
set command_input_l2=���O�I������|���V�[�������N���Ȃ��A
goto end
:end

choice /c YN /m �v���L�V�ݒ�|���V�[�������N���܂���
if errorlevel 2 goto no
echo "N"��I�����܂����B
goto end
:no
echo "Y"��I�����܂����B
set command_input_p="-proxy"
set command_input_p2=�v���L�V�ݒ�|���V�[�������N���Ȃ��A
goto end
:end

echo OU����"%command_input1%"�A%command_input_l2%%command_input_p2%�Őݒ肵�܂��B

choice /c YN /m ��L�ݒ��OU�쐬�����s���܂���
if errorlevel 2 goto no
echo "Y"��I�����܂����B
echo OU�쐬�����s���܂�
powershell .\ad_gpo_link.ps1 -org %command_input1% %command_input_l% %command_input_p%
goto end
:no
echo "N"��I�����܂����B
echo OU�쐬���s�𒆎~���܂�
goto end
:end

pause