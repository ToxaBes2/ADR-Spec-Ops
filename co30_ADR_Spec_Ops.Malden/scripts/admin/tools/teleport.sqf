openMap true;
cutText ["Для быстрого перемещения, выберите любую точку на карте", "PLAIN"];
onMapSingleClick "vehicle player setPos _pos; onMapSingleClick '';true;";
"Переместил себя" call BIS_fnc_log;