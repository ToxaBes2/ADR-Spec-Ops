disableSerialization;
#include "..\shared\cTab_gui_macros.hpp"
_displayName = cTabIfOpen select 1;
_display = uiNamespace getVariable _displayName;
_grpCtrl = _display displayCtrl IDC_CTAB_GROUP_BALLISTIC;
_mode = _this select 0;
_modCtrl = _grpCtrl controlsGroupCtrl IDC_CTAB_BALLISTIC_MODE;
_elvCtrl = _grpCtrl controlsGroupCtrl IDC_CTAB_SOLUTION_1_ELV;
_dirCtrl = _grpCtrl controlsGroupCtrl IDC_CTAB_SOLUTION_1_DIR;
_etaCtrl = _grpCtrl controlsGroupCtrl IDC_CTAB_SOLUTION_1_ETA;
if (_mode == 1) then {
    _elvCtrl = _grpCtrl controlsGroupCtrl IDC_CTAB_SOLUTION_2_ELV;
    _dirCtrl = _grpCtrl controlsGroupCtrl IDC_CTAB_SOLUTION_2_DIR;
    _etaCtrl = _grpCtrl controlsGroupCtrl IDC_CTAB_SOLUTION_2_ETA;
};
_elv = ctrltext _elvCtrl;
_dir = ctrltext _dirCtrl;
_eta = ctrltext _etaCtrl;
_modIdx = lbCurSel _modCtrl;
_mod = _modCtrl lbText _modIdx;
_message = format ["ELV: %1 | DIR: %2 | ETA: %3 | MOD: %4", _elv, _dir, _eta, _mod];
_chatId = currentChannel;
switch (_chatId) do { 
    case 0 : {
        player globalChat _message;
    };
	case 1 : {
        player sideChat _message;
    }; 
	case 2 : {
        player commandChat _message;
    }; 
	case 3 : {
        player groupChat _message;
    }; 
	case 4 : {
        player vehicleChat _message;
    }; 
	case 5 : {
        systemChat _message;
    }; 	
	default {
        player customChat [_chatId, _message];
    }; 
};
