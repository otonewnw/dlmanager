@echo off


:loop
choice /c YN /m DaaS�p���[�U�[OU�쐬�����s���܂���
if errorlevel 2 goto no
if errorlevel 1 goto yes

:yes
echo "Y"��I�����܂����B
echo OU�쐬�����s���܂�

goto loop


:no
echo "N"��I�����܂����B
echo OU�쐬���s���I�����܂�
goto end


:end
pause