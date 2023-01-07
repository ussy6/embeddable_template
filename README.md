# embeddable template

## Overview

「embeddable」を使用するために必要な作業を終わらせたフォルダをここに保管しておく．「embeddable」は軽量なPythonの実行環境．Pythonの環境がない人にスクリプトを配布する際に便利．

## Requirement

Windowsでしか使えない．

## Usage

- 使いたいバージョンのフォルダをWinsowsマシンにダウンロードする．フォルダ名の数字はPythonのバージョンに対応している．
- codeフォルダに動かしたいpythonスクリプトを入れる．
- python_console.batを開いてpip install ~ で必要なライブラリをインストールする．
- jupyterを使いたい場合はpip install jupyterを叩いて置いた後，jupyter notebook ../code で起動する．pipが使えないときはpython get-pip.pyとしてからライブラリを入れなおす．
- 配布するときはバッチファイルを作っておく．例えばrun.cmdというようなファイルを作って下記の内容を書いておき，ダブルクリックするとapp.pyが実行される．
```
rem
call setenv.bat
cd code
python app.py
pause
```
- jupyterをcodeフォルダで起動したければこのようにすれば良い．
```
rem
call setenv.bat
jupyter notebook ../code
pause
```

## How to make
このフォルダの作り方．
主にhttps://hituji-ws.com/code/python/python-emb-usage/を参考にした．

### 

https://www.python.org/downloads/windows/　から使いたいバージョンのZIPファイルをダウンロードする．基本は64bit版で良い．

PYTHON_PATHはバージョンというかpython embededdのフォルダ名に変える．

### setenv.bat

```
SET DP0=%~dp0
SET DP0=%DP0:~0,-1%

rem overriding windows user/local environment
SET LOCALENV_DIR=%DP0%\_local_env
SET TMP=%LOCALENV_DIR%\_tmp
SET TEMP=%LOCALENV_DIR%\_tmp
SET HOME=%LOCALENV_DIR%\userprofile
SET HOMEPATH=%LOCALENV_DIR%\userprofile
SET USERPROFILE=%LOCALENV_DIR%\userprofile
SET LOCALAPPDATA=%LOCALENV_DIR%\localappdata
SET APPDATA=%LOCALENV_DIR%\userroaming

SET PYTHON_PATH=%DP0%\python-3.6.8

rem overriding default python env vars in order to interfere with any system python installation
SET PYTHONHOME=
SET PYTHONPATH=
SET PYTHONEXECUTABLE=%PYTHON_PATH%\python.exe
SET PYTHONWEXECUTABLE=%PYTHON_PATH%\pythonw.exe

SET PYTHON_EXECUTABLE=%PYTHON_PATH%\python.exe
SET PYTHONW_EXECUTABLE=%PYTHON_PATH%\pythonw.exe
SET PYTHON_BIN_PATH=%PYTHON_EXECUTABLE%
SET PYTHON_LIB_PATH=%PYTHON_PATH%\Lib\site-packages
SET PATH=%PYTHON_PATH%;%PYTHON_PATH%\Scripts;%DP0%\CMake\Bin;%PATH%
SET DISTUTILS_USE_SDK=1
```

### python_console.bat
こちらもpython-3.6.8をpython embededdのフォルダ名に変える．
```
@echo off
cd /D %~dp0
call setenv.bat
cd python-3.6.8
cmd
```

### PIPを使えるようにする
get-pip.pyをダウンロードしてpython embededdのフォルダに入れる．
https://bootstrap.pypa.io/
python_console.batから下記を入力．
```
python get-pip.py
```

### python~._pthの編集
python embededdのフォルダにあるpython~._pthのimport siteの前にある#を削除する．

### ライブラリインストール
```
pip install numpy
pip install pandas
pip install matplotlib
```

### wxPythonのインストール
embeddable番Pythonには「tkinter」というモジュールが存在しないため，matplotlibなどでGUIを使おうとすると表示されない．代わりに「wxPython」をインストールする．
pip install wxpython

以下でmatplotlibの設定ファイルを探す．

```
python -c "import matplotlib; print(matplotlib.matplotlib_fname())"
```

表示された場所のファイルを開き，下記の通り書き換える．
```
backend: TkAgg
　↓
backend: WXAgg
```

参考：https://qiita.com/rhene/items/68941aced93ccc9c3071


### .pthの追加
python.exeのあるディレクトリにcurrent.pthを作成し，下記の内容を書き込む．
```
import sys; sys.path.append('')
```

>通常Pythonはカレントディレクトリに存在するPythonファイルをimportできるのですが、embeddable版ではパスが通らずアクセスできない状態になっています。
このため、特定のモジュールのインストールスクリプトが自身のモジュールを参照できずにエラーになってしまいます。

参考：https://qiita.com/rhene/items/529386ce9b7c86cfe401

