_ctrlMode = _this select 0;
disableSerialization;
#include "..\shared\cTab_gui_macros.hpp"

_idx = _ctrlMode lbAdd "Без изменений";
_ctrlMode lbSetData [_idx, "UNCHANGED"];

_idx = _ctrlMode lbAdd "Ограниченная";
_ctrlMode lbSetData [_idx, "LIMITED"];

_idx = _ctrlMode lbAdd "Нормальная";
_ctrlMode lbSetData [_idx, "NORMAL"];

_idx = _ctrlMode lbAdd "Полная";
_ctrlMode lbSetData [_idx, "FULL"];

_ctrlMode lbsetcursel 0;