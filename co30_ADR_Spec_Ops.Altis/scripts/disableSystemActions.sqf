inGameUISetEventHandler ["Action", "
    _text = format [""%1"", _this select 0];
    _id = _this select 2;
    if (_id == 8 && (_text == ""ammo1"" || _text == ""ammo2"" || _text == ""base_arsenal_infantry"" || _text == ""base_arsenal_pilots"")) then {
        hint ""Действие запрещено, используйте красный пункт меню Арсенал"";
        true;
    };
"];