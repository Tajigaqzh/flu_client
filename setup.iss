; ============================================================
;  Inno Setup 打包脚本 —— flu_client (Windows)
;  用法(需先安装 Inno Setup,并确保 iscc 在 PATH):
;     1) flutter build windows --release
;     2) iscc setup.iss
;  产物: 输出目录下  flu-client-setup-<版本>.exe
; ============================================================

#define MyAppName "Flu Client"
#define MyAppExeName "flu_client.exe"
#define MyAppBuildDir "build\windows\x64\runner\Release"
#define MyAppIcon "windows\runner\resources\app_icon.ico"
; 版本号从 pubspec 读出后,可用 /DMyAppVersion=x.y.z 覆盖。
#ifndef MyAppVersion
  #define MyAppVersion "1.0.0"
#endif

[Setup]
AppId={{8C2E1F3A-0000-4C00-8000-FLUC00000000}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher=Demo Project
DefaultDirName={autopf}\{#MyAppName}
DefaultGroupName={#MyAppName}
DisableProgramGroupPage=yes
OutputBaseFilename=flu-client-setup-{#MyAppVersion}
Compression=lzma2
SolidCompression=yes
WizardStyle=modern
SetupIconFile={#MyAppIcon}
UninstallDisplayIcon={app}\{#MyAppExeName}
; 需要 .NET 桌面运行时吗?Flutter 桌面不依赖;这里关闭 .NET 检查。
PrivilegesRequired=admin

[Languages]
; 让安装向导显示中文。要求你已安装 Inno Setup 的 "Unofficial Chinese" 语言包,
; 然后编译时加 /DChinese=1 开启(未装前直接用默认英文,跳过本段):
;      iscc /DChinese=1 setup.iss
#ifdef Chinese
Name: "chinesesimp"; MessagesFile: "compiler:Languages\ChineseSimplified.isl"
#endif

[Tasks]
Name: "desktopicon"; Description: "创建桌面快捷方式"; GroupDescription: "附加图标:"; Flags: unchecked

[Files]
Source: "{#MyAppBuildDir}\*"; DestDir: "{app}"; Flags: recursesubdirs ignoreversion

[Icons]
Name: "{group}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"
Name: "{autodesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon

[Run]
Filename: "{app}\{#MyAppExeName}"; Description: "运行 {#MyAppName}"; Flags: nowait postinstall skipifsilent