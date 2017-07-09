/*
Author:	malashin
Description: Block rear ramp interaction unless you are a pilot of the current vehicle
*/

inGameUISetEventHandler ["Action", "
if ((_this select 3 == 'UserType') and (driver (vehicle player) != player)) then {
    if (((_this select 0) isKindOf 'Helicopter') or ((_this select 0) isKindOf 'VTOL_Base_F')) then {
        systemChat 'Данное действие доступно только пилоту';
        true;
    };
}"];
