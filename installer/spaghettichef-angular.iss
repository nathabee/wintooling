#ifndef AppVersion
#define AppVersion "0.0.0"
#endif

#ifndef SourceDir
#define SourceDir "..\package\windows\spaghettichef-angular"
#endif

#ifndef OutputDir
#define OutputDir "..\dist"
#endif

#define AppName "SpaghettiChef Angular"
#define AppPublisher "SpaghettiChef"
#define AppUrl "https://github.com/nathabee/wintooling"

[Setup]
AppId={{5B4E2849-F591-4F75-9DC2-4D87E222F15A}
AppName={#AppName}
AppVersion={#AppVersion}
AppPublisher={#AppPublisher}
AppPublisherURL={#AppUrl}
AppSupportURL={#AppUrl}
AppUpdatesURL={#AppUrl}
DefaultDirName={autopf}\SpaghettiChef Angular
DefaultGroupName={#AppName}
DisableProgramGroupPage=yes
OutputDir={#OutputDir}
OutputBaseFilename=SpaghettiChefAngularSetup-{#AppVersion}
Compression=lzma2
SolidCompression=yes
WizardStyle=modern
PrivilegesRequired=admin
ArchitecturesInstallIn64BitMode=x64compatible
UninstallDisplayIcon={app}\public\favicon.ico

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Files]
Source: "{#SourceDir}\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs

[Icons]
Name: "{autoprograms}\SpaghettiChef Angular"; Filename: "{app}\public\index.html"; WorkingDir: "{app}\public"
Name: "{autoprograms}\SpaghettiChef Angular README"; Filename: "{app}\README.md"
Name: "{autodesktop}\SpaghettiChef Angular"; Filename: "{app}\public\index.html"; WorkingDir: "{app}\public"; Tasks: desktopicon

[Tasks]
Name: "desktopicon"; Description: "Create a desktop shortcut"; GroupDescription: "Additional shortcuts:"; Flags: unchecked

[Run]
Filename: "{app}\public\index.html"; Description: "Open SpaghettiChef Angular"; Flags: postinstall shellexec skipifsilent nowait
