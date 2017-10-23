#MaxThreadsPerHotkey 2
IniRead, TimeAfk, config.ini, Time_Afk, Time_Afk
IniRead, MineScript, config.ini, Paths, Mine_Script_Name
IniRead, MineScriptDir, config.ini, Paths, Mine_Script_Directory
IniRead, NvidiaInspectorLocation, config.ini, Paths, Nvidia_Inspector_Location
IniRead, GpuClock, config.ini, Overclock, GpuClockOffset
IniRead, MemClock, config.ini, Overclock, MemClockOffset
IniRead, PowerTarget, config.ini, Overclock, Powertarget
IniRead, MineShortcut, config.ini, Shortcuts, Shortcut
IniRead, CMDTitle, config.ini, WindowTitle, CmdWindowTitle

TimeAfkMin := (TimeAfk*60000) ;Determines time in minutes
highgpuclock = -setBaseClockOffset:0,0,%GpuClock% -setMemoryClockOffset:0,0,%MemClock% -setpowertarget:0,%PowerTarget% -forcepstate:0,2
defaultgpuclock = -setBaseClockOffset:0,0,0 -setMemoryClockOffset:0,0,0

!n::
{
	toggle:=!toggle
	If !Toggle
	{
		TrayTip, Toggled, Mine Script On
	}
	Else
	{
		TrayTip, Toggled, Mine Script Off
	}
	
	while, toggle
	{
		IfWinExist, %CMDTitle%
		{
			Run %NvidiaInspectorLocation% %highgpuclock%
			TrayTip, GpuOverclock, Overclocked
			WinWaitClose, %CMDTitle%
			Run %NvidiaInspectorLocation% %defaultgpuclock%
			Traytip, GpuOverclock, Default
		}
		IfWinNotExist, %CMDTitle%
		{
				if A_TimeIdlePhysical > %TimeAfkMin%
				{
					SetWorkingDir, %MineScriptDir%
					Run %MineScript%
					Sleep, 1000
				}
				else
				{
				Sleep, 1000
				}
		}
	}
}
return

!m::
	IfWinActive, %CMDTitle%
	{
		WinClose, %CMDTitle%
		Sleep, 1000
	}
	else
	{
		SetWorkingDir %MineScriptDir%
		Run %MineScript%
	}