/*
Author: ToxaBes
*/
_this addAction ["<t color='#FFFF00'>Забрать боеприпасы</t>","scripts\partizan\unloadAmmo.sqf",[],10,true,true,"","(playerSide == resistance) && (speed _target == 0) && (vehicle _this == _this)", 5];
_this addAction ["<t color='#FFFF00'>Забрать боеприпасы</t>","scripts\partizan\unloadAmmoBlufor.sqf",[],10,true,true,"","(playerSide == west) && (speed _target == 0) && (vehicle _this == _this)", 5];