private ["_activeTimer", "_inactiveTimer", "_defensePos", "_airdefenseGroup"];

// Variables
_activeTimer = 300;										// How long will it remain active for, in seconds. 300 = 5 minutes
_inactiveTimer = 300;									// Shortest time between activations, in seconds. 900 = 15 minutes
_defensePos = getMarkerPos "airbaseDefense";
_airdefenseGroup = createGroup WEST;

_null = [] spawn {
    _pos = getPosASL loudspeaker;
    _z = (_pos select 2) + 5;
    _pos set [2, _z];
	for "_i" from 0 to 6 do {
        playSound3D ["A3\data_f_curator\sound\cfgsounds\air_raid.wss", loudspeaker, false, _pos, 24, 1, 300];
        sleep 8.5;
	};
};

// Restrict use of this action while procedure is in progress
AIRBASEDEFENSE_SWITCH = true; publicVariable "AIRBASEDEFENSE_SWITCH";

hqSideChat = "Противовоздушная оборона активирована!"; publicVariable "hqSideChat"; [WEST, "HQ"] sideChat hqSideChat;
sleep 1;

//---------- Spawn vehicle
defender = createVehicle ["B_T_APC_Tracked_01_AA_F", _defensePos,[] ,0, "NONE"];
waitUntil {!isNull defender};
defender allowDamage false;
defender setDir 79;
defender lock 3;

//---------- Spawn crew
"B_crew_F" createUnit [_defensePos, _airdefenseGroup];
"B_crew_F" createUnit [_defensePos, _airdefenseGroup];
((units _airdefenseGroup) select 0) assignAsGunner defender;
((units _airdefenseGroup) select 0) moveInGunner defender;
((units _airdefenseGroup) select 1) assignAsCommander defender;
((units _airdefenseGroup) select 1) moveInCommander defender;
sleep 0.1;
defenderCrew1 = ((units _airdefenseGroup) select 0); defenderCrew1 allowDamage false;
defenderCrew2 = ((units _airdefenseGroup) select 1); defenderCrew2 allowDamage false;
sleep 0.1;

//---------- Configure
[(units _airdefenseGroup)] call QS_fnc_setSkill4;
_airdefenseGroup setBehaviour "COMBAT";
_airdefenseGroup setCombatMode "RED";
sleep 0.1;

//---------- Auto-cannon only, no rockets. Unlimited cannon ammo.
defender addEventHandler ["Fired", {defender setVehicleAmmo 1, defender removeMagazineTurret ["4Rnd_Titan_long_missiles", [0]], defender removeMagazines "4Rnd_Titan_long_missiles"}];

//---------- Active time
sleep _activeTimer;

//---------- Delete after use
defender removeEventHandler ["Fired", 0];
{ deleteVehicle _x } forEach [defenderCrew1,defenderCrew2,defender];

//---------- Cool-off period before next use
sleep _inactiveTimer;
AIRBASEDEFENSE_SWITCH = nil; publicVariable "AIRBASEDEFENSE_SWITCH";
hqSideChat = "Противовоздушная оборона доступна."; publicVariable "hqSideChat"; [WEST, "HQ"] sideChat hqSideChat;
