/*
Author: ToxaBes
Description: atttach items to the hand or body
*/
_type = _this select 3;
HAND_ITEM = _type createVehicle [0,0,0]; 
if (_type == "B_IRStrobe") then {
    _type = "B_IR_Grenade";
};
if (_type == "I_IRStrobe") then {
    _type = "I_IR_Grenade";
};
player removeMagazine _type;
{HAND_ITEM attachTo [player, [0,0,0], "lefthand"];} remoteExec ["bis_fnc_call", 0, TRUE];
player setVariable ["IN_HAND", true, true];