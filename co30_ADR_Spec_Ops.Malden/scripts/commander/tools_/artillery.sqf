_magazine = _this select 0;
_center = _this select 1;
_basePos = getMarkerPos "respawn_west";
if (_basePos distance2D _center < 800) exitWith {
    systemChat "Артудар по базе отменен командованием!";
};

systemChat "Вызываем артподдержку...";
_artPos = [_center, 1000, 2500, 4, 0, 10, 0] call QS_fnc_findSafePos;
_mbt = createVehicle ["B_MBT_01_arty_F", _artPos, [], 0, 'NONE'];
_mbt allowDamage false;
_mbt lock 3;
{
   _mbt removeMagazine _x;
} forEach (magazines _mbt);
_mbt addMagazines [_magazine, 10];
createVehicleCrew _mbt;
[_mbt, _center] spawn {
	_mbt = _this select 0;
	_center = _this select 1;
	_radius = 4;
	sleep 3;
    for "_i" from 0 to 9 do {
        _pos = [
        	(_center select 0) - _radius + (2 * random _radius),
        	(_center select 1) - _radius + (2 * random _radius),
        	0
        ];
        _mbt commandArtilleryFire [
    		_pos,
    		getArtilleryAmmo [_mbt] select 0,
    		1
    	];
        sleep 3;
    };
    sleep 2;
    deleteVehicle _mbt;
};