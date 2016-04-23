/*
Author: malashin (Based on Laser designation script for vehicles by ussrlongbow)
Description: Create 3D icon on Laser Targets for pilots in Air vehicles with Pilot helmets on.
*/

private ["_player", "_vehicle", "_pilotHelmets", "_laserTargets", "_distance", "_alpha", "_iconSize", "_relDirScreen", "_relDirLaser", "_dir"];

//Get player and vehicle
_player = _this select 0;
_vehicle = _this select 1;

//Allowed pilot helmets with HMDs
_pilotHelmets = ["H_PilotHelmetFighter_B", "H_CrewHelmetHeli_B", "H_PilotHelmetHeli_B"];

//Check if player is in pilot helmet, is in air vehicle and is not in cargo
if (((headgear _player) in _pilotHelmets) and ((typeOf _vehicle) isKindOf "Air") and (_vehicle getCargoIndex _player == -1)) then {

	//Create Draw3D EH
	laserDraw3D = addMissionEventHandler [ "Draw3D", {

		//Find all ally laser targets in the vicinity
		_laserTargets = nearestObjects[player, ["LaserTargetW"], 3000];

		//Cycle through all found laser targets
		{
			//Get distance from player to laser target to scale icon and change opacity on far distances
			_distance = player distance _x;
			_alpha = linearConversion [2500, 3000, _distance, 1, 0, true];
			_iconSize = linearConversion [0, 3000, _distance, 1, 0.1, true];

			//Get horizontal angle between laser target and center of players screen
			_relDirScreen = player getRelDir (screenToWorld [0.5, 0.5]);
			_relDirLaser = player getRelDir _x;
			_dir = (_relDirLaser - _relDirScreen) % 360;
			if (_dir < 0) then {_dir = _dir + 360};
			if (_dir > 180) then {_dir = 360 - _dir};

			//Check if the target is inside horizontal angle
			if (_dir < 13) then {

				//Draw 3D Icon
				drawIcon3D ["\A3\ui_f\data\gui\cfg\cursors\track_gs.paa", [0.35, 1.00, 0.70, _alpha], visiblePosition _x, _iconSize, _iconSize, 0, str(round _distance), 0, 0.035, "PuristaSemiBold", "center"];
			};
		} forEach _laserTargets;
	}];

	//Wait until player is not in the vehicle any more
	waitUntil {
		sleep 1;
		vehicle _player != _vehicle;
	};

	//Remove the Draw3D handler
	removeMissionEventHandler ["Draw3D", laserDraw3D];
};
