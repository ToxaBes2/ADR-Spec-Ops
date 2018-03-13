/*
Author: ToxaBes
Description: spawn AP mines
*/
_uav = _this select 0;
_expPos1 = (getPos _uav) vectorAdd [0, 0, 4];
_expPos1 = (getPos _uav) vectorAdd [0, 0, 5];
_expDir1 = (getDir _uav) - 45;
_expDir2 = (getDir _uav) + 45;
_explosive1 = "APERSMineDispenser_Ammo_Scripted" createVehicle _expPos1;            
_explosive1 setDir _expDir1;
_explosive1 setDamage 1; 
_explosive2 = "APERSMineDispenser_Ammo_Scripted" createVehicle _expPos2;            
_explosive2 setDir _expDir2;
_explosive2 setDamage 1;    
_uav setDamage 1;