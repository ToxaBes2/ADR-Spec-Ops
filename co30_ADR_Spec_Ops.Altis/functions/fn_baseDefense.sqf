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
baseTurret1 setPos [15191.9,17153,4.17359];
baseTurret2 setPos [15303.7,17262.9,4.34404];
baseTurret3 setPos [15089.2,17192.5,2.27638];
baseTurret4 setPos [15179.3,17392.4,4.32132];
baseTurret5 setPos [15177.3,17395,4.37127];
baseTurret6 setPos [15167.1,17370.6,4.127];
baseTurret7 setPos [15187.7,17361.9,3.132];
baseTurret8 setPos [15052.7,17329.4,10.1028];
baseTurret9 setPos [15024,17305.6,4.38281];
baseTurret10 setPos [15273.6,17235.8,3.11093];
baseTurret11 setPos [15121.4,17220.4,0];
baseTurret12 setPos [15455.5,15754.1,15.613];
baseTurret13 setPos [15372,15852,4.4];
baseTurret14 setPos [17776.3,18214.9,5.921];
baseTurret15 setPos [17726,18089.7,3.9];
baseTurret16 setPos [15256.8,17311,4.298];
baseTurret17 setPos [15258.2,17308.7,4.34294];
baseTurret18 setPos [15349.2,15755.8,15.6768];
baseTurret19 setPos [17869.9,18201.7,0];
baseTurret20 setPos [15026.9,17238.6,4.34404];

_turrets = [baseTurret1, baseTurret2, baseTurret3, baseTurret4, baseTurret5, baseTurret6, baseTurret7, baseTurret8, baseTurret9, baseTurret10, 
baseTurret11, baseTurret12, baseTurret13, baseTurret14, baseTurret15, baseTurret16, baseTurret17, baseTurret18, baseTurret19, baseTurret20];

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
