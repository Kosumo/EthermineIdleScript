;Alleen dit invullen
MineScript_Location = Y:\Ethmine\monitorig-v2\miners\claymore-eth
Tijd_afk = 300000
;##############

Loop{
	if A_TimeIdlePhysical > %Tijd_afk%
		IfWinNotExist, Ethermine
		{
			Sleep, 1000
			SetWorkingDir %MineScript_Location%
			Run %MineScript_Location%\start.bat
			WinWaitClose, Ethermine
		}
		else
		{
			Sleep, 1000
		}
}