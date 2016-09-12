/*
Author: ToxaBes
Description: create bunker in AO.
Format: [_tower] call QS_fnc_createBunker;
*/
if (!isServer) exitWith {};
_flatPos = _this select 0;
_small = _this select 1;
_big = _this select 2;
_startPoint = [_flatPos select 0, _flatPos select 1, 0];
_startDir = 0;
_objects = [];
_composition = [
    ["Land_Dome_Small_F", 0, 0, 0, 0, false, false, true],
    ["Land_Dome_Big_F", 0, 0, 0, 0, false, true, true],
    ["Land_Cargo_HQ_V4_F", 0, 0, 270, 0, false, false, true],
    ["Land_CncWall4_F", 14.1, 0, 0, 0, false, false, true],
    ["Land_BagBunker_01_small_green_F", 20.8, 0, 180, 0, false, false, true],
    ["Land_CncBarrierMedium_F", 23.5, -7.5, 0, 0, false, false, true],
    ["Land_CncBarrierMedium_F", 23.5, 7.5, 0, 0, false, false, true],
    ["O_HMG_01_high_F", 22.5, 0, 0, 0, false, false, true],
    ["Land_CncWall4_F", 21.5, 97, 0, 0, false, false, true],
    ["Land_CncWall4_F", 17.5, 99, 0, 0, false, false, true],
    ["Land_BagBunker_01_small_green_F", 18, 35, 320, 0, false, false, true],
    ["O_HMG_01_high_F", 19, 35, 140, 0, false, false, true],
    ["Land_Cargo_Patrol_V4_F", 19.3, 111.5, 180, -1.6, false, false, true],
    ["Land_CncWall4_F", 23.2, 180, 0, 0, false, false, true],
    ["Land_CncWall1_F", 23.2, -188, 0, 0, false, false, true],
    ["Land_CncWall1_F", 23.2, 188, 0, 0, false, false, true],
    ["Land_BagBunker_01_small_green_F", 21, 182, 125, 0, false, false, true],
    ["O_HMG_01_high_F", 19.7, 183, 305, 0, false, false, true],
    ["Land_Cargo_Patrol_V4_F", 20, 159, 90, -1.6, false, false, true],
    ["Land_PortableLight_double_F", 9, 145, 50, 0, false, true, true],
    ["Land_PortableLight_single_F", 22, 195, 150, 0, false, true, true],
    ["Land_PortableLight_double_F", 23, 12, 330, 0, false, true, true],
    ["Land_PortableLight_double_F", 16, 0, 180, 0, false, true, true],
    ["MapBoard_altis_F", 6, 225, 220, 0.6, false, false, false, [-3.7168,-3.76367,0.603112]],
    ["MapBoard_seismic_F", 4, 270, 310, 0.6, false, false, false, [-3.77734,0.800781,0.603112]],
    ["Land_CampingTable_F", 5, 245, 90, 0.6, false, false, false, [-3.48242,-1.62039,0.603112]],
    ["Land_OfficeChair_01_F", 4, 235, 90, 0.6, false, false, false, [-2.7,-1.9,0.603112]],
    ["Land_PCSet_01_screen_F", 5.5, 240, 270, 1.42, false, false, false, [-3.7,-1.9,1.42]],
    ["Land_PCSet_01_keyboard_F", 5.1, 237, 270, 1.42, false, false, false, [-3.4,-2,1.42]],
    ["Land_PCSet_01_mouse_F", 5, 241, 270, 1.42, false, false, false, [-3.4,-1.6,1.42]],
    ["Land_PCSet_01_case_F", 4.85, 245, 280, 1.42, false, false, false, [-3.4,-1.15,1.42]],
    ["Land_CampingTable_F", 1.5, 270, 180, 0.6, false, false, false, [-2,0.800781,0.603112]],
    ["Land_SatellitePhone_F", 2, 270, 0, 1.42, false, false, false, [-2.5,0.800781,1.42]],
    ["Land_Tablet_02_F", 0.8, 270, (random 360), 1.41, false, false, false, [-1.5,0.800781,1.41]],
    ["Land_OfficeChair_01_F", 1.5, 225, (180 + (random 10)), 0.6, false, false, false, [-2.2,-0.3,0.603112]],
    ["Land_CampingTable_F", 7.2, 290, 90, 0.6, false, false, false, [-5.89063,3.39844,0.723526]],
    ["Land_CampingTable_F", 8.2, 305, 90, 0.6, false, false, false, [-5.89063,5.37109,0.723526]],
    ["Land_Laptop_unfolded_F", 7, 286, 90, 1.41, false, false, false, [-5.89063,3,1.54]],
    ["Land_Document_01_F", 7.3, 295, 270, 1.415, false, false, false, [-5.7,4,1.54]],
    ["Land_Laptop_device_F", 8, 303, 90, 1.41, false, false, false, [-5.89063,5,1.54]],
    ["Land_File_research_F", 8.2, 307, 270, 1.415, false, false, false, [-5.9,5.9,1.54]],
    ["Land_OfficeChair_01_F", 6, 290, (90 + (random 10)), 0.72, false, false, false, [-4.91367,3.08008,0.723526]],
    ["Land_OfficeChair_01_F", 7, 306, (90 + (random 10)), 0.72, false, false, false, [-4.9707,4.78125,0.723526]],
    ["Land_CampingTable_small_F", 1.6, 325, 0, 0.6, false, false, false, [-0.25,2.2,0.603112]],
    ["Land_PressureWasher_01_F", 3, 300, 180, 0.6, false, false, false, [-1.43555,2.2,0.603112]],
    ["Box_East_WpsSpecial_F", 8.3, 330, 180, 0.7, false, false, true, [-3.19141,8.3,0.723531]],
    ["Land_EngineCrane_01_F", 6, 280, 20, 3.15, false, false, false, [-4.80664,2,3.11098]],
    ["O_CargoNet_01_ammo_F", 6.1, 270, 20, 3.15, false, false, true, [-5.10352,1.41992,3.15]],
    ["Land_Pallet_MilBoxes_F", 6, 320, 20, 3.15, false, false, false,[-4,5.4,3.12796]],
    ["Land_DataTerminal_01_F", 6, 0, (random 10), 3.15, false, false, true, [-1.14063,6.55664,3.12796]]
];
{
    _name = _x select 0;
    _len = _x select 1;
    _d = _x select 2;
    _objDir = _startDir + (_x select 3);
    _z = _x select 4;
    _randomization = _x select 5;
    _damage = _x select 6;
    _simulation = _x select 7;
    _deltaCoords = _x param [8, []];
    _dir = _startDir + _d;
    _pos = [_startPoint, _len, _dir] call BIS_fnc_relPos;
    _obj = createVehicle [_name, [0,0,0], [], 0, "NONE"];
    _obj setVariable ["BIS_enableRandomization", _randomization];
    if (_name == "Land_Dome_Small_F") then {
    	_pos set [2, _small];
    	{
            _x addCuratorEditableObjects [[_obj], true];
        } forEach allCurators;
    };
    if (_name == "Land_Dome_Big_F") then {
    	_pos set [2, _big];
    	{
            _x addCuratorEditableObjects [[_obj], true];
        } forEach allCurators;
        _obj animate ["door_3_rot", 1];
    };
    if (_name == "Land_CncWall1_F" || _name == "Land_CncWall4_F") then {
        if (count _pos == 2) then {
            _pos set [2, 0];
        };
        _pos set [2, (_pos select 2) - 0.3];
    };
    if (_name == "Box_East_WpsSpecial_F" || _name == "O_CargoNet_01_ammo_F") then {
        clearItemCargoGlobal _obj;
        _obj addAction ["<t color='#7F0000'>Уничтожить ящик</t>","mission\main\actions\destroyCargo.sqf",[],21,true,true,"","", 5]; 
    };
    _obj setDir _objDir;
    if (count _deltaCoords > 0) then {
        _cargoPos = getPosASL _cargo;
        _pos = [(_cargoPos select 0) + (_deltaCoords select 0), (_cargoPos select 1) + (_deltaCoords select 1), (_cargoPos select 2) + (_deltaCoords select 2)];
        _obj setPosASL _pos;
    } else {
        _obj setPos _pos;
    };
    if (_name == "Land_Cargo_HQ_V4_F") then {
        _cargo = _obj;
        _cargo addEventHandler ["HandleDamage", {0}];
        _cargo addMPEventHandler ["MPKilled", {MAIN_AO_SUCCESS = true; publicVariable "MAIN_AO_SUCCESS";}];
    };
    if (_name == "Land_DataTerminal_01_F") then {
        _obj addEventHandler ["HandleDamage", {0}];
        _obj addMPEventHandler ["MPKilled", {MAIN_AO_SUCCESS = true; publicVariable "MAIN_AO_SUCCESS";}];
        [_obj, "red", "orange", "green"] call BIS_fnc_DataTerminalColor;
        [_obj, 3] call BIS_fnc_dataTerminalAnimate;
        [_obj, "QS_fnc_addActionTakeControl", nil, true] spawn BIS_fnc_MP; // add terminal action
    };
    _obj allowDamage _damage;
    _obj enableSimulation _simulation;
    if !(_name in _objects) then {
        _objects set [count _objects, _name];
    };
} forEach _composition;
sleep 2;
_objects
