/*
@file: fn_AOminefield.sqf
Author:

	Quiksilver (credit Rarek [ahoyworld] for initial build)
	
Description:

	Spawn a minefield around radio tower sub-objective
	
________________________________________________________________*/

#define MINE_TYPES "APERSBoundingMine", "APERSMine", "ATMine"
_centralPos = _this select 0;
_unitsArray = [];

for "_x" from 0 to 59 do {
	_mine = createMine [[MINE_TYPES] call BIS_fnc_selectrandom, _centralPos, [], 38];
	_unitsArray = _unitsArray + [_mine];
};

_distance = 40;
_dir = 180;

for "_c" from 0 to 23 do {
	_pos = [_flatPos, _distance, _dir] call BIS_fnc_relPos;
	_sign = "Land_Razorwire_F" createVehicle _pos;
	waitUntil {alive _sign};
	_sign setDir _dir;
	_sign enableSimulation false;
	_sign allowDamage false;
	_dir = _dir + 15;

	_unitsArray = _unitsArray + [_sign];
};

_unitsArray