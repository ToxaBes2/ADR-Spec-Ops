/*
Author: ToxaBes
Description: add dog
*/
_center = _this select 0;
_blufor_base = getMarkerPos "respawn_west";
if (_center distance2D _blufor_base < 500) exitWith {
    ["<t color='#F44336' size = '.48'>Слишком близко к базе регулярной армии!</t>", 0, 0.8, 3, 0.5, 0] spawn BIS_fnc_dynamicText;
};
["<t color='#7FDA0B' size = '.48'>Вызов техничек...</t>", 0, 0.8, 3, 0.5, 0] spawn BIS_fnc_dynamicText;

_patrolGroup = createGroup resistance;
_spawnPos1 = [_center, 800, 1000, 2, 0, 10, 0, []] call QS_fnc_findSafePos;
_spawnPos2 = [_spawnPos1, 30, 100, 2, 0, 10, 0, []] call QS_fnc_findSafePos;

_veh1 = createVehicle ["I_G_Offroad_01_armed_F",_spawnPos1,[],0,"NONE"];
[
	_veh1,
	["Guerilla_01",1], 
	["HideDoor1",0,"HideDoor2",0,"HideDoor3",1,"HideBackpacks",0,"HideBumper1",1,"HideBumper2",0,"HideConstruction",0]
] call BIS_fnc_initVehicle;
"I_G_Soldier_F" createUnit [_spawnPos1, _patrolGroup, "unit1 = this;"];
unit1 assignAsDriver _veh1;
unit1 moveInDriver _veh1;
"I_G_Soldier_F" createUnit [_spawnPos1, _patrolGroup, "unit2 = this;"];
unit2 assignAsGunner _veh1;
unit2 moveInGunner _veh1;

_veh2 = createVehicle ["I_G_Offroad_01_armed_F",_spawnPos2,[],0,"NONE"];
[
	_veh2,
	["Guerilla_08",1], 
	["HideDoor1",0,"HideDoor2",0,"HideDoor3",1,"HideBackpacks",0,"HideBumper1",0,"HideBumper2",1,"HideConstruction",0]
] call BIS_fnc_initVehicle;
"I_G_Soldier_F" createUnit [_spawnPos2, _patrolGroup, "unit3 = this;"];
unit3 assignAsDriver _veh2;
unit3 moveInDriver _veh2;
"I_G_Soldier_F" createUnit [_spawnPos2, _patrolGroup, "unit4 = this;"];
unit4 assignAsGunner _veh2;
unit4 moveInGunner _veh2;

_nearestTargets = nearestObjects [_center, ["Man","LandVehicle"], 200];
{
    _patrolGroup reveal [_x, 4];
} forEach _nearestTargets;

[_patrolGroup, _center] call BIS_fnc_taskAttack;
_patrolGroup setBehaviour "COMBAT";
_patrolGroup setCombatMode "RED";
[(units _patrolGroup)] call QS_fnc_setSkill4;
[_patrolGroup, true] call QS_fnc_moveToHC;
[_patrolGroup, _veh1, _veh2] spawn {
	_patrolGroup = _this select 0;
	_veh1 = _this select 1;
	_veh2 = _this select 2;
	sleep 1800; // 30 mins
	{
         deleteVehicle _x;
    } forEach units _patrolGroup;
    deleteGroup _patrolGroup;
    {
        _veh = _x;
        if (alive _veh) then {
        	_del = true;
        	{
                if (isPlayer _x) then {
                	_del = false;
                };
            } forEach crew _veh;
            if (_del) then {
            	deleteVehicle _veh;
            };
        };
    } forEach [_veh1, _veh2];
};

