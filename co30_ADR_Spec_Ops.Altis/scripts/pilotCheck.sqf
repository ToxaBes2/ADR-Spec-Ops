private ["_whitelist", "_veh"];

/*
_uid = getPlayerUID player;
_whitelist = [
	"76561198114622790"	// ToxaBes
];
if (_uid in _whitelist) exitWith {};
*/

waitUntil {sleep 0.1; player == player;};

player addEventHandler [ "GetInMan", {
	_veh = vehicle player;
	if (_veh isKindOf "Air" && !(_veh isKindOf "ParachuteBase")) then {
		_veh call QS_fnc_pilotCheck;
	};
}];

player addEventHandler [ "SeatSwitchedMan", {
	_veh = vehicle player;
	if (_veh isKindOf "Air" && !(_veh isKindOf "ParachuteBase")) then {
		_veh call QS_fnc_pilotCheck;
	};
}];
