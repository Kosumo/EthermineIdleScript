!m::
	IfWinActive, Ethermine
	{
		WinClose, Ethermine
		Sleep, 1000
	}
	else
	{
		SetWorkingDir Y:\Ethmine\monitorig-v2\miners\claymore-eth
		Run "Y:\Ethmine\monitorig-v2\miners\claymore-eth\start.bat
	}