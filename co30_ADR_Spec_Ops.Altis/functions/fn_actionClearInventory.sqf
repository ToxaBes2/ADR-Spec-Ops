// Author: Quiksilver
// Clear inventory add action

_v = vehicle player;
clearItemCargoGlobal _v;
clearMagazineCargoGlobal _v;
clearWeaponCargoGlobal _v;
//clearBackpackCargoGlobal _v; //This one is bugged. Deletes backpacks, but their weight persists, as of 1.50.131969.
inventory_cleared = true;
[] spawn {
	sleep 60;
	inventory_cleared = false;
};