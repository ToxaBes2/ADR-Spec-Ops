/*
Author: ToxaBes
Description: create partizane base.
Format: [] call QS_fnc_createPartizanBase;
*/

private ["_basePositions", "_dist", "_position", "_accepted", "_curPos", "_respawnPos", "_sd", "_sp"];

_basePositions = [
    [7465.5,8517.42,0.22], [6301.57,8845.25,0.2], [6031.8,9591,0.57], [8243.91,11103.7,0.38], [8274.81,11940,0.24], [7800.77,11301.6,0.21],
    [7938.99,12421,0.21], [6683.04,12347.7,0.34], [6119.49,12245.8,0.35], [8910.92,11895.4,0.2], [8638.76,9016.14,0.36], [8546.93,7652.44,0.2],
    [9430.14,7577.33,0.16], [9167.8,8704.07,0.2], [10028.4,9341.01,0.21], [10306.6,10561.7,0.15], [11410.8,12305.3,0.38], [11947,12739.2,0.28],
    [10998.5,13119.8,0.25], [10387.7,13254.5,0.13], [9488.06,13097.7,0.47], [12881.2,11618.5,0.28], [14116.8,10680,0.4], [13968.7,9992.71,0.013],
    [14670.6,9681.99,0.22], [14391.9,9585.78,0.39], [14124.5,8574.15,0.19], [13553.9,8391.28,0.11], [11724.1,6936.34,0.13], [10912,7849.35,0.13]
];
_dist = 1500;
_position = [0, 0, 0];
_accepted = false;
_curPos = getPos partizan_ammo;
while {!_accepted} do {
	_position = _basePositions call BIS_fnc_selectRandom;;
	if (_position distance2D (getMarkerPos "aoMarker") > _dist) then {
		if (_position distance2D (getMarkerPos "sideMarker") > _dist) then {
			if (_position distance2D (getMarkerPos "priorityMarker") > _dist) then {
				if (_position distance2D (_curPos) > _dist) then {
				    _accepted = true;
				};
			};
		};
	};
};
_respawnPos = [((_position select 0) + random 3),((_position select 1) + random 3),_position select 2];
partizan_ammo setPos _position;
"respawn_guerrila" setMarkerPos _respawnPos;
"partizan_base" setMarkerPos _position;
["partizan_base", 0] remoteExec ["setMarkerAlphaLocal", west];
