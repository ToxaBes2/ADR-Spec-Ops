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

// unhide turrets
baseTurret2 hideObject false;
baseTurret4 hideObject false;
baseTurret6 hideObject false;
baseTurret8 hideObject false;
baseTurret10 hideObject false;
baseTurret12 hideObject false;
baseTurret14 hideObject false;

// reload ammo
baseTurret1 setvehicleammo 1;
baseTurret2 setvehicleammo 1;
baseTurret3 setvehicleammo 1;
baseTurret4 setvehicleammo 1;
baseTurret5 setvehicleammo 1;
baseTurret6 setvehicleammo 1;
baseTurret7 setvehicleammo 1;
baseTurret8 setvehicleammo 1;
baseTurret9 setvehicleammo 1;
baseTurret10 setvehicleammo 1;
baseTurret11 setvehicleammo 1;
baseTurret12 setvehicleammo 1;
baseTurret13 setvehicleammo 1;
baseTurret14 setvehicleammo 1;
baseTurret15 setvehicleammo 1;

// put turrets on correct places
baseTurret1 setPos [6901.91,7427.83,13.069];
baseTurret2 setPos [6903.23,7420.66,13.068];
baseTurret3 setPos [6759.78,7360.07,10.12];
baseTurret4 setPos [6768.26,7352.23,10.12];
baseTurret5 setPos [6867.95,7231.05,22.53];
baseTurret6 setPos [6865.11,7225.58,22.512];
baseTurret7 setPos [7003.57,7196.28,4.34404];
baseTurret8 setPos [6925.94,7334.56,4.225];
baseTurret9 setPos [6888.33,7415.92,4.225];
baseTurret10 setPos [6904.97,7331.78,4.22479];
baseTurret11 setPos [6909.53,7420.09,4.225];
baseTurret12 setPos [6726.38,6940.75,4.46229];
baseTurret13 setPos [6724.38,6943.2,4.511];
baseTurret14 setPos [6620.34,7306.56,4.26537];
baseTurret15 setPos [6623.38,7307.07,4.39042];

// replace tuuret operators
_grpTurret1 = createGroup west;
deleteVehicle (gunner baseTurret1);
deleteVehicle (gunner baseTurret3);
deleteVehicle (gunner baseTurret5);
deleteVehicle (gunner baseTurret7);
deleteVehicle (gunner baseTurret9);
deleteVehicle (gunner baseTurret11);
deleteVehicle (gunner baseTurret13);
deleteVehicle (gunner baseTurret15);
"B_support_MG_F" createUnit [getposATL baseTurret1, _grpTurret1, "this moveInGunner baseTurret1"];
"B_support_MG_F" createUnit [getposATL baseTurret3, _grpTurret1, "this moveInGunner baseTurret3"];
"B_support_MG_F" createUnit [getposATL baseTurret5, _grpTurret1, "this moveInGunner baseTurret5"];
"B_support_MG_F" createUnit [getposATL baseTurret7, _grpTurret1, "this moveInGunner baseTurret7"];
"B_support_MG_F" createUnit [getposATL baseTurret9, _grpTurret1, "this moveInGunner baseTurret9"];
"B_support_MG_F" createUnit [getposATL baseTurret11, _grpTurret1, "this moveInGunner baseTurret11"];
"B_support_MG_F" createUnit [getposATL baseTurret13, _grpTurret1, "this moveInGunner baseTurret13"];
"B_support_MG_F" createUnit [getposATL baseTurret15, _grpTurret1, "this moveInGunner baseTurret15"];
_grpTurret1 setBehaviour "COMBAT";

// add turret operators
_grpTurret2 = createGroup west;
"B_support_MG_F" createUnit [getposATL baseTurret2, _grpTurret2, "this moveInGunner baseTurret2"];
"B_support_MG_F" createUnit [getposATL baseTurret4, _grpTurret2, "this moveInGunner baseTurret4"];
"B_support_MG_F" createUnit [getposATL baseTurret6, _grpTurret2, "this moveInGunner baseTurret6"];
"B_support_MG_F" createUnit [getposATL baseTurret8, _grpTurret2, "this moveInGunner baseTurret8"];
"B_support_MG_F" createUnit [getposATL baseTurret10, _grpTurret2, "this moveInGunner baseTurret10"];
"B_support_MG_F" createUnit [getposATL baseTurret12, _grpTurret2, "this moveInGunner baseTurret12"];
"B_support_MG_F" createUnit [getposATL baseTurret14, _grpTurret2, "this moveInGunner baseTurret14"];
_grpTurret2 setBehaviour "COMBAT";

//---------- Active time
sleep _activeTimer;

//---------- Delete after use
{
    deleteVehicle _x;
} forEach (units _grpTurret2);
deleteGroup _grpTurret2;

baseTurret2 hideObject true;
baseTurret4 hideObject true;
baseTurret6 hideObject true;
baseTurret8 hideObject true;
baseTurret10 hideObject true;
baseTurret12 hideObject true;
baseTurret14 hideObject true;

//---------- Cool-off period before next use
sleep _inactiveTimer;
BASEDEFENSE_SWITCH = nil; publicVariable "BASEDEFENSE_SWITCH";
hqSideChat = "Защита базы доступна."; publicVariable "hqSideChat"; [WEST, "HQ"] sideChat hqSideChat;
