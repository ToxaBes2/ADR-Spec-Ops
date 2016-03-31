if (CLEARITEMSBASE_SWITCH) exitWith {
	hint "Очистка базы не доступна."
};

//-------------------- Wait for player to action

sleep 1;

//-------------------- Send hint to player that he's planted the bomb

hint "Очистка базы от мусора.";

sleep 1;

//---------- Send notice to all players that charge has been set.

CLEARITEMSBASE_SWITCH = true; publicVariable "CLEARITEMSBASE_SWITCH";