/*
@filename: clearItemsBASE.sqf
Author:

	Quiksilver
	
Description:

	Clear items from the base area.
	Activated via addAction on PC terminal at base.
	Linked to file clearItemsBASE_switch.sqf.
	
____________________________________________________________________*/


private ["_itemsToClear","_obj","_rad","_delay","_loopTimeout"];
_obj = getMarkerPos "respawn_west";								// base area
_rad = 600;														// radius outwards from center point to clear items.
_delay = 120;													// default 600, or should be done after each AO?
_loopTimeout = 10 + (random 10);								// default 300 or 600? greater time = less costly loop?

CLEARITEMSBASE_SWITCH = false; publicVariable "CLEARITEMSBASE_SWITCH";
 
//---------- LOOP
 
while { true } do { 
 
	if (CLEARITEMSBASE_SWITCH) then {
	
		//---------- BRIEF

		hqSideChat = "Очистка мусора на базе..."; publicVariable "hqSideChat"; [WEST, "HQ"] sideChat hqSideChat;

		sleep 1;

		//---------- CORE
		
		_itemsToClear = nearestObjects [_obj,["weaponholder"],_rad];
		{
			deleteVehicle _x;
		} forEach _itemsToClear;
	
		sleep 1;
	
		//---------- DE-BRIEF
	
		hqSideChat = "Следующая очистка будет доступна через несколько минут."; publicVariable "hqSideChat"; [WEST, "HQ"] sideChat hqSideChat;
	
		sleep _delay;
	
		//---------- RESET
	
		CLEARITEMSBASE_SWITCH = false; publicVariable "CLEARITEMSBASE_SWITCH";
		hqSideChat = "Очистка базы доступна"; publicVariable "hqSideChat"; [WEST, "HQ"] sideChat hqSideChat;

	};
	
	sleep _loopTimeout;
	
};