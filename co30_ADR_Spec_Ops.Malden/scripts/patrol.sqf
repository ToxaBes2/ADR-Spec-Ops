/*
Author:	ToxaBes
Description: patrol bots inside building
Format: [_unit, _house, _time]
*/
_unit = _this select 0;
_house = _this select 1;
_time = _this select 2;
_c = 0;
_goodPos = [];
while { format ["%1", _house buildingPos _c] != "[0,0,0]" } do {_c = _c + 1};
_c = _c - 1;
if (_c < 3) then {
	doStop _unit;
    [_unit,(selectRandom ["WATCH","WATCH1","WATCH2"]),"FULL", {!isNull (_unit findNearestEnemy (getPos _unit)) || lifestate _unit == "INJURED"}, "COMBAT"] call BIS_fnc_ambientAnimCombat;
} else {
    while {alive _unit} do {
    	_destination = _house buildingPos (floor (random _c));
    	_unit doMove _destination;
    	_unit moveTo _destination;
    	sleep 0.5;
    	_timeout = time + _time;
    	waitUntil {moveToCompleted _unit || moveToFailed _unit || !alive _unit || _timeout < time};
    	sleep (random (_time));
    };
};
