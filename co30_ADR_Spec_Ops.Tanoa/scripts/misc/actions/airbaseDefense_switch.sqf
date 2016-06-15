if (AIRBASEDEFENSE_SWITCH) exitWith {
	hint "Противовоздушная оборона будет доступна в течение 5 минут."
};

//-------------------- Wait for player to action

sleep 1;

//-------------------- Send hint to player that he's planted the bomb

hint "Активирована противо-воздушная оборона базы...";

sleep 1;

//---------- Send notice to all players that charge has been set.

AIRBASEDEFENSE_SWITCH = true; publicVariable "AIRBASEDEFENSE_SWITCH";