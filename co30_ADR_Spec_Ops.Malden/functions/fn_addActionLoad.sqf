/*
Aithor: ToxaBes
*/
_action = _this addAction ["<t color='#EDBC64'>Загрузить ящик в технику</t>","scripts\partizan\load.sqf",[],-100,true,true,"",'playerSide == resistance && (_this distance cursorTarget) < 5 && (cursorTarget isKindOf "Car" || cursorTarget isKindOf "Ship" || cursorTarget isKindOf "Air")'];
_this setVariable ["load_box", _action];
