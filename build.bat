@echo off

set /p version=<build_version

set "platform=windows"
set "arch=x86_64"
set "tuple=%version%-%platform%-%arch%"
set "target=target"
set "bin=%target%\bin\reproto"
set "upload=%target%\upload"
set "archive=%upload%\reproto-%tuple%.tar.gz"
set "git=https://github.com/reproto/reproto"

echo Building: %tuple%
cargo install --root %target% --git %git% --tag %version% reproto

If NOT exist %bin% (
    echo "Binary not found: %bin%"
    Exit 1
)

7za.exe a -ttar -so archive.tar %bin% | 7za.exe a -si %archive%
Exit 0
