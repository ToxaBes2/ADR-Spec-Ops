/*
Aithor: ToxaBes
*/
_text = "Поставить ящик";
if (_this isKindOf "Car") then {
    _text = "Выгрузить ящик";
};
_action = _this addAction [format ["<t color='#EDBC64'>%1</t>",_text],"scripts\partizan\unload.sqf",[],-100,true,true,"","playerSide == resistance", 5];
_this setVariable ["drop_box", _action];