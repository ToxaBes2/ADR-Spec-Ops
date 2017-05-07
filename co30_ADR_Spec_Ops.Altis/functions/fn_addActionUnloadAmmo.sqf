/*
Author: ToxaBes
*/
_this addAction ["<t color='#FFFF00'>Разгрузить машину</t>","scripts\partizan\unloadAmmo.sqf",[],10,true,true,"","(playerSide == resistance) && (speed _target == 0) && (vehicle _this == _this)", 5];
