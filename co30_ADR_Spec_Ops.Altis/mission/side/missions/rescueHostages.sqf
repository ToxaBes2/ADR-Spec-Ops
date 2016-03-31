/*
Author:	ToxaBes
Description: Secure area and rescue the hostages.
*/

// define some keywords
#define INFANTRY_MISSION "Спецоперация: Заложники (техника запрещена)"
#define OUR_SIDE WEST
#define ENEMY_SIDE EAST
#define INFANTRY_HOSTAGES "C_man_1_3_F","C_man_polo_1_F_afro","C_man_polo_2_F_euro"
#define INFANTRY_SUPPORT "O_G_Soldier_AR_F","O_Soldier_AR_F"
#define INFANTRY_PATROL "OIA_GuardTeam","OI_reconPatrol","OIA_InfTeam","OIA_InfTeam_AA","OIA_InfTeam_AT"
#define INFANTRY_STATIC "O_HMG_01_high_F","O_GMG_01_high_F"
#define INFANTRY_HOUSE "O_Soldier_AR_F","O_soldier_M_F","O_Soldier_TL_F","O_G_Soldier_AR_F","O_G_Soldier_lite_F","O_G_Soldier_M_F", "O_recon_LAT_F", "O_recon_medic_F", "O_recon_JTAC_F"
#define INFANTRY_SNIPERS "O_ghillie_lsh_F", "O_ghillie_ard_F", "O_recon_exp_F", "O_G_Soldier_M_F", "O_sniper_F"
#define INFANTRY_GUNNERS "O_support_MG_F", "O_support_GMG_F", "O_support_AMG_F"
#define INFANTRY_OFFICER "O_officer_F", "O_G_officer_F"

// define all priviate variables
private ["_targets","_accepted","_distance","_briefing","_position","_city","_flatPos","_heliCoords","_mkrScout","_z","_fullyRandom","_heliObj",
         "_heliPos","_azimut","_x","_c","_ps","_chemPosRed","_chemlightRed","_houseList","_randNum","_scoutPos","_scoutBox","_chemPosBlue","_goodPos",
         "_dummy","_showGetdataMessage","_showSabotageMessage","_inHouse","_enemiesArray","_randomPos","_patrolGroup","_nearRoads","_roadSegment",
         "_direction","_x","_staticGroup","_static","_houseGroup","_houseUnit","_technicalGroup","_technicalVehicle","_sniperGroup","_startPoint"];

_enemiesArray = [grpNull];

// Thanks KK for fastest shuffle alghoritm
KK_fnc_arrayShufflePlus = {
    private ["_arr","_cnt"];
    _arr = _this select 0;
    _cnt = count _arr;
    for "_i" from 1 to (_this select 1) do {
        _arr pushBack (_arr deleteAt floor random _cnt);
    };
    _arr
};

// format: [city name,    [coords x,y]]
_targets = [
    ["Ореокастро",        [4549.12,21415.7]],
    ["Крия-Нера",         [9705.16,22267.7]],
    ["Фрини",             [14607.8,20773.2]],
    ["Атира",             [14020,18720]],
    ["Галати",            [10311,19070]],
    ["Абдера",            [9423,20223]],
    ["Сирта",             [8583.91,18270]],
    ["Айос-Константинос", [3844,17696]],
    ["Айос-Константинос", [4239,16946]],
    ["Негадес",           [4873.59,16148]],
    ["Коре",              [7109.11,16436.2]],
    ["Айос-Дионисиос",    [9283.31,15856.3]],
    ["Лакка",             [12328.6,15681.4]],
    ["Неохори",           [12523.7,14378.8]],
    ["Аликампос",         [11132.3,14560.6]],
    ["Стройка",           [11380.6,14178.2]],
    ["Каталаки",          [11759.9,13702.4]],
    ["Полиакко",          [10977.8,13432.1]],
    ["Териса",            [10680.5,12271.3]],
    ["Зарос",             [9050,11977]],
    ["Панохори",          [5090,11262]],
    ["Атанос",            [3685.56,10236.7]],
    ["Нери",              [3710.22,11630.3]],
    ["Нери",              [4152,11745.9]],
    ["Кавала",            [3612.34,13024]],
    ["Кавала",            [3659.82,13439.3]],
    ["Аггелохори",        [3869.5,13742.1]],
    ["Антракия",          [16645,16163]],
    ["Родополи",          [18813.8,16609.3]],
    ["Харкия",            [18109.8,15241.1]],
    ["Калохори",          [21365,16347]],
    ["Парос",             [20931.3,16934]],
    ["Иоанина",           [23187.5,19966.4]],
    ["София",             [25710,21363.4]],
    ["Молос",             [27013.7,23224.3]],
    ["Дорида",            [19404,13247.3]],
    ["Пиргос",            [16738.7,12796]],
    ["Халкея",            [20251.8,11677.5]],
    ["Ферес",             [21695.2,7597.3]],
    ["Селекано",          [20790.9,6740.9]]
];

// select correct place for mission
if (PARAMS_AO == 1) then {
    _accepted = false;
    while {!_accepted} do {    
        _position = _targets call BIS_fnc_selectRandom;
        _flatPos  = _position select 1;  
        _distance = [_flatPos, getMarkerPos currentAO] call BIS_fnc_distance2D;
        if (_distance > 3000) then {
            _distance = [_flatPos, getMarkerPos "priorityMarker"] call BIS_fnc_distance2D;
            if (_distance > 1500) then {
                _accepted = true;
            };  
        };
        sleep 5;
    };
} else {
    _position = _targets call BIS_fnc_selectRandom;
    _flatPos  = _position select 1;
};

// set zone area
_startPoint = [(_flatPos select 0),(_flatPos select 1),1];
{ _x setMarkerPos _flatPos; } forEach ["sideMarker", "sideCircle"];
"sideCircle" setMarkerSize [200, 200]; publicVariable "sideCircle";
sideMarkerText = [INFANTRY_MISSION, true]; publicVariable "sideMarkerText";
"sideMarker" setMarkerText INFANTRY_MISSION; publicVariable "sideMarker";

// set razorwire circles and mines
// _pos1, _pos2, _pos3, _sign1, _sign2, _sign3,_pos, _meters
_unitsArray = [];
_minesArray = [];
_dir1 = 180;
_dir2 = 180;
_dir3 = 180;
_dir4 = 180;
for "_c" from 0 to 109 do {
    _pos1 = [_startPoint, 180, _dir1] call BIS_fnc_relPos;
    _sign1 = createVehicle ["Land_Razorwire_F", [70,70,70], [], 0, "CAN_COLLIDE"];
    waitUntil {alive _sign1};     
    _sign1 allowDamage false;    
    _sign1 setDir _dir1;
    _sign1 setPos [_pos1 select 0, _pos1 select 1, 0];    
    _sign1 setVectorUp (surfaceNormal (getPosATL _sign1));
    _pos = getPosATL _sign1; 
    if (_pos select 2 > 0.2) then {
        _pos = [_pos select 0, _pos select 1, 0];
        _sign1 setPosATL _pos;
    };
    if ((random 10) > 1) then {
        _minePos = [_startPoint, 179.8, (_dir1 + 2.2)] call BIS_fnc_relPos;
        if (surfaceIsWater _minePos) then {
            _minePos = [_minePos select 0, _minePos select 1, getTerrainHeightASL _minePos];        
            _mine = createMine ["UnderwaterMinePDM", [_minePos select 0, _minePos select 1], [], 0];
            waitUntil {alive _mine};
            _mine setPosATL [_minePos select 0,_minePos select 1, (getPosATL _mine select 2) - 2];
        } else {
            _mine = createMine ["APERSTripMine", [_minePos select 0, _minePos select 1, 0.1], [], 0];
            waitUntil {alive _mine};
            _mine setDir (_dir1 + 0.8);
            _pos = getPosATL _mine;
            if (_pos select 2 > 0.2) then {
                _pos = [_pos select 0, _pos select 1, 0];
                _mine setPosATL _pos;
            };
        };
        if (!isNil "_mine") then {
            _minesArray = _minesArray + [_mine];
        };
    };
    _dir1 = _dir1 + 3.3;        
    _unitsArray = _unitsArray + [_sign1];

    _pos3 = [_startPoint, 200, _dir3] call BIS_fnc_relPos;
    _sign3 = createVehicle ["Land_Sign_Mines_F", [70,70,70], [], 0, "CAN_COLLIDE"];
    waitUntil {alive _sign3};
    _sign3 allowDamage false; 
    _sign3 setDir _dir3;
    _sign3 setPos [_pos3 select 0, _pos3 select 1, 0];    
    _dir3 = _dir3 + 3.6;
    _sign3 setDir ((getDir _sign3) + 180);
    _pos = getPosATL _sign3; 
    if (_pos select 2 > 0.2) then {
        _pos = [_pos select 0, _pos select 1, 0];
        _sign3 setPosATL _pos;
    };
    _unitsArray = _unitsArray + [_sign3];

    _minePos = [_startPoint, 190, _dir4] call BIS_fnc_relPos;
    if (surfaceIsWater _minePos) then {
        _height = random (floor ((getTerrainHeightASL _minePos) * -1));
        _pos = [_minePos select 0, _minePos select 1, (0 - _height)];
        _mine = createMine ["UnderwaterMine", _pos, [], 0]; 
    } else {
        _mine = createVehicle ["ATMine", [40,40,40], [], 0, "CAN_COLLIDE"];
        waitUntil {alive _mine};
        _mine setPos [_minePos select 0, _minePos select 1, 0]; 
        _pos = getPosATL _mine; 
        if (_pos select 2 > 0.2) then {
            _pos = [_pos select 0, _pos select 1, 0];
            _mine setPosATL _pos;
        };           
    };         
    _dir4 = _dir4 + 3.45;    
    if (!isNil "_mine") then {
        _minesArray = _minesArray + [_mine];
    };

    if (_c <= 56) then {
        _pos2 = [_flatPos, 90, _dir2] call BIS_fnc_relPos;    
        _sign2 = createVehicle ["Land_Razorwire_F", [40,40,40], [], 0, "CAN_COLLIDE"];
        waitUntil {alive _sign2};
        _sign2 allowDamage false;        
        _sign2 setDir _dir2;
        _sign2 setPos [_pos2 select 0, _pos2 select 1, 0];       
        _sign2 setVectorUp (surfaceNormal (getPosATL _sign2));
        _pos = getPosATL _sign2; 
        if (_pos select 2 > 0.2) then {
            _pos = [_pos select 0, _pos select 1, 0];
            _sign2 setPosATL _pos;
        };
        if ((random 10) > 2) then {
            _minePos = [_startPoint, 89.8, (_dir2 + 5)] call BIS_fnc_relPos;
            _mine = createMine ["APERSBoundingMine", [_minePos select 0, _minePos select 1, 0.1], [], 0];
            waitUntil {alive _mine};
            _mine setDir (_dir2 + 1.5);
            _pos = getPosATL _mine;
            if (_pos select 2 > 0.2) then {
                _pos = [_pos select 0, _pos select 1, 0];
                _mine setPosATL _pos;
            };
            if (!isNil "_mine") then {
                _minesArray = _minesArray + [_mine];
            };
        };
        _dir2 = _dir2 + 6.5;        
        _unitsArray = _unitsArray + [_sign2];
        _sign2 enableSimulation false;
    };    
    _sign1 enableSimulation false; 
};
_unitsArray = _unitsArray + _minesArray;

// set Cargo HQ
_cargoPos = [_startPoint, 0, 85, 3, 0, 15, 0] call BIS_fnc_findSafePos;
_cargoHQ = createVehicle ["Land_Cargo_HQ_V1_F", _cargoPos, [], 0, "CAN_COLLIDE"];
_unitsArray = _unitsArray + [_cargoHQ];

// set 3 Cargo Houses
_cargoHouses = [];
for "_i" from 1 to 3 do {
    _cargoPos = [_startPoint, 0, 85, 3, 0, 15, 0] call BIS_fnc_findSafePos;
    _cargoHouse = createVehicle ["Land_Cargo_House_V1_F", _cargoPos, [], 0, "CAN_COLLIDE"];
    _cargoHouses = _cargoHouses + [_cargoHouse];
};
_unitsArray = _unitsArray + _cargoHouses;

// set 6 Bag Bunkers for static guards
_bunkerTowers = [];
for "_i" from 1 to 6 do {
    _cargoPos = [_startPoint, 100, 170, 3, 0, 2, 0] call BIS_fnc_findSafePos;
    _cargoHouse = createVehicle ["Land_BagBunker_Small_F", _cargoPos, [], 0, "CAN_COLLIDE"];
    _cargoHouse setDir ([_cargoHouse, _startPoint] call BIS_fnc_dirTo);
    _bunkerTowers = _bunkerTowers + [_cargoHouse];
};
_unitsArray = _unitsArray + _bunkerTowers;

// spawn enemies and hostages
_enemiesArray = [grpNull];
_hostagesArray = [grpNull];

// hostages with guards 
_houseGroup = createGroup ENEMY_SIDE;
_hostagesGroup = createGroup Civilian;
_hostagesPlaced = 0;
_withHostages = false;
_unitPos = ["UP", "MIDDLE"];
{
    _positions = [([_x] call QS_fnc_FindPosBuilding), 7] call KK_fnc_arrayShufflePlus;
    {
        _pos = [(_x select 0), (_x select 1), (_x select 2)];
        _holyRandom = floor random 10;
        if (_hostagesPlaced < 4) then {           
            ([INFANTRY_HOSTAGES] call BIS_fnc_selectRandom) createUnit [_pos, _hostagesGroup, "currentHostage = this"];   
            currentHostage allowDamage false;
            doStop currentHostage;
            commandStop currentHostage;
            currentHostage setPosASL _pos;
            currentHostage setDir (_x select 3); 
            currentHostage setCaptive true;
            currentHostage setUnitPos (_unitPos call BIS_fnc_selectRandom);        
            currentHostage disableAI "MOVE";
            currentHostage addEventHandler ["killed", {SM_FAIL_RESCUE = SM_FAIL_RESCUE + 1;publicVariable "SM_FAIL_RESCUE";[(_this select 0),"QS_fnc_removeAction0",nil,true] spawn BIS_fnc_MP;(_this select 0) removeWeapon "hgun_Rook40_F";}];
            [currentHostage, "QS_fnc_addActionRescue",nil,true] spawn BIS_fnc_MP;  
            _hostagesPlaced = _hostagesPlaced + 1;
            _withHostages = true;   
            currentHostage allowDamage true;      
        } else {
            if (_holyRandom > 3 || _withHostages) then {
                ([INFANTRY_SUPPORT] call BIS_fnc_selectRandom) createUnit [_pos, _houseGroup, "currentGuard = this"];  
                currentGuard allowDamage false;
                doStop currentGuard;
                commandStop currentGuard;
                currentGuard setPosASL _pos;
                currentGuard setDir (_x select 3); 
                currentGuard setUnitPos (_unitPos call BIS_fnc_selectRandom);   
                currentGuard disableAI "MOVE";
                currentGuard addEventHandler ["hit", {(_this select 0) enableAI "MOVE";}];            
                _withHostages = false;
                currentGuard allowDamage true;
            };
        };
    } forEach _positions;  
} forEach _cargoHouses; 

// officer
_commanderGroup = createGroup ENEMY_SIDE;

_posATL = _cargoHQ buildingPos ([1,6] call BIS_fnc_selectRandom);
_posATL = [(_posATL select 0), (_posATL select 1), ((_posATL select 2) + 0.2)];
([INFANTRY_OFFICER] call BIS_fnc_selectRandom) createUnit [[1,1,0], _commanderGroup, "officer = this"];
waitUntil{!isNull officer};
officer allowDamage false;
officer setPos _posATL;    
doStop officer;
commandStop officer;
officer disableAI "MOVE";
officer addEventHandler ["hit", {(_this select 0) enableAI "MOVE";}];
officer setDir (random 360);
officer setUnitPos (_unitPos call BIS_fnc_selectRandom);
removeHeadgear officer;
officer addHeadgear "H_Cap_red";
sleep 0.5;
_distance = [_posATL, getPos officer] call BIS_fnc_distance2D;
if (_distance > 100) then {
    _posATL = [(getPos _cargoHQ), 0, 20, 3, 0, 15, 0] call BIS_fnc_findSafePos;
    officer setPos _posATL;
};
officer allowDamage true;

// guards with static weapons on cargoHQ
_staticGroup = createGroup ENEMY_SIDE;
{
    _posATL = _cargoHQ buildingPos _x;
    _posATL = [(_posATL select 0), (_posATL select 1), ((_posATL select 2) + 0.2)];
    _static = ([INFANTRY_STATIC] call BIS_fnc_selectRandom) createVehicle [10,10,10];       
    waitUntil{!isNull _static}; 
    _static allowDamage false;
    _static setPos _posATL;
    _static setDir (random 360); 
    ([INFANTRY_GUNNERS] call BIS_fnc_selectRandom) createUnit [[10,10,10], _staticGroup, "currentGuard = this"];
    currentGuard allowDamage false;
    sleep 0.2;
    currentGuard assignAsGunner _static;
    currentGuard moveInGunner _static;
    _static setVectorUp [0,0,1];
    _static lock 3;
    _enemiesArray = _enemiesArray + [_static];
    currentGuard allowDamage true;
    _static allowDamage true;
    _static = nil;
} forEach [5,7]; 

// other guards in cargoHQ
{
    _y = 0;
    _posATL = _cargoHQ buildingPos _x;  
    _posATL = [(_posATL select 0), (_posATL select 1), (_posATL select 2) + 0.3];
    ([INFANTRY_HOUSE] call BIS_fnc_selectRandom) createUnit [[10,10,10], _houseGroup, "currentGuard = this"];  
    currentGuard allowDamage false;
    sleep 0.1;
    currentGuard setPos _posATL;
    doStop currentGuard;
    commandStop currentGuard;
    currentGuard disableAI "MOVE";
    currentGuard addEventHandler ["hit", {(_this select 0) enableAI "MOVE";}];
    if (_x == 0) then {
        _y = 180;
    };
    if (_x == 2 || _x == 11) then {
        _y = -20;
    };
    currentGuard setDir (([currentGuard, _cargoHQ] call BIS_fnc_dirTo) + _y);
    currentGuard setUnitPos (_unitPos call BIS_fnc_selectRandom);  
    currentGuard allowDamage true;
} forEach [0,2,3,4,8,9,10,11];  

// guards in small bunkers
{
    _posATL = getPos _x;  
    _posATL = [(_posATL select 0), (_posATL select 1), (_posATL select 2) + 0.2];
    _static = ([INFANTRY_STATIC] call BIS_fnc_selectRandom) createVehicle [10,10,10];      
    waitUntil{!isNull _static}; 
    _static allowDamage false;
    _static setPos _posATL;
    _static setDir (([_static, _startPoint] call BIS_fnc_dirTo) + 180); 
    ([INFANTRY_GUNNERS] call BIS_fnc_selectRandom) createUnit [[10,10,10], _staticGroup, "currentGuard = this"];
    currentGuard allowDamage false;
    sleep 0.1;
    currentGuard assignAsGunner _static;
    currentGuard moveInGunner _static;
    _static setVectorUp [0,0,1];
    _static lock 3;
    _enemiesArray = _enemiesArray + [_static];
    currentGuard allowDamage true;
    _static allowDamage true;
    _static = nil; 
} forEach _bunkerTowers;  

// spawn infantry patrols inside second wire level
for "_x" from 1 to 2 do {
    _patrolGroup = createGroup ENEMY_SIDE;
    _randomPos = [[[_startPoint, 80],[]],["water","out"]] call BIS_fnc_randomPos;
    _patrolGroup = [_randomPos, ENEMY_SIDE, (configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> [INFANTRY_PATROL] call BIS_fnc_selectRandom)] call BIS_fnc_spawnGroup;
    _patrolGroup setBehaviour "COMBAT";
    _patrolGroup setCombatMode "RED";
    [(units _patrolGroup)] call QS_fnc_setSkill3;
    [_patrolGroup, _startPoint, 150] call BIS_fnc_taskPatrol;
    _enemiesArray = _enemiesArray + [_patrolGroup];
    {
        _x addItem "MineDetector";
    } forEach (units _patrolGroup);
};

// spawn infantry patrols between wire levels
for "_x" from 1 to 2 do {
    _patrolGroup = createGroup ENEMY_SIDE;
    _initAngle = (random 360);
    _initDistance = 135;
    if (_x == 2) then {
        _initDistance = _initDistance + 30;
    };
    _startPos = [_startPoint, _initDistance, _initAngle] call BIS_fnc_relPos;
    _patrolGroup = [_startPos, ENEMY_SIDE, (configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> [INFANTRY_PATROL] call BIS_fnc_selectRandom)] call BIS_fnc_spawnGroup;
    _patrolGroup setBehaviour "COMBAT";
    _patrolGroup setCombatMode "RED";
    [(units _patrolGroup)] call QS_fnc_setSkill3;
    _enemiesArray = _enemiesArray + [_patrolGroup];
    {
        _x addItem "MineDetector";
    } forEach (units _patrolGroup);
    for "_i" from 0 to 6 do
    {
        if (_i == 1) then {
            _initAngle = _initAngle + 45;
        } else {
            _initAngle = _initAngle - 45;
        };            
        _newPos = [_startPoint, _initDistance, _initAngle] call BIS_fnc_relPos;
        _wp = _patrolGroup addWaypoint [_newPos, 0];
        _wp setWaypointType "MOVE";
        _wp setWaypointCompletionRadius 15;
        if (_i == 0) then
        {
            _wp setWaypointSpeed "LIMITED";
            _wp setWaypointFormation "STAG COLUMN";
        };
    };
    _wp = _patrolGroup addWaypoint [_startPos, 0];
    _wp setWaypointType "CYCLE";
    _wp setWaypointCompletionRadius 15;
};

// set all mines positions as "known" for enemies
{
    if ((typeOf _x) isKindOf "TimeBombCore") then {
        ENEMY_SIDE revealMine _x;
    };
} forEach _minesArray;

// set skills and behaviour
_hostagesArray = _hostagesArray + [_hostagesGroup];

_commanderGroup setBehaviour "COMBAT";
_commanderGroup setCombatMode "RED";
_enemiesArray = _enemiesArray + [_commanderGroup];

_staticGroup setBehaviour "COMBAT";
_staticGroup setCombatMode "RED";
_enemiesArray = _enemiesArray + [_staticGroup];

_houseGroup setBehaviour "COMBAT";
_houseGroup setCombatMode "RED";
_enemiesArray = _enemiesArray + [_houseGroup];

[(units _commanderGroup)] call QS_fnc_setSkill3;
[(units _houseGroup)] call QS_fnc_setSkill3;
[(units _staticGroup)] call QS_fnc_setSkill3;
[(units _hostagesGroup)] call QS_fnc_setSkill3;

// show brief information
_city = _position select 0;
_briefing = format ["<t align='center'><t size='2.2'>Спецоперация</t><br/><t size='1.5' color='#FF9999'>Заложники</t><br/>____________________<br/>Отряд противника занял %1 и превратил его в укрепрайон. По приказу командира отряда часть местного населения была взята в заложники. Мы также получили ультиматум - покинуть остров в следующие 24 часа, в противном случае заложники будут убиты. Командование назначило пехотную спецоперацию<br/><br/>Ваша задача — выдвинуться в указанный район, обезвредить противника и освободить заложников. Будьте осторожны - противник имеет приказ уничтожить заложников в случае ликвидации командира.</t>", _city];
GlobalHint = _briefing; hint parseText GlobalHint; publicVariable "GlobalHint";
showNotification = ["NewSideMission", "Заложники"]; publicVariable "showNotification";

sideMissionUp = true; publicVariable "sideMissionUp";
SM_FAIL = false; publicVariable "SM_FAIL";
SM_FAIL_RESCUE = 0; publicVariable "SM_FAIL_RESCUE";
SM_SUCCESS_RESCUE = 0; publicVariable "SM_SUCCESS_RESCUE";
SM_SUCCESS_HOSTAGES = false; publicVariable "SM_SUCCESS_HOSTAGES";
SM_SUCCESS_OFFICER = false; publicVariable "SM_SUCCESS_OFFICER";
_showHostagesMessage = true;
_showOfficerMessage = true;
while { sideMissionUp } do {
    sleep 2;

    // hostages done
    if (_showHostagesMessage && {(SM_FAIL_RESCUE + SM_SUCCESS_RESCUE) == 4}) then {
        if (SM_SUCCESS_RESCUE >= 2) then {
            SM_SUCCESS_HOSTAGES = true;
            if (SM_SUCCESS_OFFICER) then {
                hqSideChat = format ["%1 из 4х заложников спасены!", SM_SUCCESS_RESCUE]; 
            } else {
                hqSideChat = format ["%1 из 4х заложников спасены! Уничтожьте вражеского командира.", SM_SUCCESS_RESCUE]; 
            }; 
            publicVariable "hqSideChat"; [OUR_SIDE,"HQ"] sideChat hqSideChat;            
        };
        if (SM_FAIL_RESCUE > 2) then {
            hqSideChat = format ["%1 из 4х заложников погибли!", SM_FAIL_RESCUE]; 
            publicVariable "hqSideChat"; [OUR_SIDE,"HQ"] sideChat hqSideChat;
            SM_FAIL = true; publicVariable "SM_FAIL";
        };
        _showHostagesMessage = false;
    };

    // officer killed
    if ((!alive officer || (lifeState officer == "DEAD")) && _showOfficerMessage) then {   
        SM_SUCCESS_OFFICER = true; publicVariable "SM_SUCCESS_OFFICER";    
        if (SM_SUCCESS_HOSTAGES) then {
            hqSideChat = "Вражеский командир уничтожен!"; 
        } else {
            hqSideChat = "Вражеский командир уничтожен. Противник пытается ликвидировать заложников!";
            {    
                _x setCaptive false;
                _x addRating -10000;    
                _x addWeapon "hgun_Rook40_F";
            } foreach (units _hostagesGroup);
        };        
        publicVariable "hqSideChat"; [OUR_SIDE,"HQ"] sideChat hqSideChat;                
        _showOfficerMessage = false;  

        // kill order   
        sleep 5;     
        { 
            ENEMY_SIDE setFriend [CIVILIAN, 0];  
            sleep 1;       
            _x enableAI "AUTOTARGET";  
            _x enableAI "MOVE";
        } foreach (units _houseGroup);
    };

    // de-briefing
    if ((SM_SUCCESS_HOSTAGES && SM_SUCCESS_OFFICER) || SM_FAIL) exitWith {  
        sideMissionUp = false; publicVariable "sideMissionUp";        
        { _x setMarkerPos [-12000,-12000,-12000]; publicVariable _x; } forEach ["sideMarker", "sideCircle"];
        "sideCircle" setMarkerSize [300, 300]; publicVariable "sideCircle";
        "sideMarker" setMarkerText ""; publicVariable "sideMarker";
        if (SM_FAIL) then {
            [] call QS_fnc_SMhintFAIL;
        } else {
            [] call QS_fnc_SMhintSUCCESS;   
        };

        // delete mines
        {
            if (_x distance _startPoint < 300) then {
               deleteVehicle _x;
            };            
        } forEach allMines;
        _nearestMines = nearestObjects [_startPoint, ["ATMine","APERSTripMine","APERSBoundingMine","UnderwaterMinePDM","UnderwaterMine"], 300];   
        {
            deleteVehicle _x;
        } forEach _nearestMines;

        sleep 120;
        { [_x] spawn QS_fnc_SMdelete } forEach [_enemiesArray, _unitsArray];
    };

    sleep 3;
};