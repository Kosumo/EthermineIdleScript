;Alleen dit invullen
nvinspectorlocation = Y:\Ethmine\Nvinspector
GpuClock = 100
MemClock = 280
PowerTarget = 130
;###################

;Hier niet aankomen
overclock = -setBaseClockOffset:0,0,%GpuClock% -setMemoryClockOffset:0,0,%MemClock% -setpowertarget:0,%PowerTarget% -forcepstate:0,2
downclock = -setBaseClockOffset:0,0,0 -setMemoryClockOffset:0,0,0

Loop{
	IfWinActive, Ethermine
	{
		SetWorkingDir %nvinspectorlocation%
		Run nvidiaInspector.exe %overclock%
		TrayTip, GpuOverclock, Overclocked, 4
		WinWaitClose, Ethermine
	}
	IfWinNotActive, Ethermine
	{
		SetWorkingDir %nvinspectorlocation%
		Run nvidiaInspector.exe %downclock%
		TrayTip, GpuOverclock, Default, 4
		WinWaitActive, Ethermine
	}
}