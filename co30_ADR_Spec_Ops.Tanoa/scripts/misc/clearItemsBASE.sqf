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

while { true } do {
	if (CLEARITEMSBASE_SWITCH) then {
		hqSideChat = "Очистка мусора на базе..."; publicVariable "hqSideChat"; [WEST, "HQ"] sideChat hqSideChat;
		sleep 1;

        // Add droped items to the deletion array
		_itemsToClear = _obj nearObjects ["GroundWeaponHolder", _rad];
		_itemsToClear append (_obj nearObjects ["WeaponHolderSimulated", _rad]);

        // Add craters to the deletion array
        _itemsToClear append (_obj nearObjects ["CraterLong", _rad]);

        // Add dead bodies and destroyed vehicles to the deletion array
        {
            if (_x distance2D _obj < _rad) then {
                _itemsToClear pushBack _x;
            };
        } forEach allDead;

        // Delete items in the deletion array
		{
			deleteVehicle _x;
		} forEach _itemsToClear;

		sleep 1;

		hqSideChat = "Следующая очистка будет доступна через несколько минут."; publicVariable "hqSideChat"; [WEST, "HQ"] sideChat hqSideChat;
		sleep _delay;
		CLEARITEMSBASE_SWITCH = false; publicVariable "CLEARITEMSBASE_SWITCH";
		hqSideChat = "Очистка базы доступна"; publicVariable "hqSideChat"; [WEST, "HQ"] sideChat hqSideChat;
	};
	sleep _loopTimeout;
};
