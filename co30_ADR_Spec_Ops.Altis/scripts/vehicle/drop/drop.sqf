/*
Author:

	Jester [AW]

Edited by:

	Quiksilver 

Note:

	This script does not broadcast public variables.

______________________________________________________________*/

private ["_heli", "_reloadtime"];

//------------------------------------------------------- CONFIG
_heli = _this select 0;
_chuteType = "O_Parachute_02_F";			//parachute for blufor, for opfor and greenfor replace the 'B' with 'O' or 'G' respectively
_crateType =  "O_supplyCrate_F";			//ammocrate class for blufor, feel free to change to whichever box you desire
_smokeType =  "SmokeShellPurple";			//smoke shell color you want to use
_lightType =  "Chemlight_blue";				//chemlightcolor you want used
_reloadtime = 600;							// time before next ammo drop is available to use, default 600 or 480
_minheight = 50;							// the height you have to be before you can actually drop the crate

// display this when too low to drop
_tooLow = format ["<t align='center'><t size='2.2' color='#ed3b00'>Слижком низко</t><br/><t size='1.2' color='#9ef680'>Вы должны быть выше</t><br/><t size='1.5' color='#ed3b00'>%1 метров</t><br/><t size='1.2' color='#9ef680'>для сброса боеприпасов.</t></t>",_minheight];

//--------------------------------------------------------- MEAT AND POTATOES
if ( !(isNil "AW_ammoDrop") ) exitWith {
	hint "Нет возможности для сброса."
};

if ((getPos player) select 2 < _minheight) exitWith {
	hint parseText _tooLow
};

if ((getPos player) select 2 > _minheight) then {
	AW_ammoDrop = false;
	publicVariable "AW_ammoDrop";

	_chute = createVehicle [_chuteType, [100, 100, 200], [], 0, 'FLY'];
	_chute setPos [getPosASL _heli select 0, getPosASL _heli select 1, (getPosASL _heli select 2) - 50];
	_crate = createVehicle [_crateType, position _chute, [], 0, 'NONE'];
	_crate attachTo [_chute, [0, 0, -1.3]];
	_crate allowdamage false;
	_light = createVehicle [_lightType, position _chute, [], 0, 'NONE'];
	_light attachTo [_chute, [0, 0, 0]];

	//---------------------------------------------------- CLEAR CRATE
	clearWeaponCargoGlobal _crate;
	clearMagazineCargoGlobal _crate;

	//---------------------------------------------------- CRATE CONTENTS
	_crate addMagazineCargoGlobal ["5Rnd_127x108_Mag", 10];
	_crate addMagazineCargoGlobal ["7Rnd_408_Mag", 15];
	_crate addMagazineCargoGlobal ["30Rnd_556x45_Stanag", 40];
	_crate addMagazineCargoGlobal ["30Rnd_65x39_caseless_mag_Tracer", 40];
	_crate addMagazineCargoGlobal ["20Rnd_762x51_Mag", 30];
	_crate addMagazineCargoGlobal ["200Rnd_65x39_cased_Box_Tracer", 10];
	_crate addMagazineCargoGlobal ["30Rnd_65x39_caseless_green", 40];
	_crate addMagazineCargoGlobal ["150Rnd_762x51_Box", 10];
	_crate addMagazineCargoGlobal ["30Rnd_65x39_caseless_mag", 40];
	_crate addMagazineCargoGlobal ["SatchelCharge_Remote_Mag", 2];
	_crate addMagazineCargoGlobal ["HandGrenade", 6];
	_crate addMagazineCargoGlobal ["SmokeShell", 6];
	_crate addMagazineCargoGlobal ["SmokeShellGreen", 6];
	_crate addMagazineCargoGlobal ["1Rnd_HE_Grenade_shell", 6];
	_crate addMagazineCargoGlobal ["RPG32_HE_F", 2];
	_crate addMagazineCargoGlobal ["RPG32_F", 2];
	_crate addMagazineCargoGlobal ["NLAW_F", 3];
	_crate addMagazineCargoGlobal ["Titan_AT", 2];
	_crate addMagazineCargoGlobal ["Titan_AA", 2];

	//--------------------------------------------------- BRIEF
	hint "UH-80: Боезапас сброшен!";
	
	//--------------------------------------------------- CRATE LANDING
	waitUntil {
		position _crate select 2 < 1 || isNull _chute
	};
	
	detach _crate;
	_crate setPos [position _crate select 0, position _crate select 1, 0];
	_smoke = _smokeType createVehicle [getPos _crate select 0, getPos _crate select 1, 5];

	//--------------------------------------------------- BRIEF
	hint "UH-80: Боезапас коснулся земли!";

	//--------------------------------------------------- COOLDOWN TIMER
	sleep _reloadtime;
	
	//--------------------------------------------------- DELETE OLD CRATE
	deleteVehicle _crate;

	//--------------------------------------------------- NEW CRATE READY
	hint "UH-80: Возможность сброса боезапасов вновь доступна.";
	
	AW_ammoDrop = nil;
	publicVariable "AW_ammoDrop";
};