private ["_obj", "_rad", "_delay", "_itemsToClear"];

// Variables
_obj = getMarkerPos "respawn_west";								// base area
_rad = 600;														// radius outwards from center point to clear items.
_delay = 120;													// default 600, or should be done after each AO?

// Restrict use of this action while procedure is in progress
CLEARITEMSBASE_SWITCH = true; publicVariable "CLEARITEMSBASE_SWITCH";

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
	sleep 0.1;
} forEach _itemsToClear;
sleep 1;

hqSideChat = "Следующая очистка будет доступна через несколько минут."; publicVariable "hqSideChat"; [WEST, "HQ"] sideChat hqSideChat;
sleep _delay;

//Remove action use restriction after procedure is finished
CLEARITEMSBASE_SWITCH = nil; publicVariable "CLEARITEMSBASE_SWITCH";
hqSideChat = "Очистка базы доступна"; publicVariable "hqSideChat"; [WEST, "HQ"] sideChat hqSideChat;
