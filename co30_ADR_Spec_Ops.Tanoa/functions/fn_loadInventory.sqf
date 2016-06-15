/*
Author: Quiksilver
Date modified: 12/10/2014 ArmA 1.30
*/

if (!(respawnInventory_Saved)) exitWith {hint "Нет сохраненного снаряжения для быстрой загрузки!";};
if (loading_inventory) exitWith {hint "Загрузка снаряжения, пожалуйста ждите...";};
loading_inventory = true;
hint "Снаряжение загружено";
[player,[player,"ClassGear"]] call BIS_fnc_loadInventory;
[] spawn {
	sleep 3;
	loading_inventory = false;
};