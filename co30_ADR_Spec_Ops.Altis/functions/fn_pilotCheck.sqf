private ["_pilots", "_partizan_pilots", "_aircraft_nopilot", "_aircraft_nocopilot", "_mh9", "_aircraft_nopilot_partizan", "_aircraft_nocopilot_partizan", "_veh", "_players", "_playersCount", "_pilotsOnServer"];

_pilots = ["B_Helipilot_F", "B_T_Helipilot_F"];	// Специализация пилота
_partizan_pilots = ["I_G_Soldier_AR_F","I_G_engineer_F","I_C_Soldier_Para_4_F","I_C_Soldier_Para_8_F","I_G_Soldier_GL_F","I_G_medic_F"];

//---------- Место пилота заблокировано
_aircraft_nopilot = [
// Вертолеты
"B_Heli_Transport_03_F",						// Хурон
"O_Heli_Transport_04_covered_F",				// Тару транспортный
"O_Heli_Transport_04_F",						// Тару грузовой
"O_Heli_Transport_04_bench_F",					// Тару сидения
"O_Heli_Light_02_unarmed_F",					// Касатка транспортная
"O_Heli_Light_02_F",							// Касатка боевая
"B_Heli_Attack_01_F",							// Блэкфут
"O_Heli_Attack_02_F",							// Кайман
"O_Heli_Attack_02_black_F",						// Кайман черный
"B_Heli_Transport_01_F",						// Гостхок
"B_Heli_Transport_01_camo_F",					// Гостхок камуфляж
"B_CTRG_Heli_Transport_01_sand_F",				// Гостхок CTRG песок
"B_CTRG_Heli_Transport_01_tropic_F",			// Гостхок CTRG тропики
"I_Heli_Transport_02_F",						// Мохаук
"I_Heli_light_03_unarmed_F",					// Хелкат транспортный
"I_Heli_light_03_F",							// Хелкат боевой
"B_Heli_Light_01_armed_F",						// Пауни
"B_Heli_Light_01_F",							// Хамингберд желтый
"B_Heli_Light_01_stripped_F",           		// Хамингберд зеленый

// Самолеты
"B_Plane_CAS_01_F",								// А10
"O_Plane_CAS_02_F",								// Неофрон
"I_Plane_Fighter_03_CAS_F",						// Буззард
"I_Plane_Fighter_03_AA_F",						// Буззард АА
"B_T_VTOL_01_armed_F",							// V-44 X Blackfish боевой
"B_T_VTOL_01_infantry_F",						// V-44 X Blackfish транспортный
"B_T_VTOL_01_vehicle_F",						// V-44 X Blackfish грузовой
"O_T_VTOL_02_infantry_F",						// Y-32 Xi'an транспортный
"O_T_VTOL_02_vehicle_F"							// Y-32 Xi'an грузовой
];

//---------- Место 2-го пилота заблокировано
_aircraft_nocopilot = [
// Вертолеты
"B_Heli_Transport_03_F",						// Хурон
"O_Heli_Transport_04_covered_F",				// Тару транспортный
"O_Heli_Transport_04_F",						// Тару грузовой
"O_Heli_Transport_04_bench_F",					// Тару сидения
"O_Heli_Light_02_unarmed_F",					// Касатка транспортная
"O_Heli_Light_02_F",							// Касатка боевая
"B_Heli_Transport_01_F",						// Гостхок
"B_Heli_Transport_01_camo_F",					// Гостхок камуфляж
"B_CTRG_Heli_Transport_01_sand_F",				// Гостхок CTRG песок
"B_CTRG_Heli_Transport_01_tropic_F",			// Гостхок CTRG тропики
"I_Heli_Transport_02_F",						// Мохаук
"I_Heli_light_03_unarmed_F",					// Хелкат транспортный
"I_Heli_light_03_F",							// Хелкат боевой
"B_Heli_Light_01_armed_F",						// Пауни
"B_Heli_Light_01_F",							// Хамингберд желтый
"B_Heli_Light_01_stripped_F",					// Хамингберд зеленый

// Самолеты
"B_T_VTOL_01_armed_F",							// V-44 X Blackfish боевой
"B_T_VTOL_01_infantry_F",						// V-44 X Blackfish транспортный
"B_T_VTOL_01_vehicle_F",						// V-44 X Blackfish грузовой
"O_T_VTOL_02_infantry_F",						// Y-32 Xi'an транспортный
"O_T_VTOL_02_vehicle_F"							// Y-32 Xi'an грузовой
];

_mh9 = [
"B_Heli_Light_01_F",
"B_Heli_Light_01_armed_F",
"B_Heli_Light_01_stripped_F"
];

_aircraft_nopilot_partizan = [
// Вертолеты
"O_Heli_Transport_04_covered_F",                // Тару транспортный
"O_Heli_Transport_04_bench_F",                  // Тару сидения
"O_Heli_Light_02_unarmed_F",                    // Касатка транспортная
"I_Heli_light_03_unarmed_F",                    // Хелкат транспортный
"I_Heli_light_03_F",                            // Хелкат боевой
"B_Heli_Light_01_armed_F",                      // Пауни
"B_Heli_Light_01_F",                            // Хамингберд желтый
"B_Heli_Light_01_stripped_F",                   // Хамингберд зеленый
"C_Plane_Civil_01_F",                           // Самолет Caesar BTT
"C_Plane_Civil_01_racing_F",                    // Самолет Caesar BTT
"I_C_Plane_Civil_01_F",                         // Самолет Caesar BTT
"C_Heli_Light_01_civil_F"                       // Вертолет М-900
];

_aircraft_nocopilot_partizan = [
// Вертолеты
"O_Heli_Transport_04_covered_F",                // Тару транспортный
"O_Heli_Transport_04_bench_F",                  // Тару сидения
"O_Heli_Light_02_unarmed_F",                    // Касатка транспортная
"I_Heli_light_03_unarmed_F",                    // Хелкат транспортный
"I_Heli_light_03_F",                            // Хелкат боевой
"B_Heli_Light_01_armed_F",                      // Пауни
"B_Heli_Light_01_F",                            // Хамингберд желтый
"B_Heli_Light_01_stripped_F",                   // Хамингберд зеленый
"C_Plane_Civil_01_F",                           // Самолет Caesar BTT
"C_Plane_Civil_01_racing_F",                    // Самолет Caesar BTT
"I_C_Plane_Civil_01_F"                          // Самолет Caesar BTT
];

_veh = _this;

// Count amount of players on the server
_players = objNull;
if (isMultiplayer) then {
    _players = playableUnits;
} else {
    _players = switchableUnits;
};
_playersCount = count _players;

// Check if there are any pilots on the server
_pilotsOnServer = false;
{
    if ((typeOf _x) in _pilots) then {
        _pilotsOnServer = true;
    };
} forEach _players;

// Kick player out of the vehicle if he is not a pliot
if !((typeOf player) in _pilots) then {

    // allow Humminbird for all players if there are less than 7 players on the server and no pilots
    if ((_playersCount < 7) and ((typeOf _veh) in _mh9) and !_pilotsOnServer) exitWith {};

    // all helicopters from spec operations available for all players until next landing
    _allowOnce = _veh getVariable ["ALLOW_ONCE", false];
    if (_allowOnce && side player == resistance && (driver _veh == player || player == _veh turretUnit [0])) exitWith {
        systemChat "Вам временно доступно место пилота.";
    };
    if (_allowOnce && side player == west && !_pilotsOnServer && driver _veh == player) exitWith {
        systemChat "Вы можете занимать место пилота только до следующего приземления.";   
        [player, _veh] spawn {
            _player = _this select 0; 
            _veh = _this select 1;      
            _check = true;
            while {_check} do {            
                if !(driver _veh == _player) then {
                    _check = false;
                } else {
                    if (getPosATL _veh select 2 > 5 && speed _veh > 5) then {
                        _check = false;
                    };
                };
                sleep 5;
            };
            waitUntil {isTouchingGround (vehicle _player)};
            sleep 1;
            if (driver _veh == _player) then {
                (vehicle _player) setVariable ["ALLOW_ONCE", false, true]; 
                (vehicle _player) engineOn false;
                _player action ["getOut", vehicle _player];
            };            
        };           
    };

    if ((typeOf player) in _partizan_pilots) then {
        call {
            if (!((typeOf _veh) in _aircraft_nopilot_partizan) and (player == driver _veh)) exitWith {
                systemChat "У Вас нет опыта чтобы пилотировать данную технику.";
                player action ["getOut", _veh];
            };
            if (!((typeOf _veh) in _aircraft_nocopilot_partizan) and (player == _veh turretUnit [0])) exitWith {
                systemChat "У Вас нет знаний чтобы занять место 2-го пилота.";
                player action ["getOut", _veh];
            };
        };
    } else {
        call {
            if (((typeOf _veh) in _aircraft_nopilot) and (player == driver _veh)) exitWith {
                systemChat "Вы должны быть пилотом чтобы пилотировать данную технику.";
                player action ["getOut", _veh];
            };
            if (((typeOf _veh) in _aircraft_nocopilot) and (player == _veh turretUnit [0])) exitWith {
                systemChat "Вы должны быть пилотом чтобы занять место 2-го пилота.";
                player action ["getOut", _veh];
            };
        };
    };
};
