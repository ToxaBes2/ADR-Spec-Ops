private ["_activeTimer", "_inactiveTimer"];

// Variables
_activeTimer = 600;										// How long will it remain active for, in seconds. 300 = 5 minutes
_inactiveTimer = 600;									// Shortest time between activations, in seconds. 900 = 15 minutes

_null = [] spawn {
    _pos = getPosASL loudspeaker;
    _z = (_pos select 2) + 5;
    _pos set [2, _z];
	for "_i" from 0 to 6 do {
        playSound3D ["A3\Sounds_F\sfx\alarm_BLUFOR.wss", loudspeaker, false, _pos, 10, 1, 300];
        sleep 4;
	};
};

// Restrict use of this action while procedure is in progress
BASEDEFENSE_SWITCH = true; publicVariable "BASEDEFENSE_SWITCH";

hqSideChat = "Защита базы включена, турели активированы!"; publicVariable "hqSideChat"; [WEST, "HQ"] sideChat hqSideChat;
sleep 1;

// put turrets on correct places
baseTurret1 setPos [6926.12,7280.07,4.34];
baseTurret2 setPos [6848.06,7205.3,4.34];
baseTurret3 setPos [6760.31,7360.26,10.08];
baseTurret4 setPos [6768.26,7352.23,10.12];
baseTurret5 setPos [6880.16,7296.58,2.22];
baseTurret6 setPos [6959.57,7111.08,4.34];
baseTurret7 setPos [6994.47,7165.98,4.62];
baseTurret8 setPos [6733.68,7345.93,0];
baseTurret9 setPos [6924.81,7298,4.36];
baseTurret10 setPos [6924.15,7300.74,4.35];
baseTurret11 setPos [6846.32,7207.59,4.32];
baseTurret12 setPos [6988.93,7133.72,10.17];
baseTurret13 setPos [6689.41,6964.37,4.44];
baseTurret14 setPos [6712.04,7313.16,4.26];
baseTurret15 setPos [6710.25,7315.67,4.39];

_turrets = [baseTurret1, baseTurret2, baseTurret3, baseTurret4, baseTurret5, baseTurret6, baseTurret7, baseTurret8, baseTurret9, baseTurret10, 
baseTurret11, baseTurret12, baseTurret13, baseTurret14, baseTurret15];

_grpTurret = createGroup west;
{
    _x setvehicleammo 1;
    deleteVehicle (gunner _x);   
    "B_support_MG_F" createUnit [getposATL _x, _grpTurret, "currentGunner = this"];
    currentGunner moveInGunner _x;
} foreach _turrets;
_grpTurret setBehaviour "COMBAT";
_grpTurret setCombatMode "RED";
[(units _grpTurret)] call QS_fnc_setSkill4;

//---------- Active time
sleep _activeTimer;

//---------- Delete after use
{
    deleteVehicle _x;
} forEach (units _grpTurret);
deleteGroup _grpTurret;
sleep 2;
_grpTurret = createGroup west;
_number = 1;
{
    _x setvehicleammo 1;
    deleteVehicle (gunner _x);   
    if (_number % 2 == 0) then {
    	"B_support_MG_F" createUnit [getposATL _x, _grpTurret, "currentGunner = this"];
        currentGunner moveInGunner _x;
    };    
    _number = _number + 1;
} foreach _turrets;
_grpTurret setBehaviour "COMBAT";
_grpTurret setCombatMode "RED";
[(units _grpTurret)] call QS_fnc_setSkill4;

sleep 5;
_enemies = nearestObjects [(getMarkerPos "respawn_west"), ["SoldierGB", "SoldierEB"], 250];
if (count _enemies > 0) then {
    {
        _grpTurret reveal [_x, 1.5];
    } forEach _enemies;
};

//---------- Cool-off period before next use
sleep _inactiveTimer;
BASEDEFENSE_SWITCH = nil; publicVariable "BASEDEFENSE_SWITCH";
hqSideChat = "Защита базы доступна."; publicVariable "hqSideChat"; [WEST, "HQ"] sideChat hqSideChat;
