@echo off
REM ============================================================
REM  一键构建并打包 flu_client (Windows installer)
REM  前置:已安装 Flutter、Inno Setup 6(D:\InnoSetup6)
REM  用法:
REM    build_windows.cmd          -- 构建 release 并打包
REM    build_windows.cmd fast     -- 仅打包(跳过 rebuild,用已有 release 产物)
REM ============================================================
setlocal
cd /d "%~dp0"

REM Inno Setup 6 安装目录(静默装到 D 盘)。若你的路径不同,改这里。
set ISCC_DIR=D:\InnoSetup6
set ISCC="%ISCC_DIR%\ISCC.exe"

set VERSION=1.0.0
for /f "tokens=2 delims=: " %%A in ('findstr /r /c:"^version:" pubspec.yaml') do set VERSION=%%A

if not exist %ISCC% (
  echo [错误] 找不到 ISCC: %ISCC%
  echo 请确认 Inno Setup 6 已安装到 D:\InnoSetup6,或修改脚本顶部 ISCC_DIR。
  exit /b 1
)

if /i "%~1" neq "fast" (
  echo [1/2] flutter build windows --release
  call flutter build windows --release
  if errorlevel 1 (
    echo 构建失败,终止。
    exit /b 1
  )
) else (
  echo [1/2] 跳过构建,直接打包已有产物
)

echo [2/2] %ISCC% setup.iss /DMyAppVersion=%VERSION%
%ISCC% "setup.iss" /DMyAppVersion=%VERSION%
if errorlevel 1 (
  echo 打包失败。请检查 setup.iss 与构建产物目录。
  exit /b 1
)

echo.
echo 完成!安装包为:flu-client-setup-%VERSION%.exe(位于本脚本所在目录)
endlocal