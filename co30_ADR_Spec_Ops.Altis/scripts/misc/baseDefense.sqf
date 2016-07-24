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

// unhide turrets
baseTurret1 hideObject false;
baseTurret2 hideObject false;
baseTurret3 hideObject false;
baseTurret4 hideObject false;
baseTurret5 hideObject false;
baseTurret6 hideObject false;
baseTurret7 hideObject false;
baseTurret8 hideObject false;
baseTurret9 hideObject false;
baseTurret10 hideObject false;
baseTurret11 hideObject false;

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

// put turrets on correct places
baseTurret1 setPos [15283.8,17367.1,2.778];
baseTurret2 setPos [15286.4,17369.3,2.78095];
baseTurret3 setPos [15323,17399.3,2.07287];
baseTurret4 setPos [15189.2,17523.5,4.349];
baseTurret5 setPos [15186.6,17526.1,4.338];
baseTurret6 setPos [15167.1,17370.6,4.127];
baseTurret7 setPos [15187.7,17361.9,3.132];
baseTurret8 setPos [15052.7,17329.3,10.1012];
baseTurret9 setPos [14923.6,17196.6,10.123];
baseTurret10 setPos [14974.7,16963.2,16.386];
baseTurret11 setPos [14968.1,16964.5,12.325];

// add turret operators
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
"B_support_MG_F" createUnit [getposATL baseTurret10, _grpTurret, "this moveInGunner baseTurret10"];
"B_support_MG_F" createUnit [getposATL baseTurret11, _grpTurret, "this moveInGunner baseTurret11"];
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
baseTurret10 hideObject true;
baseTurret11 hideObject true;

//---------- Cool-off period before next use
sleep _inactiveTimer;
BASEDEFENSE_SWITCH = nil; publicVariable "BASEDEFENSE_SWITCH";
hqSideChat = "Защита базы доступна."; publicVariable "hqSideChat"; [WEST, "HQ"] sideChat hqSideChat;
