#MaxThreadsPerHotkey 2
#Persistent


;GPUMining
IniRead, GPUMineDir, config.ini, GPUMining, GPUMineDir
IniRead, GPUMineScript, config.ini, GPUMining, GPUMineScript
IniRead, GPUWindowTitle, config.ini, GPUMining, GPUWindowTitle

;GPUOverclock
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

TimeIdleMin := TimeIdle * 6000
Hotkey, %TimeToggleShortcut%, TimeToggleShortcut, On
SetTimer, CheckIdle, 1000


Idle := false
CheckIdle:
	if A_TimeIdlePhysical > %TimeIdleMin%
	{
		if (Idle= false)
		{
			Idle:= true
			Gosub, MineScripts
		}
	}
	else
	{
		Idle:= false
		
	}
return

TimeToggle := false
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
	
MineScripts:
	if (TimeToggle=true) && (Idle=true)
	{
		SetWorkingDir %GPUMineDir%
		Run %GPUMineScript%
		SetWorkingDir %CPUMineDir%
		Run %CPUMineScript%
		SetWorkingDir %HDDMineDir%
		Run %HDDMineScript%
	}
return

MineScriptShortcut:
	