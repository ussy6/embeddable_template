cd /D %~dp0
cd python-3.8.2-embed-amd64
call setenv.bat
jupyter notebook ../code
pause