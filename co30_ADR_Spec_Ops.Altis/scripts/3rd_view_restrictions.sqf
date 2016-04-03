if (hasInterface && difficultyEnabled "3rdPersonView") then {
	while {true} do {
		waitUntil {cameraView == "EXTERNAL"};
		if (vehicle player == player && isNull (getConnectedUav player)) then {
			player switchCamera "INTERNAL";
		};
	};
};