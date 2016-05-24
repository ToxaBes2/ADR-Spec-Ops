/*
Author:	malashin
Description: Choose different loadouts for allowed vehicles and rearm them
*/

private ["_loadout_type", "_veh", "_vehType", "_allowedVehicles", "_fuel", "_dmgList", "_dmgSum", "_magazines", "_weapons"];
_loadout_type = _this select 3;
_veh = vehicle player;
_vehType = typeOf _veh;
_allowedVehicles = ["I_Heli_light_03_F", "I_Plane_Fighter_03_AA_F", "I_Plane_Fighter_03_CAS_F"];

if (_vehType in _allowedVehicles) then {

	//Start the procedure
	ADR_aircraftChangeLoadout = true; //Restrict use of this action while procedure is in progress
	_veh vehicleChat "Обслуживание. Пожалуйста ждите ...";
	_fuel = fuel _veh;
	_veh setFuel 0;
	uiSleep 2;

	//Repair
	_dmgList = getAllHitPointsDamage _veh;
	_dmgSum = 0;
	{_dmgSum = _dmgSum + _x;} forEach (_dmgList select 2);
	if (_dmgSum > 0) then {
		_veh vehicleChat "Ремонт ...";
		uiSleep (5 + _dmgSum * 4);
	};
	_veh setDamage 0;

	//Remove current magazines and weapons
	_veh vehicleChat "Снимамаем навесное вооружение ...";
	_magazines = _veh magazinesTurret [-1];
	_weapons = _veh weaponsTurret [-1];

	{
		uiSleep 1;
		_veh removeMagazineTurret [_x, [-1]];
	} forEach _magazines;

	{
		uiSleep 3;
		_veh removeWeaponTurret [_x, [-1]];
	} forEach _weapons;

	//Add new magazines and weapons
	_veh vehicleChat "Устанавливаем новое вооружение ...";
	call {
		//Hellcat
		//M134 Minigun 7.62 mm[5000]; DAR[24]
		if (_loadout_type == 0) exitWith {
			{
				uiSleep 1;
			    _veh addMagazineTurret [_x, [-1]];
			} forEach ["5000Rnd_762x51_Yellow_Belt", "24Rnd_missiles", "168Rnd_CMFlare_Chaff_Magazine"];

			{
				uiSleep 3;
			    _veh addWeaponTurret [_x, [-1]];
			} forEach ["M134_minigun", "missiles_DAR", "CMFlareLauncher"];
		};

		//Gatling 6.5 mm[2000]; GMG 40 mm[96]
		if (_loadout_type == 1) exitWith {
			{
				uiSleep 1;
			    _veh addMagazineTurret [_x, [-1]];
			} forEach ["2000Rnd_65x39_Belt_Tracer_Green_Splash", "96Rnd_40mm_G_belt", "168Rnd_CMFlare_Chaff_Magazine"];

			{
				uiSleep 3;
			    _veh addWeaponTurret [_x, [-1]];
			} forEach ["LMG_Minigun_heli", "GMG_40mm", "CMFlareLauncher"];
		};

		//Gatling Cannon 20 mm[1000];
		if (_loadout_type == 2) exitWith {
			{
				uiSleep 1;
			    _veh addMagazineTurret [_x, [-1]];
			} forEach ["1000Rnd_20mm_shells", "168Rnd_CMFlare_Chaff_Magazine"];

			{
				uiSleep 3;
			    _veh addWeaponTurret [_x, [-1]];
			} forEach ["gatling_20mm", "CMFlareLauncher"];
		};

		//Buzzard
		//Twin Cannon 20mm[300]; Zephyr[4]; ASRAAM[2]
		if (_loadout_type == 3) exitWith {
			{
				uiSleep 1;
			    _veh addMagazineTurret [_x, [-1]];
			} forEach ["300Rnd_20mm_shells", "4Rnd_GAA_missiles", "2Rnd_AAA_missiles", "120Rnd_CMFlare_Chaff_Magazine"];

			{
				uiSleep 3;
			    _veh addWeaponTurret [_x, [-1]];
			} forEach ["Twin_Cannon_20mm", "missiles_Zephyr", "missiles_ASRAAM", "CMFlareLauncher"];
		};

		//Twin Cannon 20mm[300]; Skalpel ATGM[2]; ASRAAM[2]; GBU-12[2]
		if (_loadout_type == 4) exitWith {
			{
				uiSleep 1;
			    _veh addMagazineTurret [_x, [-1]];
			} forEach ["300Rnd_20mm_shells", "2Rnd_LG_scalpel", "2Rnd_AAA_missiles", "2Rnd_GBU12_LGB_MI10", "120Rnd_CMFlare_Chaff_Magazine"];

			{
				uiSleep 3;
			    _veh addWeaponTurret [_x, [-1]];
			} forEach ["Twin_Cannon_20mm", "missiles_SCALPEL", "missiles_ASRAAM", "GBU12BombLauncher", "CMFlareLauncher"];
		};

		//Twin Cannon 20mm[300]; ASRAAM[2]; GBU-12[4]
		if (_loadout_type == 5) exitWith {
			{
				uiSleep 1;
			    _veh addMagazineTurret [_x, [-1]];
			} forEach ["300Rnd_20mm_shells", "2Rnd_AAA_missiles", "4Rnd_Bomb_04_F", "120Rnd_CMFlare_Chaff_Magazine"];

			{
				uiSleep 3;
			    _veh addWeaponTurret [_x, [-1]];
			} forEach ["Twin_Cannon_20mm", "missiles_ASRAAM", "Bomb_04_Plane_CAS_01_F", "CMFlareLauncher"];
		};

		//Twin Cannon 20mm[300]; Skalpel ATGM[2]; GBU-12[4]
		if (_loadout_type == 6) exitWith {
			{
				uiSleep 1;
			    _veh addMagazineTurret [_x, [-1]];
			} forEach ["300Rnd_20mm_shells", "2Rnd_LG_scalpel", "4Rnd_Bomb_04_F", "120Rnd_CMFlare_Chaff_Magazine"];

			{
				uiSleep 3;
			    _veh addWeaponTurret [_x, [-1]];
			} forEach ["Twin_Cannon_20mm", "missiles_SCALPEL", "Bomb_04_Plane_CAS_01_F", "CMFlareLauncher"];
		};

		//Twin Cannon 20mm[300]; Tratnyr AP[20]; ASRAAM[2]; GBU-12[2]
		if (_loadout_type == 7) exitWith {
			{
				uiSleep 1;
			    _veh addMagazineTurret [_x, [-1]];
			} forEach ["300Rnd_20mm_shells", "20Rnd_Rocket_03_AP_F", "2Rnd_AAA_missiles", "2Rnd_GBU12_LGB_MI10", "120Rnd_CMFlare_Chaff_Magazine"];

			{
				uiSleep 3;
			    _veh addWeaponTurret [_x, [-1]];
			} forEach ["Twin_Cannon_20mm", "Rocket_03_AP_Plane_CAS_02_F", "missiles_ASRAAM", "GBU12BombLauncher", "CMFlareLauncher"];
		};

		//Twin Cannon 20mm[300]; Tratnyr HE[60]; ASRAAM[2]
		if (_loadout_type == 8) exitWith {
			{
				uiSleep 1;
			    _veh addMagazineTurret [_x, [-1]];
			} forEach ["300Rnd_20mm_shells", "20Rnd_Rocket_03_HE_F", "20Rnd_Rocket_03_HE_F", "20Rnd_Rocket_03_HE_F", "2Rnd_AAA_missiles", "120Rnd_CMFlare_Chaff_Magazine"];

			{
				uiSleep 3;
			    _veh addWeaponTurret [_x, [-1]];
			} forEach ["Twin_Cannon_20mm", "Rocket_03_HE_Plane_CAS_02_F", "missiles_ASRAAM", "CMFlareLauncher"];
		};
	};

	//Refuel
	_veh vehicleChat "Заправка ...";
	uiSleep (1 + (1 - _fuel) * 30);
	_veh setFuel 1;

	//Finished
	_veh vehicleChat "Обслуживание завершено. Приятного полета!";
	ADR_aircraftChangeLoadout = nil; //Remove action use restriction after procedure is finished
} else {
	_veh vehicleChat "Сменна вооружения для данной технике не доступна";
};
