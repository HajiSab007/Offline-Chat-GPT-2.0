@echo off
title Setting up Local ChatGPT

REM --- STEP 1: Download and Install Python if not found ---
where python >nul 2>nul
IF %ERRORLEVEL% NEQ 0 (
    echo Python not found. Downloading Python installer...
    powershell -Command "Invoke-WebRequest -Uri https://www.python.org/ftp/python/3.10.11/python-3.10.11-amd64.exe -OutFile python_installer.exe"

    echo Installing Python silently...
    python_installer.exe /quiet InstallAllUsers=1 PrependPath=1 Include_test=0

    echo Waiting for Python to finish installing...
    timeout /t 20 >nul
) ELSE (
    echo Python is already installed.
)

REM --- STEP 2: Upgrade pip ---
python -m ensurepip --upgrade
python -m pip install --upgrade pip

REM --- STEP 3: Install required packages ---
echo Installing required Python packages...
pip install torch transformers

REM --- STEP 4: Download GPT-2 model and tokenizer for offline use ---
echo Downloading GPT-2 model and tokenizer...
python -c "from transformers import GPT2LMHeadModel, GPT2Tokenizer; GPT2LMHeadModel.from_pretrained('gpt2'); GPT2Tokenizer.from_pretrained('gpt2')"

echo.
echo Setup Complete! You can now run your local ChatGPT offline.
pause
