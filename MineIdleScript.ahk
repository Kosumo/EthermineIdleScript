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

;Shortcuts
IniRead, TimeToggleShortcut, config.ini, Shortcuts, TimeToggleShortcut 

SetTimer, CheckIdle, 1000

Idle := false
CheckIdle:
	if (A_TimeIdlePhysical > 5000)
	{
		if (Idle= false)
		{
			Msgbox idle
			Idle:= true
		}
	}
	else
	{
		Idle:= false
		
	}
return

TimeToggle := false
TimeToggleShortcut:
	if (toggle= false)
	{
		TimeToggle := true
		Msgbox Idle timer on
	}
	else
	{
		TimeToggle := false
		Msgbox Idle timer off
	}
return
	
MineScripts:
	if (TimeToggle=true) && (Idle=true)
	{
		Msgbox werkt
		IfWinActive, %GPUWindowTitle% 
		{
			WinClose, %GPUWindowTitle%
			WinClose, %CPUWindowTitle%
			WinClose, %HDDWindowTitle%
			Sleep, 1000
		}
		else 
		{
		SetWorkingDir %GPUMineDir%
		Run %GPUMineScript%
		SetWorkingDir %CPUMineDir%
		Run %CPUMineScript%
		SetWorkingDir %HDDMineDir%
		Run %HDDMineScript%
		}
	}
return