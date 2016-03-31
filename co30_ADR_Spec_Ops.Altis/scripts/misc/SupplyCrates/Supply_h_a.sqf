private ["_heli", "_reloadtime"];

if (!(BACO_ammoSuppAvail)) exitWith {
	hint "Модуль в данный момент не доступен!"
};

BACO_ammoSuppAvail = FALSE; publicVariable "BACO_ammoSuppAvail";

//------------------------------------------------------- CONFIG

_heli = _this select 0;
_crateType =  "O_supplyCrate_F";		//ammocrate class for blufor, feel free to change to whichever box you desire
_reloadtime = 30;  						// time before next ammo drop is available to use, default 600 or 480

//--------------------------------------------------------- MEAT AND POTATOES

Supply_Ammo = _crateType createVehicle (getMarkerPos "Ammo_Supply_drop");; publicVariable "Supply_Ammo"; 
Supply_Ammo allowDamage false;
//---------------------------------------------------- CLEAR CRATE

clearWeaponCargoGlobal Supply_Ammo;
clearMagazineCargoGlobal Supply_Ammo;
clearItemCargoGlobal Supply_Ammo;

//---------------------------------------------------- CRATE CONTENTS

Supply_Ammo addItemCargoGlobal ["FirstAidKit", 20]; 
Supply_Ammo addItemCargoGlobal ["Medikit", 1]; 
Supply_Ammo addItemCargoGlobal ["ToolKit", 1]; 
Supply_Ammo addMagazineCargoGlobal ["Laserbatteries", 5];
Supply_Ammo addMagazineCargoGlobal ["5Rnd_127x108_Mag", 15]; 
Supply_Ammo addMagazineCargoGlobal ["7Rnd_408_Mag", 15]; 
Supply_Ammo addMagazineCargoGlobal ["10Rnd_93x64_DMR_05_Mag", 20]; 
Supply_Ammo addMagazineCargoGlobal ["10Rnd_127x54_Mag", 20]; 
Supply_Ammo addMagazineCargoGlobal ["10Rnd_338_Mag", 20]; 
Supply_Ammo addMagazineCargoGlobal ["20Rnd_762x51_Mag", 20]; 
Supply_Ammo addMagazineCargoGlobal ["30Rnd_65x39_caseless_mag", 20]; 
Supply_Ammo addMagazineCargoGlobal ["30Rnd_65x39_caseless_green", 10]; 
Supply_Ammo addMagazineCargoGlobal ["30Rnd_556x45_Stanag", 20]; 
Supply_Ammo addMagazineCargoGlobal ["30Rnd_65x39_caseless_mag_Tracer", 20]; 
Supply_Ammo addMagazineCargoGlobal ["100Rnd_65x39_caseless_mag", 10]; 
Supply_Ammo addMagazineCargoGlobal ["150Rnd_762x51_Box", 10]; 
Supply_Ammo addMagazineCargoGlobal ["200Rnd_65x39_cased_Box_Tracer", 10]; 
Supply_Ammo addMagazineCargoGlobal ["10Rnd_762x54_Mag", 10]; 
Supply_Ammo addMagazineCargoGlobal ["150Rnd_93x64_Mag", 5]; 
Supply_Ammo addMagazineCargoGlobal ["130Rnd_338_Mag", 5]; 
Supply_Ammo addMagazineCargoGlobal ["SatchelCharge_Remote_Mag", 2]; 
Supply_Ammo addMagazineCargoGlobal ["HandGrenade", 6]; 
Supply_Ammo addMagazineCargoGlobal ["SmokeShell", 6]; 
Supply_Ammo addMagazineCargoGlobal ["SmokeShellGreen", 6]; 
Supply_Ammo addMagazineCargoGlobal ["1Rnd_HE_Grenade_shell", 16]; 
Supply_Ammo addMagazineCargoGlobal ["RPG32_HE_F", 5]; 
Supply_Ammo addMagazineCargoGlobal ["RPG32_F", 7]; 
Supply_Ammo addMagazineCargoGlobal ["NLAW_F", 5]; 
Supply_Ammo addMagazineCargoGlobal ["Titan_AT", 3]; 
Supply_Ammo addMagazineCargoGlobal ["Titan_AA", 3];

uiSleep _reloadtime; BACO_ammoSuppAvail = TRUE; publicVariable "BACO_ammoSuppAvail";