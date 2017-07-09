/*
Author: ToxaBes
Description: disable thermal view on viper's helmets and ENVG-II googles
*/
_helmets = ["H_HelmetO_ViperSP_hex_F","H_HelmetO_ViperSP_ghex_F"];
_items = ["NVGogglesB_blk_F","NVGogglesB_grn_F","NVGogglesB_gry_F"];
while {true} do { 
    if (currentVisionMode player == 2) then {
        if !((getConnectedUAV player) isKindOf "UAV_01_base_F") then {
            _hide = false;
            if (headgear player in _helmets) then {                                                                                                         
                _hide = true;   
            } else {
                _assignedItems = assignedItems player;
                {
                    _curItem = _x;
                    if (!_hide && {({_curItem == _x} count _assignedItems) > 0 }) then {
                        _hide = true;
                    };
                } forEach _items;                
            };      
            if (_hide) then {
                cutText ["Тепловизор не работает, нажмите N для перезагрузки.", "BLACK", -1];
                playSound "FD_CP_Not_Clear_F";
                waituntil {currentVisionMode player != 2};
                0 cutFadeOut 0;
            };
        };
    };
};
