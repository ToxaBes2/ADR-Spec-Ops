/*
Author: malashin (Based on Laser designation script for vehicles by ussrlongbow)
Description: Create 3D icon on Laser Targets for pilots in Air vehicles with Pilot helmets on.
*/

private ["_player", "_vehicle", "_headgear", "_pilotHelmets", "_crew","_laserTargets", "_distance", "_alpha", "_iconSize"];

//Get player and vehicle
_player = _this select 1;
_vehicle = _this select 0;

//Allowed pilot helmets with HMDs
_pilotHelmets = ["H_PilotHelmetFighter_B", "H_CrewHelmetHeli_B", "H_PilotHelmetHeli_B"];

//Create Draw3D EH
if (((headgear _player) in _pilotHelmets) and ((typeOf _vehicle) isKindOf "Air") and (_vehicle getCargoIndex _player == -1)) then {
	laserDraw3D = addMissionEventHandler [ "Draw3D", {
		_laserTargets = nearestObjects[player, ["LaserTargetW"], 3000];
		{
			_distance = player distance _x;
			_alpha = linearConversion [2500, 3000, _distance, 1, 0, true];
			_iconSize = linearConversion [0, 3000, _distance, 1, 0.1, true];
			if ((vehicle player) getCargoIndex player == -1) then {
				drawIcon3D ["\A3\ui_f\data\gui\cfg\cursors\track_gs.paa", [0.40, 1, 0.75, _alpha], visiblePosition _x, _iconSize, _iconSize, 0, str(round _distance), 0, 0.035, "PuristaSemiBold", "center", true];
			};
		} forEach _laserTargets;
	}];
	_vehicle addEventHandler [ "GetOut", {
		removeMissionEventHandler ["Draw3D", laserDraw3D];
	}];
};
