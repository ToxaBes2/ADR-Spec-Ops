/*
Author: ToxaBes
Description: create 4 partizan caches if needed
*/
[] spawn {
    sleep 10;
    if !(isNil "PARTIZAN_BASE_SCORE") then {
        if (PARTIZAN_BASE_SCORE > 7) then {
            _center = [15000,15000];
            if (worldName == "Tanoa") then {
                _center = [8000,8000];
            };
            if (worldName == "Malden") then {
                _center = [6000,6000];
            };
            
            _dist = (_center select 0) / 2;
            
            _c1 = [(_center select 0) + _dist, (_center select 1) - _dist];
            _c2 = [(_center select 0) + _dist, (_center select 1) + _dist];
            _c3 = [(_center select 0) - _dist, (_center select 1) - _dist];
            _c4 = [(_center select 0) - _dist, (_center select 1) + _dist];
            
            _places1 = selectBestPlaces [_c1, _dist,"2*forest - sea + (2*trees))", 100, 10];
            _places2 = selectBestPlaces [_c2, _dist,"2*forest - sea + (2*trees))", 100, 10];
            _places3 = selectBestPlaces [_c3, _dist,"2*forest - sea + (2*trees))", 100, 10];
            _places4 = selectBestPlaces [_c4, _dist,"2*forest - sea + (2*trees))", 100, 10];
            
            _pos1 = (selectRandom _places1) select 0;
            _pos2 = (selectRandom _places2) select 0;
            _pos3 = (selectRandom _places3) select 0;
            _pos4 = (selectRandom _places4) select 0;
           
            _box1 = createVehicle ["Box_FIA_Support_F", _pos1, [], 0, "NONE"];
            _box2 = createVehicle ["Box_FIA_Support_F", _pos2, [], 0, "NONE"];
            _box3 = createVehicle ["Box_FIA_Support_F", _pos3, [], 0, "NONE"];
            _box4 = createVehicle ["Box_FIA_Support_F", _pos4, [], 0, "NONE"];
            
            clearWeaponCargoGlobal _box1;
            clearMagazineCargoGlobal _box1;
            clearBackpackCargoGlobal _box1;
            clearItemCargoGlobal _box1;
            
            clearWeaponCargoGlobal _box2;
            clearMagazineCargoGlobal _box2;
            clearBackpackCargoGlobal _box2;
            clearItemCargoGlobal _box2;
            
            clearWeaponCargoGlobal _box3;
            clearMagazineCargoGlobal _box3;
            clearBackpackCargoGlobal _box3;
            clearItemCargoGlobal _box3;
            
            clearWeaponCargoGlobal _box4;
            clearMagazineCargoGlobal _box4;
            clearBackpackCargoGlobal _box4;
            clearItemCargoGlobal _box4;
    
            _mkr1 = createMarker ["PARTIZAN_CACHE1", _pos1];
            _mkr1 setMarkerColor "ColorGuer";
            _mkr1 setMarkerType "mil_triangle";
            _mkr1 setMarkerText "Схрон";
            [_mkr1, 0] remoteExec ["setMarkerAlphaLocal", west, true];
            [_mkr1, 1] remoteExec ["setMarkerAlphaLocal", resistance, true];
            
            _mkr2 = createMarker ["PARTIZAN_CACHE2", _pos2];
            _mkr2 setMarkerColor "ColorGuer";
            _mkr2 setMarkerType "mil_triangle";
            _mkr2 setMarkerText "Схрон";
            [_mkr2, 0] remoteExec ["setMarkerAlphaLocal", west, true];
            [_mkr2, 1] remoteExec ["setMarkerAlphaLocal", resistance, true];
            
            _mkr3 = createMarker ["PARTIZAN_CACHE3", _pos3];
            _mkr3 setMarkerColor "ColorGuer";
            _mkr3 setMarkerType "mil_triangle";
            _mkr3 setMarkerText "Схрон";
            [_mkr3, 0] remoteExec ["setMarkerAlphaLocal", west, true];
            [_mkr3, 1] remoteExec ["setMarkerAlphaLocal", resistance, true];
            
            _mkr4 = createMarker ["PARTIZAN_CACHE4", _pos4];
            _mkr4 setMarkerColor "ColorGuer";
            _mkr4 setMarkerType "mil_triangle";
            _mkr4 setMarkerText "Схрон";
            [_mkr4, 0] remoteExec ["setMarkerAlphaLocal", west, true];
            [_mkr4, 1] remoteExec ["setMarkerAlphaLocal", resistance, true];
    
            _box1 addWeaponCargoGlobal ["launch_RPG7_F", 4];
            _box1 addMagazineCargoGlobal ["RPG7_F", 16];
    
            _box2 addWeaponCargoGlobal ["launch_RPG7_F", 4];
            _box2 addMagazineCargoGlobal ["RPG7_F", 16];
    
            _box3 addWeaponCargoGlobal ["launch_RPG7_F", 4];
            _box3 addMagazineCargoGlobal ["RPG7_F", 16];
    
            _box4 addWeaponCargoGlobal ["launch_RPG7_F", 4];
            _box4 addMagazineCargoGlobal ["RPG7_F", 16];
    
            if (PARTIZAN_BASE_SCORE > 16) then {
                _box1 addWeaponCargoGlobal ["arifle_AKM_F", 4];
                _box1 addMagazineCargoGlobal ["30Rnd_762x39_Mag_F", 16];
        
                _box2 addWeaponCargoGlobal ["arifle_AKM_F", 4];
                _box2 addMagazineCargoGlobal ["30Rnd_762x39_Mag_F", 16];
        
                _box3 addWeaponCargoGlobal ["arifle_AKM_F", 4];
                _box3 addMagazineCargoGlobal ["30Rnd_762x39_Mag_F", 16];
                
                _box4 addWeaponCargoGlobal ["arifle_AKM_F", 4];
                _box4 addMagazineCargoGlobal ["30Rnd_762x39_Mag_F", 16];
            };
    
            if (PARTIZAN_BASE_SCORE > 25) then {
                _box1 addMagazineCargoGlobal ["ATMine_Range_Mag", 4];
                _box1 addMagazineCargoGlobal ["APERSBoundingMine_Range_Mag", 4];
                _box1 addMagazineCargoGlobal ["IEDUrbanBig_Remote_Mag", 4];
                _box1 addMagazineCargoGlobal ["APERSTripMine_Wire_Mag", 4];
    
                _box2 addMagazineCargoGlobal ["ATMine_Range_Mag", 4];
                _box2 addMagazineCargoGlobal ["APERSBoundingMine_Range_Mag", 4];
                _box2 addMagazineCargoGlobal ["IEDUrbanBig_Remote_Mag", 4];
                _box2 addMagazineCargoGlobal ["APERSTripMine_Wire_Mag", 4];
    
                _box3 addMagazineCargoGlobal ["ATMine_Range_Mag", 4];
                _box3 addMagazineCargoGlobal ["APERSBoundingMine_Range_Mag", 4];
                _box3 addMagazineCargoGlobal ["IEDUrbanBig_Remote_Mag", 4];
                _box3 addMagazineCargoGlobal ["APERSTripMine_Wire_Mag", 4];
    
                _box4 addMagazineCargoGlobal ["ATMine_Range_Mag", 4];
                _box4 addMagazineCargoGlobal ["APERSBoundingMine_Range_Mag", 4];
                _box4 addMagazineCargoGlobal ["IEDUrbanBig_Remote_Mag", 4];
                _box4 addMagazineCargoGlobal ["APERSTripMine_Wire_Mag", 4];
            };
    
            if (PARTIZAN_BASE_SCORE > 34) then {
                _box1 addItemCargoGlobal ["U_I_CombatUniform", 4];
                _box1 addItemCargoGlobal ["V_PlateCarrierIAGL_dgtl", 4];
                _box1 addItemCargoGlobal ["H_HelmetIA", 4];
                _box1 addBackpackCargoGlobal ["B_FieldPack_oli", 4];
    
                _box2 addItemCargoGlobal ["U_I_CombatUniform", 4];
                _box2 addItemCargoGlobal ["V_PlateCarrierIAGL_dgtl", 4];
                _box2 addItemCargoGlobal ["H_HelmetIA", 4];
                _box2 addBackpackCargoGlobal ["B_FieldPack_oli", 4];
    
                _box3 addItemCargoGlobal ["U_I_CombatUniform", 4];
                _box3 addItemCargoGlobal ["V_PlateCarrierIAGL_dgtl", 4];
                _box3 addItemCargoGlobal ["H_HelmetIA", 4];
                _box3 addBackpackCargoGlobal ["B_FieldPack_oli", 4];
    
                _box4 addItemCargoGlobal ["U_I_CombatUniform", 4];
                _box4 addItemCargoGlobal ["V_PlateCarrierIAGL_dgtl", 4];
                _box4 addItemCargoGlobal ["H_HelmetIA", 4];
                _box4 addBackpackCargoGlobal ["B_FieldPack_oli", 4];
            };
        };
    };
};
