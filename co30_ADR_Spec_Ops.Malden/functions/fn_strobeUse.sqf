/*
Author: ToxaBes
Description: mark pleayer with IR grenade
*/
_type = _this select 3;
STROBE_ITEM = _type createVehicle [0,0,0]; 
if (_type == "B_IRStrobe") then {
    _type = "B_IR_Grenade";
};
if (_type == "I_IRStrobe") then {
    _type = "I_IR_Grenade";
};
player removeMagazine _type;
STROBE_ITEM attachTo [player, [0,0,0], "RightShoulder"];