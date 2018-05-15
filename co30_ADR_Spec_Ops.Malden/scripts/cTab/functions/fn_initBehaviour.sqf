_ctrlMode = _this select 0;
disableSerialization;
#include "..\shared\cTab_gui_macros.hpp"

_idx = _ctrlMode lbAdd "Без изменений";
_ctrlMode lbSetData [_idx, "UNCHANGED"];

_idx = _ctrlMode lbAdd "Беспечно";
_ctrlMode lbSetData [_idx, "CARELESS"];

_idx = _ctrlMode lbAdd "Безопасно";
_ctrlMode lbSetData [_idx, "SAFE"];

_idx = _ctrlMode lbAdd "Начеку";
_ctrlMode lbSetData [_idx, "AWARE"];

_idx = _ctrlMode lbAdd "С боем";
_ctrlMode lbSetData [_idx, "COMBAT"];

_idx = _ctrlMode lbAdd "Скрытно";
_ctrlMode lbSetData [_idx, "STEALTH"];

_ctrlMode lbsetcursel 0;