/*
Author: ToxaBes
Description: add furniture to given tower
Format: [position, add action to terminal] call QS_fnc_addFurniture;
*/
if (!isServer) exitWith {};
_hq = _this select 0;
_inMain = _this select 1;
_hqPos = getPosASL _hq;
_hqDir = getDir _hq;
_terminalPosition = selectRandom [13,14,15,16];
_terminalPos = _hq buildingPos _terminalPosition;
_terminalPos = [_terminalPos select 0, _terminalPos select 1, (_terminalPos select 2) - 0.5];
_terminal = createVehicle ["Land_DataTerminal_01_F", [0,0,0], [], 0, "NONE"];
_terminal setVariable ["BIS_enableRandomization", false];
_terminal allowDamage false;
_terminal setPosATL _terminalPos;
_terminalDir = [_terminal, _hq] call BIS_fnc_dirTo;
_terminal setDir (_terminalDir + 180);
[_terminal, "red", "orange", "green"] call BIS_fnc_DataTerminalColor;
[_terminal, 3] call BIS_fnc_dataTerminalAnimate;
_terminal addEventHandler ["HandleDamage", {0}];
if (_inMain) then {
    _terminal addMPEventHandler ["MPKilled", {MAIN_AO_SUCCESS = true; publicVariable "MAIN_AO_SUCCESS";}];

    // add terminal action
    [_terminal, "QS_fnc_addActionTakeControl", nil, true] spawn BIS_fnc_MP;
};
_positions = [
    ["MapBoard_altis_F",-5,-4,12.8,220],
    ["Land_PressureWasher_01_F",5,4,12.8,40],
    ["MapBoard_seismic_F",-5,3.8,12.8,300],
    ["Land_CampingTable_F",-5.2,-0.7,12.8,90],
    ["Land_PCSet_01_screen_F",-5.4,-1.2,13.62,270],
    ["Land_PCSet_01_keyboard_F",-5,-1.25,13.62,270],
    ["Land_PCSet_01_mouse_F",-5.1,-0.92,13.62,270],
    ["Land_PCSet_01_case_F",-5.2,-0.6,13.62,270],
    ["Land_OfficeChair_01_F",-4.2,-1.1,12.8,90],
    ["Land_CampingTable_F",-5.2,1.5,12.8,90],
    ["Land_SatellitePhone_F",-5,0.95,13.62,270],
    ["Land_Tablet_02_F",-5.1,1.8,13.62,100],
    ["Land_OfficeChair_01_F",-4.2,1.1,12.8,90],
    ["Land_CampingTable_small_F",-0.5,1,12.8,270],
    ["Box_T_East_WpsSpecial_F",2,-3.8,12.75,0],
    ["Land_EngineCrane_01_F",4,3,15.35,45],
    ["O_CargoNet_01_ammo_F",3.25,2.25,15.35,45],
    ["Land_Pallet_MilBoxes_F",-2,2.2,15.35,180],
    ["Land_CampingTable_F",-1.7,-6,15.5,0],
    ["Land_CampingTable_F",-4,-6,15.5,0],
    ["Land_OfficeChair_01_F",-1.2,-5,15.5,0],
    ["Land_OfficeChair_01_F",-3.6,-5,15.5,0],
    ["Land_Laptop_unfolded_F",-1.2,-5.9,16.3,0],
    ["Land_Document_01_F",-2.3,-5.8,16.35,180],
    ["Land_Laptop_device_F",-3.4,-5.9,16.3,0],
    ["Land_File_research_F",-4.6,-5.9,16.35,180]
];
{
    _name = _x select 0;
    _newPos = [(_hqPos select 0) + (_x select 1), (_hqPos select 1) + (_x select 2), (_hqPos select 2) + (_x select 3)];
    _newDir = _hqDir + (_x select 4);
    _obj = createVehicle [_name, [0,0,0], [], 0, "NONE"];
    _obj setVariable ["BIS_enableRandomization", false];
    _obj setPosASL _newPos;
    _obj setDir _newDir;
    _obj enableSimulation false;
    _obj allowDamage false;
    if (_name == "Box_T_East_WpsSpecial_F" || _name == "O_CargoNet_01_ammo_F") then {
        clearItemCargoGlobal _obj;
        [_obj, "QS_fnc_addActionDestroy", nil, true] spawn BIS_fnc_MP;
        if (_name == "O_CargoNet_01_ammo_F") then {
            _obj addWeaponCargoGlobal ["arifle_ARX_hex_F", 2];
            _obj addWeaponCargoGlobal ["arifle_ARX_ghex_F", 2];
            _obj addWeaponCargoGlobal ["arifle_ARX_blk_F", 2];
            _obj addWeaponCargoGlobal ["arifle_CTARS_blk_F", 2];
            _obj addWeaponCargoGlobal ["arifle_CTAR_blk_F", 4];
            _obj addWeaponCargoGlobal ["arifle_CTAR_GL_blk_F", 2];
            _obj addWeaponCargoGlobal ["launch_RPG32_ghex_F", 2];
            _obj addMagazineCargoGlobal ["30Rnd_65x39_caseless_green", 20];
            _obj addMagazineCargoGlobal ["30Rnd_65x39_caseless_green_mag_Tracer", 20];
            _obj addMagazineCargoGlobal ["10Rnd_50BW_Mag_F", 10];
            _obj addMagazineCargoGlobal ["100Rnd_580x42_Mag_F", 5];
            _obj addMagazineCargoGlobal ["100Rnd_580x42_Mag_Tracer_F", 5];
            _obj addMagazineCargoGlobal ["30Rnd_580x42_Mag_F", 20];
            _obj addMagazineCargoGlobal ["30Rnd_580x42_Mag_Tracer_F", 20];
        };
    };
} forEach _positions;

_bunkerObjects = [
    "MapBoard_altis_F","Land_PressureWasher_01_F","MapBoard_seismic_F","Land_CampingTable_F","Land_PCSet_01_screen_F","Land_PCSet_01_keyboard_F",
    "Land_PCSet_01_mouse_F","Land_PCSet_01_case_F","Land_OfficeChair_01_F","Land_SatellitePhone_F","Land_Tablet_02_F","Land_CampingTable_small_F",
    "Box_T_East_WpsSpecial_F","Land_EngineCrane_01_F","O_CargoNet_01_ammo_F","Land_Pallet_MilBoxes_F","Land_Laptop_unfolded_F","Land_Document_01_F",
    "Land_Laptop_device_F","Land_File_research_F","Land_DataTerminal_01_F","Land_Cargo_Tower_V1_F","Land_HBarrier_3_F","Land_HBarrierBig_F",
    "Land_PortableLight_double_F","Land_Razorwire_F","Land_Pallets_stack_F","Land_PaperBox_closed_F","Land_WaterTank_F","Land_Pallets_stack_F",
    "Land_ToiletBox_F","Land_HBarrier_5_F"
];

_bunkerObjects
