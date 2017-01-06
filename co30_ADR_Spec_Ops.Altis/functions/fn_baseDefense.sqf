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
baseTurret1 setPos [15283.8,17367.1,2.778];
baseTurret2 setPos [15286.4,17369.3,2.78095];
baseTurret3 setPos [15322,17399.6,2.22285];
baseTurret4 setPos [15189.2,17523.5,4.349];
baseTurret5 setPos [15186.6,17526.1,4.338];
baseTurret6 setPos [15167.1,17370.6,4.127];
baseTurret7 setPos [15187.7,17361.9,3.132];
baseTurret8 setPos [15052.7,17329.3,10.1012];
baseTurret9 setPos [14923.6,17196.6,10.123];
baseTurret10 setPos [14968.4,16964.1,12.3166];
baseTurret11 setPos [14968,16966.1,12.3267];
baseTurret12 setPos [15455.5,15754.1,15.613];
baseTurret13 setPos [15372,15852,4.4];
baseTurret14 setPos [17776.3,18214.9,5.921];
baseTurret15 setPos [17726,18089.7,3.9];
baseTurret16 setPos [15277.7,17232,4.4];
baseTurret17 setPos [15275.7,17229.9,4.4];
baseTurret18 setPos [15349.2,15755.8,15.6768];
baseTurret19 setPos [17869.9,18201.7,0];
baseTurret20 setPos [15061.2,17208.9,4.4];

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

//---------- Cool-off period before next use
sleep _inactiveTimer;
BASEDEFENSE_SWITCH = nil; publicVariable "BASEDEFENSE_SWITCH";
hqSideChat = "Защита базы доступна."; publicVariable "hqSideChat"; [WEST, "HQ"] sideChat hqSideChat;
