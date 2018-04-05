private ["_cargo_type", "_smoke_type", "_light_type", "_modules", "_cooldownTime", "_deletionTime", "_objects", "_cargo", "_velocity", "_light1", "_light2", "_light3", "_smoke1", "_chute", "_smoke2"];

// Check if module was spawned recently
if (!isNil "ADR_supplyCrateCooldown") exitWith {
	systemChat "Модуль в данный момент не доступен"
};
ADR_supplyCrateCooldown = true; publicVariable "ADR_supplyCrateCooldown";

// Constants
_cargo_type = _this select 3;
_smoke_type = "SmokeShellOrange";
_light_type = "Chemlight_yellow";
_modules = ["B_Slingload_01_Fuel_F", "B_Slingload_01_Medevac_F", "B_Slingload_01_Repair_F", "B_Slingload_01_Ammo_F", "Land_Pod_Heli_Transport_04_fuel_F", "Land_Pod_Heli_Transport_04_medevac_F", "Land_Pod_Heli_Transport_04_repair_F", "Land_Pod_Heli_Transport_04_ammo_F", "Land_Pod_Heli_Transport_04_bench_F", "Land_Pod_Heli_Transport_04_covered_F", "B_Slingload_01_Cargo_F", "B_supplyCrate_F"];
_cooldownTime = 60;   // No more supply crates can be spawned for this time
_deletionTime = 900;  // Delete supply cargo after this time have passed after landing

// Make spawning of new modules possible after _cooldownTime
[_cooldownTime] spawn {
    sleep (_this select 0);
    ADR_supplyCrateCooldown = nil; publicVariable "ADR_supplyCrateCooldown";
};

// Check nearby modules and remove them
_objects = (getMarkerPos "Ammo_Supply_drop") nearEntities [_modules, 30];
{deleteVehicle _x} forEach _objects;
sleep 0.1;

// Create specified cargo
call {
    if (_cargo_type == 1) exitWith {_cargo = "B_Slingload_01_Fuel_F" createVehicle (getMarkerPos "Ammo_Supply_drop")};
    if (_cargo_type == 2) exitWith {_cargo = "B_Slingload_01_Medevac_F" createVehicle (getMarkerPos "Ammo_Supply_drop")};
    if (_cargo_type == 3) exitWith {_cargo = "B_Slingload_01_Repair_F" createVehicle (getMarkerPos "Ammo_Supply_drop")};
    if (_cargo_type == 4) exitWith {
        _cargo = "B_Slingload_01_Ammo_F" createVehicle (getMarkerPos "Ammo_Supply_drop");
        while {true} do {
            _cargo setAmmoCargo 0.000000032562; // Set cargo ammo to 32 562 instead of 10^12
            if (getAmmoCargo _cargo != 0) exitWith {}; // Due to very low values setAmmoCargo rounds to 0 on the first try
        };
    };
    if (_cargo_type == 5) exitWith {_cargo = "Land_Pod_Heli_Transport_04_fuel_F" createVehicle (getMarkerPos "Ammo_Supply_drop")};
    if (_cargo_type == 6) exitWith {_cargo = "Land_Pod_Heli_Transport_04_medevac_F" createVehicle (getMarkerPos "Ammo_Supply_drop")};
    if (_cargo_type == 7) exitWith {_cargo = "Land_Pod_Heli_Transport_04_repair_F" createVehicle (getMarkerPos "Ammo_Supply_drop")};
    if (_cargo_type == 8) exitWith {
        _cargo = "Land_Pod_Heli_Transport_04_ammo_F" createVehicle (getMarkerPos "Ammo_Supply_drop");
        while {true} do {
            _cargo setAmmoCargo 0.000000032562; // Set cargo ammo to 32 562 instead of 10^12
            if (getAmmoCargo _cargo != 0) exitWith {}; // Due to very low values setAmmoCargo rounds to 0 on the first try
        };
    };
    if (_cargo_type == 9) exitWith {_cargo = "Land_Pod_Heli_Transport_04_bench_F" createVehicle (getMarkerPos "Ammo_Supply_drop")};
    if (_cargo_type == 10) exitWith {_cargo = "Land_Pod_Heli_Transport_04_covered_F" createVehicle (getMarkerPos "Ammo_Supply_drop")};
    if (_cargo_type == 11) exitWith {
        // Creating cargo
    	_cargo = "B_supplyCrate_F" createVehicle (getMarkerPos "Ammo_Supply_drop");
        sleep 0.1;

    	// Clearing cargo
    	clearWeaponCargoGlobal _cargo;
    	clearMagazineCargoGlobal _cargo;
    	clearItemCargoGlobal _cargo;
    	clearBackpackCargoGlobal _cargo;
    	sleep 0.1;

    	// Loading cargo
        _cargo addMagazineCargoGlobal ["30Rnd_556x45_Stanag", 5];
        _cargo addMagazineCargoGlobal ["30Rnd_556x45_Stanag_Tracer_Red", 15];
        _cargo addMagazineCargoGlobal ["20Rnd_556x45_UW_mag", 10];
        _cargo addMagazineCargoGlobal ["30Rnd_65x39_caseless_green", 5];
        _cargo addMagazineCargoGlobal ["30Rnd_65x39_caseless_green_mag_Tracer", 15];
        _cargo addMagazineCargoGlobal ["5Rnd_127x108_APDS_Mag", 15];
        _cargo addMagazineCargoGlobal ["7Rnd_408_Mag", 15];
        _cargo addMagazineCargoGlobal ["10Rnd_93x64_DMR_05_Mag", 20];
        _cargo addMagazineCargoGlobal ["10Rnd_127x54_Mag", 20];
        _cargo addMagazineCargoGlobal ["10Rnd_338_Mag", 20];
        _cargo addMagazineCargoGlobal ["20Rnd_762x51_Mag", 20];
        _cargo addMagazineCargoGlobal ["10Rnd_762x54_Mag", 20];
        _cargo addMagazineCargoGlobal ["30Rnd_65x39_caseless_mag", 5];
        _cargo addMagazineCargoGlobal ["30Rnd_65x39_caseless_mag_Tracer", 25];
        _cargo addMagazineCargoGlobal ["100Rnd_65x39_caseless_mag_Tracer", 15];
        _cargo addMagazineCargoGlobal ["150Rnd_762x54_Box_Tracer", 10];
        _cargo addMagazineCargoGlobal ["200Rnd_65x39_cased_Box_Tracer", 10];
        _cargo addMagazineCargoGlobal ["150Rnd_93x64_Mag", 10];
        _cargo addMagazineCargoGlobal ["130Rnd_338_Mag", 10];
        _cargo addMagazineCargoGlobal ["SatchelCharge_Remote_Mag", 2];
        _cargo addMagazineCargoGlobal ["DemoCharge_Remote_Mag", 4];
        _cargo addMagazineCargoGlobal ["HandGrenade", 6];
        _cargo addMagazineCargoGlobal ["SmokeShell", 16];
        _cargo addMagazineCargoGlobal ["SmokeShellGreen", 16];
        _cargo addMagazineCargoGlobal ["SmokeShellBlue", 16];
        _cargo addMagazineCargoGlobal ["1Rnd_HE_Grenade_shell", 16];
        _cargo addMagazineCargoGlobal ["RPG32_HE_F", 6];
        _cargo addMagazineCargoGlobal ["RPG32_F", 6];
        _cargo addMagazineCargoGlobal ["Titan_AT", 12];
        _cargo addMagazineCargoGlobal ["Titan_AA", 12];
        _cargo addMagazineCargoGlobal ["Laserbatteries", 5];
        _cargo addItemCargoGlobal ["FirstAidKit", 30];
        _cargo addItemCargoGlobal ["Medikit", 2];
        _cargo addItemCargoGlobal ["ToolKit", 2];
        _cargo addBackpackCargoGlobal ["B_AssaultPack_mcamo", 2];
        _cargo addBackpackCargoGlobal ["B_Kitbag_mcamo_Eng", 2];
        if (isClass(configfile >> "CfgPatches" >> "SMA_Weapons")) then { 
             _cargo addMagazineCargoGlobal ["SMA_30Rnd_762x35_BLK_EPR", 20];
             _cargo addMagazineCargoGlobal ["SMA_30Rnd_762x35_SS", 10];
             _cargo addMagazineCargoGlobal ["SMA_30Rnd_762x39_SKS_FMJ", 20];
             _cargo addMagazineCargoGlobal ["SMA_30Rnd_762x39_SKS_7n23_AP", 20];
             _cargo addMagazineCargoGlobal ["SMA_20Rnd_762x51mm_M80A1_EPR", 20];
             _cargo addMagazineCargoGlobal ["SMA_20Rnd_762x51mm_Mk316_Mod_0_Special_Long_Range", 20];
             _cargo addMagazineCargoGlobal ["SMA_20Rnd_762x51mm_Lapua_FMJ_Subsonic", 10];
             _cargo addMagazineCargoGlobal ["SMA_30Rnd_556x45_M855A1", 20];
             _cargo addMagazineCargoGlobal ["SMA_30Rnd_556x45_Mk318", 20];
             _cargo addMagazineCargoGlobal ["SMA_30Rnd_556x45_Mk262", 20];
             _cargo addMagazineCargoGlobal ["SMA_30Rnd_68x43_SPC_FMJ", 20];
             _cargo addMagazineCargoGlobal ["SMA_30Rnd_68x43_BT", 10];
             _cargo addMagazineCargoGlobal ["SMA_30Rnd_68x43_sub", 10];
             _cargo addMagazineCargoGlobal ["SMA_150Rnd_762_M80A1", 6];
        };
        _cargo addAction ["<t color='#7F0000'>Уничтожить ящик</t>","mission\main\actions\destroyCargo.sqf",[],-21,true,true,"","", 5]; 
    };
    if (_cargo_type == 12) exitWith {
        // Creating cargo
    	_cargo = "B_Slingload_01_Cargo_F" createVehicle (getMarkerPos "Ammo_Supply_drop");
        sleep 0.1;

    	// Clearing cargo
    	clearWeaponCargoGlobal _cargo;
    	clearMagazineCargoGlobal _cargo;
    	clearItemCargoGlobal _cargo;
    	clearBackpackCargoGlobal _cargo;
    	sleep 0.1;

    	// Loading cargo
    	_cargo addMagazineCargoGlobal ["30Rnd_556x45_Stanag", 14];
    	_cargo addMagazineCargoGlobal ["30Rnd_556x45_Stanag_Tracer_Red", 14];
    	_cargo addMagazineCargoGlobal ["20Rnd_556x45_UW_mag", 14];
    	_cargo addMagazineCargoGlobal ["30Rnd_65x39_caseless_mag", 14];
    	_cargo addMagazineCargoGlobal ["30Rnd_65x39_caseless_green", 14];
    	_cargo addMagazineCargoGlobal ["30Rnd_65x39_caseless_green_mag_Tracer", 14];
    	_cargo addMagazineCargoGlobal ["5Rnd_127x108_APDS_Mag", 20];
    	_cargo addMagazineCargoGlobal ["7Rnd_408_Mag", 20];
    	_cargo addMagazineCargoGlobal ["10Rnd_93x64_DMR_05_Mag", 14];
    	_cargo addMagazineCargoGlobal ["10Rnd_127x54_Mag", 14];
    	_cargo addMagazineCargoGlobal ["10Rnd_338_Mag", 14];
    	_cargo addMagazineCargoGlobal ["20Rnd_762x51_Mag", 14];
    	_cargo addMagazineCargoGlobal ["10Rnd_762x54_Mag", 14];
    	_cargo addMagazineCargoGlobal ["30Rnd_65x39_caseless_mag_Tracer", 21];
    	_cargo addMagazineCargoGlobal ["100Rnd_65x39_caseless_mag_Tracer", 15];
    	_cargo addMagazineCargoGlobal ["150Rnd_762x54_Box_Tracer", 15];
    	_cargo addMagazineCargoGlobal ["200Rnd_65x39_cased_Box_Tracer", 15];
    	_cargo addMagazineCargoGlobal ["150Rnd_93x64_Mag", 15];
    	_cargo addMagazineCargoGlobal ["130Rnd_338_Mag", 15];
    	_cargo addMagazineCargoGlobal ["SatchelCharge_Remote_Mag", 5];
    	_cargo addMagazineCargoGlobal ["DemoCharge_Remote_Mag", 5];
    	_cargo addMagazineCargoGlobal ["HandGrenade", 24];
    	_cargo addMagazineCargoGlobal ["SmokeShell", 24];
    	_cargo addMagazineCargoGlobal ["SmokeShellGreen", 24];
    	_cargo addMagazineCargoGlobal ["SmokeShellBlue", 24];
    	_cargo addMagazineCargoGlobal ["1Rnd_HE_Grenade_shell", 24];
    	_cargo addMagazineCargoGlobal ["3Rnd_HE_Grenade_shell", 8];
    	_cargo addMagazineCargoGlobal ["RPG32_HE_F", 10];
    	_cargo addMagazineCargoGlobal ["RPG32_F", 10];
    	_cargo addMagazineCargoGlobal ["NLAW_F", 10];
    	_cargo addMagazineCargoGlobal ["Titan_AT", 7];
    	_cargo addMagazineCargoGlobal ["Titan_AA", 7];
    	_cargo addMagazineCargoGlobal ["Laserbatteries", 10];
    	_cargo addItemCargoGlobal ["FirstAidKit", 20];
    	_cargo addItemCargoGlobal ["Medikit", 2];
    	_cargo addItemCargoGlobal ["ToolKit", 2];
    	_cargo addItemCargoGlobal ["NVGoggles", 5];
    	_cargo addItemCargoGlobal ["Laserdesignator", 2];
    	_cargo addBackpackCargoGlobal ["B_AssaultPack_rgr", 2];
    	_cargo addBackpackCargoGlobal ["B_Kitbag_rgr", 2];
        if (isClass(configfile >> "CfgPatches" >> "SMA_Weapons")) then { 
             _cargo addMagazineCargoGlobal ["SMA_30Rnd_762x35_BLK_EPR", 20];
             _cargo addMagazineCargoGlobal ["SMA_30Rnd_762x35_SS", 10];
             _cargo addMagazineCargoGlobal ["SMA_30Rnd_762x39_SKS_FMJ", 20];
             _cargo addMagazineCargoGlobal ["SMA_30Rnd_762x39_SKS_7n23_AP", 20];
             _cargo addMagazineCargoGlobal ["SMA_20Rnd_762x51mm_M80A1_EPR", 20];
             _cargo addMagazineCargoGlobal ["SMA_20Rnd_762x51mm_Mk316_Mod_0_Special_Long_Range", 20];
             _cargo addMagazineCargoGlobal ["SMA_20Rnd_762x51mm_Lapua_FMJ_Subsonic", 10];
             _cargo addMagazineCargoGlobal ["SMA_30Rnd_556x45_M855A1", 20];
             _cargo addMagazineCargoGlobal ["SMA_30Rnd_556x45_Mk318", 20];
             _cargo addMagazineCargoGlobal ["SMA_30Rnd_556x45_Mk262", 20];
             _cargo addMagazineCargoGlobal ["SMA_30Rnd_68x43_SPC_FMJ", 20];
             _cargo addMagazineCargoGlobal ["SMA_30Rnd_68x43_BT", 10];
             _cargo addMagazineCargoGlobal ["SMA_30Rnd_68x43_sub", 10];
             _cargo addMagazineCargoGlobal ["SMA_150Rnd_762_M80A1", 6];
        };
        _cargo addAction ["<t color='#7F0000'>Уничтожить ящик</t>","mission\main\actions\destroyCargo.sqf",[],-21,true,true,"","", 5]; 
    };
    if (_cargo_type == 13) exitWith {
        // Creating cargo
    	_cargo = "B_supplyCrate_F" createVehicle (getMarkerPos "Ammo_Supply_drop");
        sleep 0.1;

    	// Clearing cargo
    	clearWeaponCargoGlobal _cargo;
    	clearMagazineCargoGlobal _cargo;
    	clearItemCargoGlobal _cargo;
    	clearBackpackCargoGlobal _cargo;
    };
};

// Wait until cargo is droped off and attach smoke and light to it
waitUntil{sleep 5; !isNull (ropeAttachedTo _cargo)};
waitUntil{sleep 0.5; isNull (ropeAttachedTo _cargo)};
sleep 2;
waitUntil{sleep 0.1; (getPos _cargo select 2) <= 200};
_light1 = createVehicle [_light_type, position _cargo, [], 0, 'NONE'];
_light2 = createVehicle [_light_type, position _cargo, [], 0, 'NONE'];
_light3 = createVehicle [_light_type, position _cargo, [], 0, 'NONE'];
_light1 attachTo [_cargo, [-0.7, 0, 0.15]];
_light2 attachTo [_cargo, [0, 0.5, 0.15]];
_light3 attachTo [_cargo, [0.7, 0, 0.15]];
_smoke1 = createVehicle [_smoke_type, position _cargo, [], 0, 'NONE'];
_smoke1 attachTo [_cargo, [0, 0, 0]];

// Attach parachute
if (getPos _cargo select 2 > 32) then {
	_chute = createVehicle ["B_Parachute_02_F", position _cargo, [], 0, "CAN_COLLIDE"];
    _chute attachTo [_cargo, [0, 0, 0]];
    _velocity = velocity _cargo;
    detach _chute;
    _chute setVelocity _velocity;
    sleep 0.5;
    _cargo attachTo [_chute, [0, 0, 0]];
	waitUntil {sleep 0.1; (getPos _cargo select 2) < 4};
	detach _cargo;
	sleep 5;
	_smoke2 = createVehicle [_smoke_type, position _cargo, [], 0, 'NONE'];
    _smoke2 attachTo [_cargo, [0, 0, 0.5]];
};

// After landing wait for _deletionTime and delete the cargo
sleep _deletionTime;
if (!isNil {_cargo}) then {deleteVehicle _cargo};
if (!isNil {_light1}) then {deleteVehicle _light1};
if (!isNil {_light2}) then {deleteVehicle _light2};
if (!isNil {_light3}) then {deleteVehicle _light3};
if (!isNil {_smoke1}) then {deleteVehicle _smoke1};
if (!isNil {_smoke2}) then {deleteVehicle _smoke2};
