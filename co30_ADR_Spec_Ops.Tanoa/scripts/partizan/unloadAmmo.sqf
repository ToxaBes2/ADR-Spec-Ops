/*
Author: ToxaBes
Description: unload ammo from blufor convoy.
*/
_veh = _this select 0;
_player = _this select 1;
_id = _this select 2;
if (vehicle _player != _player) exitWith {
    ["<t color='#F44336' size = '.48'>Действия по разгрузке доступны только вне техники.</t>", 0, 0.8, 3, 0.5, 0] spawn BIS_fnc_dynamicText;
};
_veh removeAction _id;
if (typeOf _veh == "B_Truck_01_box_F") then {
    {
        _x action ["EJECT", _veh];
    } forEach (crew _veh);       
    _dir = getDir _veh;
    _pos = getPos _veh;
    deleteVehicle _veh;    
    _veh1 = createVehicle ["B_Truck_01_mover_F", [1,1,450], [], 0, "NONE"];
    _veh1 setDir _dir;
    _veh1 setPos _pos;
};

hqSideChat = "Конвой с боеприпасами уничтожен!";
publicVariable "hqSideChat"; 
[WEST, "HQ"] sideChat hqSideChat;

hqSideChat = "Боеприпасы захвачены!";
publicVariable "hqSideChat";
[resistance, "HQ"] sideChat hqSideChat;

ARSENAL_ENABLED = false;
publicVariable "ARSENAL_ENABLED";

// Add ammo to partizan base
partizan_ammo addItemCargoGlobal ["FirstAidKit", 20];
partizan_ammo addMagazineCargoGlobal ["30Rnd_762x39_Mag_F", 20];
partizan_ammo addMagazineCargoGlobal ["30Rnd_65x39_caseless_mag", 20];
partizan_ammo addMagazineCargoGlobal ["30Rnd_556x45_Stanag", 20];
partizan_ammo addMagazineCargoGlobal ["130Rnd_338_Mag", 5];
partizan_ammo addMagazineCargoGlobal ["150Rnd_93x64_Mag", 5];
partizan_ammo addMagazineCargoGlobal ["200Rnd_65x39_cased_Box", 5];
partizan_ammo addMagazineCargoGlobal ["200Rnd_556x45_Box_F", 10];
partizan_ammo addMagazineCargoGlobal ["150Rnd_556x45_Drum_Mag_F", 10];
partizan_ammo addMagazineCargoGlobal ["10Rnd_50BW_Mag_F", 15];
partizan_ammo addMagazineCargoGlobal ["10Rnd_93x64_DMR_05_Mag", 20];
partizan_ammo addMagazineCargoGlobal ["10Rnd_338_Mag", 20];
partizan_ammo addMagazineCargoGlobal ["20Rnd_762x51_Mag", 20];
partizan_ammo addMagazineCargoGlobal ["7Rnd_408_Mag", 20];
partizan_ammo addMagazineCargoGlobal ["10Rnd_127x54_Mag", 20];
partizan_ammo addMagazineCargoGlobal ["20Rnd_650x39_Cased_Mag_F", 20];
partizan_ammo addMagazineCargoGlobal ["HandGrenade", 15];
partizan_ammo addMagazineCargoGlobal ["1Rnd_HE_Grenade_shell", 15];
partizan_ammo addMagazineCargoGlobal ["3Rnd_HE_Grenade_shell", 15];
partizan_ammo addMagazineCargoGlobal ["Titan_AA", 10];
partizan_ammo addMagazineCargoGlobal ["Titan_AT", 10];
partizan_ammo addMagazineCargoGlobal ["RPG32_F", 10];
partizan_ammo addMagazineCargoGlobal ["NLAW_F", 10];
partizan_ammo addMagazineCargoGlobal ["MRAWS_HEAT_F", 10];
partizan_ammo addMagazineCargoGlobal ["MRAWS_HE_F", 10];
partizan_ammo addMagazineCargoGlobal ["IEDUrbanBig_Remote_Mag", 5];
partizan_ammo addMagazineCargoGlobal ["SatchelCharge_Remote_Mag", 5];
partizan_ammo addMagazineCargoGlobal ["SLAMDirectionalMine_Wire_Mag", 5];
partizan_ammo addMagazineCargoGlobal ["APERSBoundingMine_Range_Mag", 5];
if (isClass(configfile >> "CfgPatches" >> "SMA_Weapons")) then { 
    partizan_ammo addMagazineCargoGlobal ["SMA_30Rnd_762x35_BLK_EPR", 20];
    partizan_ammo addMagazineCargoGlobal ["SMA_30Rnd_762x35_SS", 20];
    partizan_ammo addMagazineCargoGlobal ["SMA_30Rnd_762x39_SKS_FMJ", 20];
    partizan_ammo addMagazineCargoGlobal ["SMA_30Rnd_762x39_SKS_7n23_AP", 20];
    partizan_ammo addMagazineCargoGlobal ["SMA_20Rnd_762x51mm_M80A1_EPR", 20];
    partizan_ammo addMagazineCargoGlobal ["SMA_20Rnd_762x51mm_Mk316_Mod_0_Special_Long_Range", 20];
    partizan_ammo addMagazineCargoGlobal ["SMA_20Rnd_762x51mm_Lapua_FMJ_Subsonic", 20];
    partizan_ammo addMagazineCargoGlobal ["SMA_30Rnd_556x45_M855A1", 20];
    partizan_ammo addMagazineCargoGlobal ["SMA_30Rnd_556x45_Mk318", 20];
    partizan_ammo addMagazineCargoGlobal ["SMA_30Rnd_556x45_Mk262", 20];
    partizan_ammo addMagazineCargoGlobal ["SMA_30Rnd_68x43_SPC_FMJ", 20];
    partizan_ammo addMagazineCargoGlobal ["SMA_30Rnd_68x43_BT", 20];
    partizan_ammo addMagazineCargoGlobal ["SMA_30Rnd_68x43_sub", 20];
    partizan_ammo addMagazineCargoGlobal ["SMA_150Rnd_762_M80A1", 10];
};
