IniRead, TimeAfk, config.ini, Time_Afk, Time_Afk
IniRead, MineScriptLocation, config.ini, Paths, Ethereum_Mine_Start_Script_Location
IniRead, NvidiaInspectorLocation, config.ini, Paths, Nvidia_Inspector_Location
IniRead, GpuClock, config.ini, Overclock, GpuClockOffset
IniRead, MemClock, config.ini, Overclock, MemClockOffset
IniRead, PowerTarget, config.ini, Overclock, Powertarget
IniRead, MineShortcut, config.ini, Shortcuts, Shortcut

TimeAfkMin = %TimeAfk%*60000 ;Determines time in minutes
highgpuclock = -setBaseClockOffset:0,0,%GpuClock% -setMemoryClockOffset:0,0,%MemClock% -setpowertarget:0,%PowerTarget% -forcepstate:0,2
defaultgpuclock = -setBaseClockOffset:0,0,0 -setMemoryClockOffset:0,0,0

Loop{
	IfWinExist, Ethermine
	{
		SetWorkingDir %NvidiaInspectorLocation%
		Run nvidiaInspector.exe %highgpuclock%
		TrayTip, GpuOverclock, Overclocked, 4
		WinWaitClose, Ethermine
	}
	IfWinNotExist, Ethermine
	{
		SetWorkingDir %NvidiaInspectorLocation%
		Run nvidiaInspector.exe %defaultgpuclock%
		Traytip, GpuOverclock, Default, 4
		WinWaitActive, Ethermine
		if A_TimeIdlePhysical > %TimeAfk%
		{
			SetWorkingDir %MineScriptLocation%
			Run start.bat
		}
	}
}

%MineShortcut%::
	IfWinActive, Ethermine
	{
		WinClose, Ethermine
		Sleep, 1000
	}
	else
	{
		SetWorkingDir %MineScriptLocation%
		Run start.bat
	}