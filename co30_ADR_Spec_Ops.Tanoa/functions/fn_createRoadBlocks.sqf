/*
Author: ToxaBes
Description: create road blocks
Format: [_centerPos, _distance] call QS_fnc_createRoadBlocks;
*/
if (!isServer) exitWith {};
_centerPos = _this select 0;
_distance = _this select 1;
_compositions = [
    [
        ["Land_BarGate_F",[3.36719,-1.0625,0],0,1,0,[0,0],"","",true,false], 
        ["Land_BagFence_Long_F",[-5.33594,-3.44141,-0.000999928],270,1,0,[0,0],"","",true,false], 
        ["Land_PortableLight_double_F",[-6.02734,-4.01758,0],330.571,1,0,[0,0],"","",true,false], 
        ["Land_HBarrier_Big_F",[7.21289,2.22852,0],270,1,0,[0,0],"","",true,false], 
        ["Land_BagFence_Short_F",[-6.06055,-4.81445,-0.0010004],180,1,0,[0,0],"","",true,false], 
        ["Land_LampShabby_F",[7.60352,-5.00977,-2.41369],315,1,0,[0,0],"","",true,false], 
        ["Land_HBarrier_3_F",[-7.46875,-5.07422,0],90,1,0,[0,-0],"","",true,false], 
        ["Land_HBarrier_Big_F",[-9.65234,3.59766,0],90,1,0,[0,-0],"","",true,false], 
        ["Land_BagFence_Short_F",[-6.94727,-8.69727,-0.0010004],270,1,0,[0,0],"","",true,false], 
        ["Land_PaperBox_open_empty_F",[-11.1953,-1.5625,0],90,1,0,[0,-0],"","",true,false], 
        ["Land_HBarrier_Big_F",[7.72266,-8.15234,0],90,1,0,[0,-0],"","",true,false], 
        ["Land_Razorwire_F",[-5.92578,-8.0293,-2.86102e-006],90,1,0,[0,-0],"","",true,false], 
        ["Land_Cargo_House_V4_F",[11.3945,-0.195313,0],0,1,0,[0,0],"","",true,false], 
        ["Land_Razorwire_F",[5.99609,-8.08398,-2.86102e-006],90,1,0,[0,-0],"","",true,false], 
        ["CamoNet_ghex_open_F",[12.248,0.457031,0.457188],270,1,0,[0,0],"","",true,false], 
        ["Land_BagFence_Long_F",[-8.31641,-9.57813,-0.000999928],180,1,0,[0,0],"","",true,false], 
        ["CamoNet_ghex_open_F",[-10.9551,-5.83789,0],270,1,0,[0,0],"","",true,false], 
        ["Land_HBarrier_Big_F",[12.3828,4.46289,0],1.36604e-005,1,0,[0,0],"","",true,false], 
        ["Land_HBarrier_3_F",[-11.5586,8.28906,0],0,1,0,[0,0],"","",true,false], 
        ["Land_Pallet_vertical_F",[-13.3301,-1.04102,0.000250816],0.000395129,1,0,[-0.119279,0.00428207],"","",true,false], 
        ["Land_Sacks_heap_F",[12.9297,-5.5625,0],285,1,0,[0,0],"","",true,false], 
        ["Land_HBarrier_Big_F",[-14.6602,0.394531,0],180,1,0,[0,0],"","",true,false], 
        ["Land_HBarrier_3_F",[-12.832,-5.41406,0],180,1,0,[0,0],"","",true,false], 
        ["Land_Cargo_Patrol_V4_F",[-13.8203,3.19141,0],0,1,0,[0,0],"","",true,false], 
        ["Land_BagBunker_01_small_green_F",[-11.3184,-10.9922,0],0,1,0,[0,0],"","",true,false], 
        ["Land_Cargo_Patrol_V4_F",[12.0527,-10.0586,0],0,1,0,[0,0],"","",true,false], 
        ["O_HMG_01_high_F",[-11.5703,-11.1875,-0.0871162],180,1,0,[-3.89538e-005,-0.000566959],"","",true,false], 
        ["Land_PaperBox_open_full_F",[14.0547,-8.07227,0],0,1,0,[0,0],"","",true,false], 
        ["Land_HBarrier_Big_F",[16.2363,-0.941406,0],270,1,0,[0,0],"","",true,false], 
        ["Land_HBarrier_Big_F",[11.3398,-12.8555,0],180,1,0,[0,0],"","",true,false], 
        ["Land_LampShabby_F",[-17.0215,-0.873047,0],120.013,1,0,[0,-0],"","",true,false], 
        ["Land_BagFence_Long_F",[-14.4492,-9.54688,-0.000999928],0,1,0,[0,0],"","",true,false], 
        ["Land_HBarrier_3_F",[-16.1719,-7.42578,0],270,1,0,[0,0],"","",true,false], 
        ["Land_HBarrier_3_F",[-16.7754,8.23438,0],0,1,0,[0,0],"","",true,false], 
        ["Land_Razorwire_F",[-9.85742,-13.6309,-0.500003],180,1,0,[0,0],"","",true,false], 
        ["Land_BagFence_Short_F",[-15.8223,-8.82227,-0.0010004],270,1,0,[0,0],"","",true,false], 
        ["Land_HBarrier_Big_F",[-18.2773,5.09766,0],90,1,0,[0,-0],"","",true,false], 
        ["Land_HBarrier_Big_F",[16.418,-9.53711,0],90,1,0,[0,-0],"","",true,false], 
        ["Land_Razorwire_F",[13.7832,-15.0059,-2.86102e-006],180,1,0,[0,0],"","",true,false]
    ],
    [
        ["Land_BarGate_F",[3.16992,-1.06641,0],0,1,0,[0,0],"","",true,false], 
        ["Land_Concrete_SmallWall_8m_F",[-6.18945,0.201172,0],270,1,0,[0,0],"","",true,false], 
        ["Land_PortableLight_double_F",[-6.69141,-1.84961,0],337.147,1,0,[0,0],"","",true,false], 
        ["Land_Concrete_SmallWall_4m_F",[7.04297,-1.05664,0],0,1,0,[0,0],"","",true,false], 
        ["Land_HBarrier_3_F",[6.48438,2.32031,0],270,1,0,[0,0],"","",true,false], 
        ["Land_Concrete_SmallWall_8m_F",[5.31055,-5.17383,0],270,1,0,[0,0],"","",true,false], 
        ["Land_Razorwire_F",[6.73438,-7.64648,-2.86102e-006],270,1,0,[0,0],"","",true,false], 
        ["O_T_MRAP_02_hmg_ghex_F",[-8.87695,0.808594,0.00744724],175.289,1,0,[0.0271918,0.00619559],"","",true,false], 
        ["Land_HBarrier_5_F",[-11.4473,-3.04688,0],0,1,0,[0,0],"","",true,false], 
        ["Land_Razorwire_F",[-8.7207,-4.60938,-2.86102e-006],180,1,0,[0,0],"","",true,false], 
        ["Land_HBarrier_Big_F",[9.98633,6.36719,0],180,1,0,[0,0],"","",true,false], 
        ["Land_Concrete_SmallWall_4m_F",[5.31445,-11.1738,0],270,1,0,[0,0],"","",true,false], 
        ["Land_HBarrier_Big_F",[-13.1172,0.296875,0],270,1,0,[0,0],"","",true,false], 
        ["Land_BagBunker_01_large_green_F",[12.1719,-5.86914,0],0,1,0,[0,0],"","",true,false], 
        ["Land_HBarrier_3_F",[-12.1777,6.73047,0],112.044,1,0,[0,-0],"","",true,false], 
        ["Land_HBarrier_Big_F",[15.3809,3.23828,0],90,1,0,[0,-0],"","",true,false], 
        ["Land_LampShabby_F",[15.627,-1.19922,-2.06135],277.404,1,0,[0,0],"","",true,false], 
        ["Land_Razorwire_F",[13.5293,-11.3613,-2.86102e-006],180,1,0,[0,0],"","",true,false], 
        ["Land_Razorwire_F",[17.2441,-4.31445,-2.86102e-006],90,1,0,[0,-0],"","",true,false]
    ],
    [
        ["Land_BarGate_F",[3.29883,-1.04883,0],0,1,0,[0,0],"","",true,false], 
        ["Land_BagFence_Long_F",[5.37695,-2.54492,-0.000999928],90,1,0,[0,-0],"","",true,false], 
        ["RoadCone_F",[3.73633,-5.54883,8.34465e-006],135.002,1,0.00991947,[0.00177839,0.00350376],"","",true,false], 
        ["Land_CncShelter_F",[-6.64258,0.191406,0],90,1,0,[0,-0],"","",true,false], 
        ["RoadCone_F",[3.98633,5.70117,8.58307e-006],270.006,1,0.00993525,[0.00203093,0.0038358],"","",true,false], 
        ["Land_CncBarrierMedium_F",[-6.74609,-1.92383,0],90,1,0,[0,-0],"","",true,false], 
        ["RoadCone_F",[-4.51367,5.57617,8.10623e-006],60.0085,1,0.00992696,[0.00198824,0.00383677],"","",true,false], 
        ["Land_CncBarrierMedium_F",[-6.87109,2.20117,0],90,1,0,[0,-0],"","",true,false], 
        ["Land_PortableLight_double_F",[5.45898,-4.68164,0],29.6037,1,0,[0,0],"","",true,false], 
        ["RoadCone_F",[-4.76367,-5.67383,8.82149e-006],359.999,1,0.009933,[0.00215512,0.00384164],"","",true,false], 
        ["Land_CncBarrierMedium_F",[-6.74609,-3.79883,0],90,1,0,[0,-0],"","",true,false], 
        ["Land_BagFence_Long_F",[6.86523,-4.06445,-0.000999928],180,1,0,[0,0],"","",true,false], 
        ["Land_MetalBarrel_F",[-7.79102,-1.67578,-0.0124605],164.344,1,0.00747152,[1.08907,2.6118],"","",true,false], 
        ["Land_MetalBarrel_F",[-7.79883,-2.42383,-0.0110228],359.965,1,0.00757471,[0.0405022,-3.01646],"","",true,false], 
        ["RoadCone_F",[3.98633,7.95117,8.34465e-006],90.0064,1,0.00993528,[0.00205179,0.00385029],"","",true,false], 
        ["RoadCone_F",[-4.51367,7.82617,8.10623e-006],225.002,1,0.00992746,[0.00202001,0.0039472],"","",true,false], 
        ["RoadCone_F",[3.86133,-8.17383,8.34465e-006],90.0064,1,0.00993528,[0.00205182,0.00385031],"","",true,false], 
        ["Land_Razorwire_F",[5.30273,9.42969,-2.86102e-006],90,1,0,[0,-0],"","",true,false], 
        ["Land_Razorwire_F",[-5.94727,8.92969,-2.86102e-006],90,1,0,[0,-0],"","",true,false], 
        ["RoadCone_F",[-4.63867,-8.29883,8.10623e-006],225.002,1,0.00990266,[0.000950213,0.0027231],"","",true,false], 
        ["Land_BagFence_Short_F",[8.36328,-4.78906,-0.0010004],90,1,0,[0,-0],"","",true,false], 
        ["Land_Razorwire_F",[5.17773,-6.69531,-2.86102e-006],90,1,0,[0,-0],"","",true,false], 
        ["Land_Pallet_MilBoxes_F",[-10.0156,1.58594,0],180,1,0,[0,0],"","",true,false], 
        ["CamoNet_ghex_F",[-9.93945,-0.775391,0],90,1,0,[0,-0],"","",true,false], 
        ["Land_WoodenBox_F",[10.6992,0.640625,0.0117681],192.874,1,0,[-7.61159,-0.009788],"","",true,false], 
        ["Land_Razorwire_F",[-6.07227,-7.19531,-2.86102e-006],90,1,0,[0,-0],"","",true,false], 
        ["Land_CncBarrierMedium4_F",[-10.5371,3.09375,0],0,1,0,[0,0],"","",true,false], 
        ["RoadCone_F",[3.86133,-10.4238,8.58307e-006],270.006,1,0.00993525,[0.00203094,0.00383575],"","",true,false], 
        ["RoadCone_F",[3.86133,10.5762,8.10623e-006],135.002,1,0.00993569,[0.00200232,0.00391667],"","",true,false], 
        ["CamoNet_ghex_F",[11.2129,-0.0996094,0],0,1,0,[0,0],"","",true,false], 
        ["RoadCone_F",[-4.63867,10.4512,7.39098e-006],359.999,1,0.00989461,[0.0009568,0.00239872],"","",true,false], 
        ["Land_CncBarrierMedium4_F",[-10.3652,-4.81641,0],180,1,0,[0,0],"","",true,false], 
        ["RoadCone_F",[-4.63867,-10.5488,8.10623e-006],60.0085,1,0.00993546,[0.00196073,0.00382614],"","",true,false], 
        ["Land_CncBarrierMedium4_F",[11.3379,1.84375,0],0,1,0,[0,0],"","",true,false], 
        ["Land_Razorwire_F",[9.50781,3.64258,-2.86102e-006],0,1,0,[0,0],"","",true,false], 
        ["Land_WaterTank_F",[-11.5137,-3.45117,0.0122089],0.0291982,1,0,[-1.20555,-0.00415601],"","",true,false], 
        ["Land_BagBunker_01_small_green_F",[10.2363,-6.85352,0],0,1,0,[0,0],"","",true,false], 
        ["O_GMG_01_high_F",[9.98633,-7.03711,-0.111811],179.989,1,0,[-0.000254347,5.02569e-005],"","",true,false], 
        ["Land_PaperBox_open_empty_F",[12.6465,0.232422,0],90,1,0,[0,-0],"","",true,false], 
        ["Land_BagFence_Short_F",[12.1133,-4.91406,-0.0010004],90,1,0,[0,-0],"","",true,false], 
        ["Land_BarrelTrash_grey_F",[13.9316,0.638672,5.81741e-005],359.967,1,0,[-0.0128459,-0.013693],"","",true,false], 
        ["Land_BagFence_Long_F",[13.6152,-4.06445,-0.000999928],180,1,0,[0,0],"","",true,false], 
        ["Land_CncBarrierMedium4_F",[-14.4961,-0.775391,0],90,1,0,[0,-0],"","",true,false], 
        ["Land_BagFence_Long_F",[15.0957,0.197266,-0.000999928],270,1,0,[0,0],"","",true,false], 
        ["Land_BagFence_Long_F",[15.0957,-2.67773,-0.000999928],270,1,0,[0,0],"","",true,false]
    ],
    [
        ["Land_BarGate_F",[3.54688,-0.335938,0],0,1,0,[0,0],"","",true,false], 
        ["RoadCone_F",[-4.14063,-2.46094,8.10623e-006],135.002,1,0.00993567,[0.00200232,0.00391667],"","",true,false], 
        ["RoadCone_F",[-4.26563,2.28906,8.10623e-006],135.002,1,0.00993567,[0.00200232,0.00391667],"","",true,false], 
        ["Land_BagFence_Short_F",[4.35742,-2.4707,-0.0010004],270,1,0,[0,0],"","",true,false], 
        ["Land_BagFence_Short_F",[5.24414,1.53711,-0.0010004],180,1,0,[0,0],"","",true,false], 
        ["Land_BagFence_Short_F",[5.09961,-3.33398,-0.0010004],1.36604e-005,1,0,[0,0],"","",true,false], 
        ["RoadCone_F",[-4.26563,4.66406,8.10623e-006],135.002,1,0.00993565,[0.00200232,0.00391667],"","",true,false], 
        ["RoadCone_F",[-4.14063,-5.08594,8.10623e-006],135.002,1,0.00993567,[0.00200235,0.00391669],"","",true,false], 
        ["Land_BagFence_Long_F",[5.96875,3.03516,-0.000999928],270,1,0,[0,0],"","",true,false], 
        ["Land_BagFence_Long_F",[5.96875,-4.71484,-0.000999928],270,1,0,[0,0],"","",true,false], 
        ["Land_Razorwire_F",[-6.58203,2.43555,-2.86102e-006],270,1,0,[0,0],"","",true,false], 
        ["Land_Razorwire_F",[-6.58203,-6.18945,-2.86102e-006],270,1,0,[0,0],"","",true,false], 
        ["RoadCone_F",[-4.14063,7.28906,8.10623e-006],135.002,1,0.00992593,[0.0019915,0.00391338],"","",true,false], 
        ["Land_BagFence_Long_F",[7.36328,4.39844,-0.000999928],180,1,0,[0,0],"","",true,false], 
        ["RoadCone_F",[-4.14063,-7.58594,8.10623e-006],135.002,1,0.00993567,[0.00200235,0.00391669],"","",true,false], 
        ["CamoNet_ghex_F",[9.43359,-1.8125,0],90,1,0,[0,-0],"","",true,false], 
        ["Land_BagFence_Long_F",[6,-7.45703,-0.000999928],90,1,0,[0,-0],"","",true,false], 
        ["Land_BagFence_Long_F",[10.1055,4.42969,-0.000999928],0,1,0,[0,0],"","",true,false], 
        ["Land_PaperBox_open_empty_F",[10.9844,-2.71094,0],0,1,0,[0,0],"","",true,false], 
        ["Land_Pallet_MilBoxes_F",[11.5898,-0.908203,0],30,1,0,[0,0],"","",true,false], 
        ["Land_BagFence_Long_F",[7.36328,-8.97656,-0.000999928],180,1,0,[0,0],"","",true,false], 
        ["Land_BagFence_Long_F",[11.5,3.04297,-0.000999928],90,1,0,[0,-0],"","",true,false], 
        ["Land_BagFence_Short_F",[9.59961,-8.95898,-0.0010004],1.36604e-005,1,0,[0,0],"","",true,false], 
        ["Land_Razorwire_F",[13.291,-3.68945,-2.86102e-006],270,1,0,[0,0],"","",true,false]
    ]
];

_newObjs = [];
_multiplyMatrixFunc =
{
    private ["_array1", "_array2", "_result"];
    _array1 = _this select 0;
    _array2 = _this select 1;
    _result = [
        (((_array1 select 0) select 0) * (_array2 select 0)) + (((_array1 select 0) select 1) * (_array2 select 1)),
        (((_array1 select 1) select 0) * (_array2 select 0)) + (((_array1 select 1) select 1) * (_array2 select 1))
    ];
    _result
};
_dir = 0;
_selRoads = [];
while {_dir < 360} do {
    _relPos = [_centerPos, _distance, _dir] call BIS_fnc_relPos;
    _roads = _relPos nearRoads 100;
    {
        if ((getPos _x) isFlatEmpty [25, -1, -1, -1, -1] isEqualTo []) then {
            _selRoads pushBack _x;
        };
    } forEach _roads;
    _dir = _dir + 24;
};
_roadPoses = [];
_cnt = selectRandom [2,3,4,5];
{
    if ((count _roadPoses) < _cnt) then {
        _selRoad = _x;
        _allowed = true;
        {
            if (_selRoad distance2D _x < 300) then {
                _allowed = false;
            };
        } forEach _roadPoses;
        if (_allowed) then {
            _roadPoses pushBack _selRoad;
        };
    };    
} forEach _selRoads;
{            
    //_markerNameA = format["mkr_%1", random 100000];
    //_markerA = createMarker[_markerNameA, getPos _x];
    //_markerA setMarkercolor "colorRed";
    //_markerA setMarkerSize [1,1];
    //_markerA setMarkerType "Mil_dot";
    _pos = getPos _x;
    if (format ["%1", _pos] != "[0,0,0]") then {
        _relAzi = [_centerPos, _pos] call BIS_fnc_dirTo;
        _roadConnectedTo = roadsConnectedTo _x;
        _connectedRoad = _roadConnectedTo select 0;
        _azi = [_x, _connectedRoad] call BIS_fnc_DirTo;
        _delta = _relAzi - _azi;
        if (_delta < -360) then {
            _delta = _delta + 360;
        };
        if (_delta < 0) then {            
            _delta = -_delta;
        };
        if (_delta <= 90) then {
            _azi = _azi + 180;
        };
        _objs = selectRandom _compositions;    
        _posX = _pos select 0;
        _posY = _pos select 1;
        _unitGroup = createGroup east;
        {       
            _type = _x select 0;
            _relPos = _x select 1;
            _azimuth = _x select 2;
            if ((count _x) > 3) then {_fuel = _x select 3};
            if ((count _x) > 4) then {_damage = _x select 4};
            if ((count _x) > 5) then {_orientation = _x select 5};
            if ((count _x) > 6) then {_varName = _x select 6};
            if ((count _x) > 7) then {_init = _x select 7};
            if ((count _x) > 8) then {_simulation = _x select 8};
            if ((count _x) > 9) then {_ASL = _x select 9};
            private ["_rotMatrix", "_newRelPos", "_newPos"];
            _rotMatrix =
            [
                [cos _azi, sin _azi],
                [-(sin _azi), cos _azi]
            ];
            _newRelPos = [_rotMatrix, _relPos] call _multiplyMatrixFunc;    
            private ["_z"];
            if ((count _relPos) > 2) then {_z = _relPos select 2} else {_z = 0};
            _newPos = [_posX + (_newRelPos select 0), _posY + (_newRelPos select 1), _z];
            _newObj = _type createVehicle _newPos;
            _newObj setDir (_azi + _azimuth);
            _newObj setPos _newPos;     
            if (!isNil "_fuel") then {_newObj setFuel _fuel};
            if (!isNil "_damage") then {_newObj setDamage _damage;};
            if (!isNil "_orientation") then 
            {
                if ((count _orientation) > 0) then 
                {
                    ([_newObj] + _orientation) call BIS_fnc_setPitchBank;
                };
            };
            if (!isNil "_varName") then 
            {
                if (_varName != "") then 
                {
                    _newObj setVehicleVarName _varName;
                    call (compile (_varName + " = _newObj;"));
                };
            };
            if (!isNil "_init") then {_newObj call (compile ("this = _this; " + _init));};
            if (!isNil "_simulation") then {_newObj enableSimulation _simulation; _newObj setVariable ["BIS_DynO_simulation", _simulation];};
        
            if (typeOf _newObj in ["O_HMG_01_high_F","O_GMG_01_high_F","O_static_AT_F"]) then {
                "O_T_Support_MG_F" createUnit [[0,0,0], _unitGroup, "currentGunner = this", 0, (selectRandom ["CAPTAIN","MAJOR","COLONEL"])];
                currentGunner assignAsGunner _newObj;
                currentGunner moveInGunner _newObj;            
                _newObjs = _newObjs + [currentGunner];
            };
            if (typeOf _newObj in ["O_T_MRAP_02_hmg_ghex_F"]) then {
                "O_T_Engineer_F" createUnit [[0,0,0], _unitGroup, "currentGunner = this", 0, (selectRandom ["CAPTAIN","MAJOR","COLONEL"])];
                currentGunner assignAsGunner _newObj;
                currentGunner moveInGunner _newObj;            
                _newObjs = _newObjs + [currentGunner];
            };
            if (typeOf _newObj in ["Land_BagBunker_01_large_green_F"]) then {
                _pos1 = [_newPos, 0, 6, 1, 0, 10] call QS_fnc_findSafePos;
                "O_T_Soldier_AAR_F" createUnit [_pos1, _unitGroup, "", 0, (selectRandom ["CAPTAIN","MAJOR","COLONEL"])];
            };
            _newObjs = _newObjs + [_newObj];
        } forEach _objs;    
        _bunkerGroup = [_pos, 30, 5, east] call QS_fnc_FillBots;
        _newObjs = _newObjs + [_bunkerGroup];
        _cargoPostGroups = [_pos, 30, east] call QS_fnc_FillCargoPatrol;  
        {
            _newObjs = _newObjs + [_x];
        } forEach _cargoPostGroups;                    
        _pos2 = [_pos, 0, 5, 1, 0, 10] call QS_fnc_findSafePos;
        "O_T_Soldier_AAA_F" createUnit [_pos2, _unitGroup, "", 0, (selectRandom ["CAPTAIN","MAJOR","COLONEL"])];
        _pos3 = [_pos, 0, 12, 1, 0, 10] call QS_fnc_findSafePos;
        "O_T_Soldier_AAT_F" createUnit [_pos3, _unitGroup, "", 0, (selectRandom ["CAPTAIN","MAJOR","COLONEL"])];
        _unitGroup setBehaviour "COMBAT";
        _unitGroup setCombatMode "RED";
        [(units _unitGroup)] call QS_fnc_setSkill4;   
        _newObjs = _newObjs + [_unitGroup];
    };
} forEach _roadPoses;

_newObjs