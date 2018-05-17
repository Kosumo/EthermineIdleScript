#MaxThreadsPerHotkey 2
#Persistent


;GPUMining
IniRead, GPUMineDir, config.ini, GPUMining, GPUMineDir
IniRead, GPUMineScript, config.ini, GPUMining, GPUMineScript
IniRead, GPUWindowTitle, config.ini, GPUMining, GPUWindowTitle

;GPUOverclock
IniRead, Overclock, config.ini, Overclock, Overclock
IniRead, NvidiaInspectorLocation, config.ini, Overclock, NvidiaInspectorLocation
IniRead, GpuClockOffset, config.ini, Overclock, GpuClockOffset
IniRead, MemClockOffset, config.ini, Overclock, MemClockOffset
IniRead, PowerTarget, config.ini, Overclock, PowerTarget

;CPUMining
IniRead, CPUMineDir, config.ini, CPUMining, CPUMineDir
IniRead, CPUMineScript, config.ini, CPUMining, CPUMineScript
IniRead, CPUWindowTitle, config.ini, CPUMining, CPUWindowTitle

;HDDMining
IniRead, HDDMineDir, config.ini, HDDMining, HDDMineDir
IniRead, HDDMineScript, config.ini, HDDMining, HDDMineScript
IniRead, HDDWindowTitle, config.ini, HDDMining, HDDWindowTitle

;Time
IniRead, TimeIdle, config.ini, TimeIdle, TimeIdle

;Shortcuts
IniRead, TimeToggleShortcut, config.ini, Shortcuts, TimeToggleShortcut
IniRead, MineScriptShortcut, config.ini, Shortcuts, MineScriptShortcut
IniRead, CloseShortcut, config.ini, Shortcuts, CloseShortcut

TimeToggle := true
TimeIdleMin := TimeIdle * 60000
Hotkey, %TimeToggleShortcut%, TimeToggleShortcut, On
Hotkey, %MineScriptShortcut%, MineScriptShortcut, On
Hotkey, %CloseShortcut%, CloseShortcut, On
SetTimer, CheckIdle, 1000


Idle := false
CheckIdle:
	if A_TimeIdlePhysical > %TimeIdleMin%
	{
		if (Idle= false)
		{
			Idle:= true
			Gosub, TimeAndToggle
		}
	}
	else
	{
		Idle:= false
		
	}
return

TimeToggleShortcut:
	if (TimeToggle= false)
	{
		TimeToggle := true
		Traytip, , Idle timer On, 5
	}
	else
	{
		TimeToggle := false
		Traytip, , Idle timer Off, 5
	}
return

TimeAndToggle:
	if (TimeToggle=true) && (Idle=true) 
	{
		If WinExist(GPUWindowTitle) or WinExist(CPUWindowTitle) or WinExist(HDDWindowTitle)
		{
			return
		}
		else
		{
			Gosub, MineScripts
		}
	}
return

MineScriptShortcut:
	Gosub, MineScripts
return

MineScripts:
	SetWorkingDir %GPUMineDir%
	Run %GPUMineScript%
	SetWorkingDir %CPUMineDir%
	Run %CPUMineScript%
	SetWorkingDir %HDDMineDir%
	Run %HDDMineScript%
return

CloseShortcut:
	WinClose, %GPUWindowTitle%
	WinClose, %CPUWindowTitle%
	WinClose, %HDDWindowTitle%
return