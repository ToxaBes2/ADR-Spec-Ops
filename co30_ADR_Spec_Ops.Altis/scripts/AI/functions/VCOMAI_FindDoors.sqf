private ["_model_pos","_world_pos","_anim_source_pos_arr"];

_house = _this;
_selections = selectionNames _house;
_anim_source_pos_arr = [];
{
    if (((_x find "door" >= 0) || (_x find "dvere" >= 0)) && !((_x find "trigger" > -1) || (_x find "handle" > -1))) then {
        _model_pos = _house selectionPosition _x;
        _world_pos = _house modelToWorld _model_pos;
        _anim_source_pos_arr pushBack _world_pos;
    };
} forEach _selections;
_anim_source_pos_arr
