private ["_activeTimer", "_inactiveTimer"];

// Variables
_activeTimer = 300;										// How long will it remain active for, in seconds. 300 = 5 minutes
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

baseTurret1 hideObject false;
baseTurret2 hideObject false;
baseTurret3 hideObject false;
baseTurret4 hideObject false;
baseTurret5 hideObject false;
baseTurret6 hideObject false;
baseTurret7 hideObject false;
baseTurret8 hideObject false;
baseTurret9 hideObject false;

_grpTurret = createGroup west;
"B_support_MG_F" createUnit [getposATL baseTurret1, _grpTurret, "this moveInGunner baseTurret1"];
"B_support_MG_F" createUnit [getposATL baseTurret2, _grpTurret, "this moveInGunner baseTurret2"];
"B_support_MG_F" createUnit [getposATL baseTurret3, _grpTurret, "this moveInGunner baseTurret3"];
"B_support_MG_F" createUnit [getposATL baseTurret4, _grpTurret, "this moveInGunner baseTurret4"];
"B_support_MG_F" createUnit [getposATL baseTurret5, _grpTurret, "this moveInGunner baseTurret5"];
"B_support_MG_F" createUnit [getposATL baseTurret6, _grpTurret, "this moveInGunner baseTurret6"];
"B_support_MG_F" createUnit [getposATL baseTurret7, _grpTurret, "this moveInGunner baseTurret7"];
"B_support_MG_F" createUnit [getposATL baseTurret8, _grpTurret, "this moveInGunner baseTurret8"];
"B_support_MG_F" createUnit [getposATL baseTurret9, _grpTurret, "this moveInGunner baseTurret9"];
_grpTurret setBehaviour "COMBAT";

//---------- Active time
sleep _activeTimer;

//---------- Delete after use
{
    deleteVehicle _x;
} forEach (units _grpTurret);
deleteGroup _grpTurret;

baseTurret1 hideObject true;
baseTurret2 hideObject true;
baseTurret3 hideObject true;
baseTurret4 hideObject true;
baseTurret5 hideObject true;
baseTurret6 hideObject true;
baseTurret7 hideObject true;
baseTurret8 hideObject true;
baseTurret9 hideObject true;

//---------- Cool-off period before next use
sleep _inactiveTimer;
BASEDEFENSE_SWITCH = nil; publicVariable "BASEDEFENSE_SWITCH";
hqSideChat = "Защита базы доступна."; publicVariable "hqSideChat"; [WEST, "HQ"] sideChat hqSideChat;
