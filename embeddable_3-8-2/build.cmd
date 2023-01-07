cd /D %~dp0
call setenv.bat
cd python-3.8.2-embed-amd64
python get-pip.py
pip install numpy
pip install pandas
pip install matplotlib
pip install datetime
pip install jupyter
pause