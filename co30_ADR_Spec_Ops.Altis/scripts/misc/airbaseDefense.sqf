/*
@filename: airbaseDefense.sqf
Author: 

	Quiksilver

Last modified: 

	25/04/2014

Description:

	Spawns a friendly AA vehicle to protect the airbase from OPFOR air assets, for a short time.
	Activated via a laptop addAction.

	Benefits of doing it this way = dont need an AI vehicle sitting there at all times eating server resources, 
	and hands over interactive control to players from server.

__________________________________________________________________________*/

private ["_loopTimeout", "_activeTimer", "_inactiveTimer", "_airdefenseGroup", "_defensePos"];

_loopTimeout = 10 + (random 10);

AIRBASEDEFENSE_SWITCH = false; publicVariable "AIRBASEDEFENSE_SWITCH";

while { true } do {

	if (AIRBASEDEFENSE_SWITCH) then {
	
		hqSideChat = "Противовоздушная оборона активирована!"; publicVariable "hqSideChat"; [WEST, "HQ"] sideChat hqSideChat;

		//---------- Useful stuff
		_activeTimer = 300;										// How long will it remain active for, in seconds. 300 = 5 minutes
		_inactiveTimer = 300;									// Shortest time between activations, in seconds. 900 = 15 minutes
		_defensePos = getMarkerPos "airbaseDefense";
		_airdefenseGroup = createGroup WEST;

		//---------- Spawn vehicle
		defender = createVehicle ["B_APC_Tracked_01_AA_F", _defensePos,[] ,0, "NONE"];
		waitUntil {!isNull defender};
		defender allowDamage false;
		defender setDir 135; 
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
		AIRBASEDEFENSE_SWITCH = false; publicVariable "AIRBASEDEFENSE_SWITCH";
		hqSideChat = "Противовоздушная оборона доступна."; publicVariable "hqSideChat"; [WEST, "HQ"] sideChat hqSideChat;

	};

	sleep _loopTimeout;

};