TimeAfk = 
;####
MineScript_Location = Y:\Ethmine\monitorig-v2\miners\claymore-eth
nvinspectorlocation = Y:\Ethmine\Nvinspector
;;;
GpuClock = 100
MemClock = 280
PowerTarget = 130
;;;;
highgpuclock = -setBaseClockOffset:0,0,%GpuClock% -setMemoryClockOffset:0,0,%MemClock% -setpowertarget:0,%PowerTarget% -forcepstate:0,2
defaultgpuclock = -setBaseClockOffset:0,0,0 -setMemoryClockOffset:0,0,0

Loop{
	IfWinExist, Ethermine
	{
		SetWorkingDir %nvinspectorlocation%
		Run nvidiaInspector.exe %highgpuclock%
		TrayTip, GpuOverclock, Overclocked, 4
		WinWaitClose, Ethermine
	}
	IfWinNotExist, Ethermine
	{
		SetWorkingDir %nvinspectorlocation%
		Run nvidiaInspector.exe %defaultgpuclock%
		Traytip, GpuOverclock, Default, 4
		WinWaitActive, Ethermine
		if A_TimeIdlePhysical > %TimeAfk%
		{
			SetWorkingDir %MineScript_Location%
			Run start.bat
		}
	}
}