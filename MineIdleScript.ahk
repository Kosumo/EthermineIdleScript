#MaxThreadsPerHotkey 2

IniRead, 

;Hotkey part
IniRead, Shortcut, config.ini, Shortcuts, Shortcut
Hotkey, %Shortcut%, Shortcut

Shortcut:
	Msgbox Shortcut pressed
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
		Run %GpuMineScript%
		SetWorkingDir %CPUMineDir%
		Run %CpuMineScript%
		SetWorkingDir %HDDMineDir%
		Run %HDDMineScript%
	}