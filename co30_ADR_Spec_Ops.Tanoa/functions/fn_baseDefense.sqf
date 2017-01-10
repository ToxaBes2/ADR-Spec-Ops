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
baseTurret1 setPos [6901.915,7427.831,17.389];
baseTurret2 setPos [6903.232,7420.661,17.388];
baseTurret3 setPos [6759.780,7360.070,14.680];
baseTurret4 setPos [6768.262,7352.225,14.001];
baseTurret5 setPos [6867.946,7231.052,26.171];
baseTurret6 setPos [6865.113,7225.583,26.851];
baseTurret7 setPos [7003.567,7196.284,8.664];
baseTurret8 setPos [6925.936,7334.559,7.866];
baseTurret9 setPos [6888.327,7415.918,8.545];
baseTurret10 setPos [6904.970,7331.776,8.545];
baseTurret11 setPos [6909.526,7420.086,8.545];
baseTurret12 setPos [6726.377,6940.746,10.151];
baseTurret13 setPos [6724.382,6943.204,10.140];
baseTurret14 setPos [6620.341,7306.560,15.359];
baseTurret15 setPos [6623.384,7307.074,15.359];

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

//---------- Cool-off period before next use
sleep _inactiveTimer;
BASEDEFENSE_SWITCH = nil; publicVariable "BASEDEFENSE_SWITCH";
hqSideChat = "Защита базы доступна."; publicVariable "hqSideChat"; [WEST, "HQ"] sideChat hqSideChat;
