if (!isDedicated) then {
	waitUntil {!isNull (findDisplay 46)};
	if (difficultyEnabled "3rdPersonView") then	{
		while {true} do {
			waitUntil {cameraView == "EXTERNAL"};
			if (vehicle player == player && isNull (getConnectedUav player)) then {
				player switchCamera "INTERNAL";
			};
		};
	};
};