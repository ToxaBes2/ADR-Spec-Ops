_ctrlMode = _this select 0;
disableSerialization;
#include "..\shared\cTab_gui_macros.hpp"

_idx = _ctrlMode lbAdd "Без изменений";
_ctrlMode lbSetData [_idx, "UNCHANGED"];

_idx = _ctrlMode lbAdd "Удерживаться от ведения огня";
_ctrlMode lbSetData [_idx, "BLUE"];

_idx = _ctrlMode lbAdd "Не стрелять, если по вам не стреляют, держать строй";
_ctrlMode lbSetData [_idx, "GREEN"];

_idx = _ctrlMode lbAdd "Не стрелять, если по вам не стреляют";
_ctrlMode lbSetData [_idx, "WHITE"];

_idx = _ctrlMode lbAdd "Открыть огонь, держать строй";
_ctrlMode lbSetData [_idx, "YELLOW"];

_idx = _ctrlMode lbAdd "Открыть огонь";
_ctrlMode lbSetData [_idx, "RED"];

_ctrlMode lbsetcursel 0;