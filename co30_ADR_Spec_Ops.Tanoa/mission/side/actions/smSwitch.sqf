/*
@filename: smSwitch.sqf
Author:

	Quiksilver

Description:

	Actioning the character triggers mission cycle.

_______________________________________________________*/

if (SM_SWITCH) exitWith {
	hint "Дополнительные задания определяются. Ждите дальнейших указаний."
};

//-------------------- Send hint to player that he's planted the bomb
hint "Дополнительное задание формируется, ждите подробных инструкций.";

sleep 1;

SM_SWITCH = true; publicVariable "SM_SWITCH";