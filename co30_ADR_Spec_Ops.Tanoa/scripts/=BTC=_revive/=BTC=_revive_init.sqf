/*
Created by =BTC= Giallustio
version 0.95 Offical release
Visit us at:
http://www.blacktemplars.altervista.org/
06/03/2012

Edited by Quiksilver
15/10/2014 ArmA 1.32

QS note: Mobile respawn has been restored

*/


////////////////// EDITABLE \\\\\\\\\\\\\\\\\\\\\\\\\\

BTC_r_new_system    = 0; 											//WIP - set 1 to activate it
BTC_r_wait_for_revive = 1;											//If BTC_r_new_system set to 1 you can choose if you want or not a revive time available after death (Similar to wounding system in ACE)
BTC_r_action        = 0;											//[NOT IMPLEMENTED] - 0 if you don't want the healing animation (ACE style), 1 if you want the animations (You can't stop the animation)
BTC_r_med_fa        = 1;											//0 for only first aid kit, 1 if you don't have a medikit you need a first aid kit, 2 only medikit
BTC_r_cpr_time      = 20;
BTC_r_trans_ratio   = 100;
BTC_revive_time_min = 3;
BTC_revive_time_max = 600;
BTC_who_can_revive  = ["B_medic_F", "B_T_Medic_F"];
BTC_loop_check      = 1;
BTC_disable_respawn = 0;
BTC_respawn_gear    = 1;
BTC_active_lifes    = 10;
BTC_lifes           = 999;
BTC_spectating      = 0;											//0 = disable; 1 = units group; 2 = side units; 3 = all units
BTC_spectating_view = [0,0];										//To force a view set the first number of the array to 1. The second one is the view mode: 0 = first person; 1 = behind the back; 2 = High; 3 = free
BTC_s_mode_view     = ["First person", "Behind the back", "High", "Free"];
BTC_black_screen    = 0;											//Black screen + button while unconscious or action wheel and clear view
BTC_action_respawn  = 0;											//if black screen is set to 0 you can choose if you want to use the action wheel or the button. Keep in mind that if you don't use the button, the injured player can use all the action, frag too....
BTC_camera_unc      = 1;
BTC_camera_unc_type = ["Вид со спины", "Вид свысока"];
BTC_respawn_time    = 3;
BTC_active_mobile   = 0;											//Active mobile respawn (You have to put in map the vehicle and give it a name. Then you have to add one object per side to move to the mobile (BTC_base_flag_west,BTC_base_flag_east) - (1 = yes, 0 = no))
BTC_mobile_respawn  = 0;											//Active the mobile respawn fnc (1 = yes, 0 = no)
BTC_mobile_respawn_time = 30;										//Secs delay for mobile vehicle to respawn
BTC_need_first_aid = 1;												//You need a first aid kit to revive (1 = yes, 0 = no)
BTC_pvp = 0; 														//(disable the revive option for the enemy)
BTC_injured_marker = 0;
BTC_3d_can_see     = ["B_medic_F"];
BTC_3d_distance    = 800;
BTC_3d_icon_size   = 0.2;
BTC_3d_icon_color  = [1,0,0,1];
BTC_dlg_on_respawn = 0;												//1 = Mobile only - 2 Leader group and mobile - 3 = Units group and mobile - 4 = All side units and mobile
BTC_objects_actions_west = [];
BTC_objects_actions_east = [];
BTC_objects_actions_guer = [];
BTC_objects_actions_civ  = [];

//======================================== QS new config options

if (!isDedicated) then {

	//===== MISC

	west_BTC_mobileRespawn_addActionText = "Move to mobile respawn";		// (west/nato) 		add Action text for mobile respawn
	east_BTC_mobileRespawn_addActionText = "Move to mobile respawn";		// (east/opfor)		add Action text for mobile respawn
	resistance_BTC_mobileRespawn_addActionText = "Move to mobile respawn"; 	// (resistance/aaf) add Action text for mobile respawn
	civilian_BTC_mobileRespawn_addActionText = "Move to mobile respawn";	// (civilian)		add Action text for mobile respawn
	BTC_mobileRespawn_DeployMaxSpeed = 5;							// max speed that mobile respawn can be when deployed
	BTC_mobileRespawn_MoveToText = "Moving to mobile respawn";		// displayed on black screen when teleporting to mobile respawn
	BTC_mobileRespawn_MarkerUpdateFrequency = 1; 					// how often in seconds does the mobile respawn marker update its position?

	//===== Marker config text

	enable_newText_config = 1; 										// Set to 0 to use default text configs (the below 2 options)
	if (enable_newText_config == 1) then {
		BTC_mobileRespawn_MarkerText = "Mobile Respawn (deployed)";				// marker text when deployed
		BTC_mobileRespawn_MarkerTextMoving = "Mobile Respawn (moving)";			// marker text when moving
		BTC_mobileRespawn_MarkerTextDestroyed = "Mobile Respawn (destroyed)";	// marker text when destroyed
	};

	//===== Marker config when DEPLOYED

	BTC_mobileRespawn_MarkerType = "mil_dot";						// See this page for more marker types    https://community.bistudio.com/wiki/cfgMarkers
	BTC_mobileRespawn_MarkerSize = 0.5;
	BTC_mobileRespawn_MarkerAlpha = 0.75;							// Alpha of 1 = bold, Alpha of 0 = invisible, 0.5 = half visible
	BTC_mobileRespawn_MarkerColor = "ColorGreen";					// [0,1,0,1];  RGBA format

	//===== Marker config when MOVING

	BTC_mobileRespawn_MarkerTypeMoving = "mil_dot";
	BTC_mobileRespawn_MarkerSizeMoving = 0.5;
	BTC_mobileRespawn_MarkerAlphaMoving = 0.75;
	BTC_mobileRespawn_MarkerColorMoving = "ColorBlack";				// [0,0,0,1];

	//===== Marker config when DESTROYED

	BTC_mobileRespawn_MarkerTypeDestroyed = "mil_dot";
	BTC_mobileRespawn_MarkerSizeDestroyed = 0.5;
	BTC_mobileRespawn_MarkerAlphaDestroyed = 0.75;					// marker visibility when destroyed, between 0-1.
	BTC_mobileRespawn_MarkerColorDestroyed = "ColorRed";			// [1,0,0,1];

	//===== HINTS DISPLAYED WHEN MOBILE RESPAWN CHANGES STATE (moving/destroyed/deployed)
	//===== Deployed hint
	BTC_mobileRespawn_AvailableHint = 0;
	if (BTC_mobileRespawn_AvailableHint == 1) then {
		BTC_mobileRespawn_AvailableHintText = "Mobile Respawn is available!";
	};
	//===== Moving hint
	enable_BTC_mobileRespawn_MovingHint = 1;						// 0 to disable hint when mobile starts moving
	if (enable_BTC_mobileRespawn_MovingHint == 1) then {
		BTC_mobileRespawn_MovingHint = "Mobile respawn is moving! Can't move there!";		// Displayed when mobile respawn starts moving
	};
	//===== Destroyed hint
	BTC_mobileRespawn_DestroyedHint = 1; 							// set to 0 to disable hint when respawn is destroyed'
	if (BTC_mobileRespawn_DestroyedHint == 1) then {
		BTC_mobileRespawn_DestroyedHintText = "Mobile Respawn has been destroyed!"; 	// hint displayed when respawn destroyed
	};

	//======================================== BTC Medical Vehicle revive station

	BTC_Medical_TruckToggle = 1;				// Set to 0 to disable medical truck heal stations
	BTC_Medical_Trucks = ["B_Truck_01_medical_F","O_Truck_03_medical_F","I_Truck_02_medical_F","O_Truck_02_medical_F","Land_Pod_Heli_Transport_04_medevac_F","B_Slingload_01_Medevac_F"];
	BTC_Medical_Trucks_addActionText = "Первая помощь (Медицинский грузовик)";		// addAction text displayed when reviving someone near medical truck
};

//=========== END NEW CONFIG OPTIONS
//=========== END NEW CONFIG OPTIONS
//=========== END NEW CONFIG OPTIONS

if (isServer) then {
	BTC_vehs_mobile_west = [];		//Editable - define mobile west (this is the vehicle name)
	BTC_vehs_mobile_east = [];						//Editable - define mobile east
	BTC_vehs_mobile_guer = [];						//Editable - define mobile independent
	BTC_vehs_mobile_civ  = [];						//Editable - define mobile civilian
};

////////////////// Don't edit below \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

call compile preprocessFile "scripts\=BTC=_revive\=BTC=_functions.sqf";

if (isServer) then {

	//Mobile
	BTC_vehs_mobile_west_str = [];BTC_vehs_mobile_east_str = [];BTC_vehs_mobile_guer_str = [];BTC_vehs_mobile_civ_str = [];
	if (BTC_active_mobile == 1 && count BTC_vehs_mobile_west != 0) then {for "_i" from 0 to ((count BTC_vehs_mobile_west) - 1) do {_veh = (BTC_vehs_mobile_west select _i);_var = str (_veh);BTC_vehs_mobile_west_str = BTC_vehs_mobile_west_str + [_var];_veh setVariable ["BTC_mobile_west",_var,true];if (BTC_mobile_respawn == 1) then {_resp = [_veh,_var,"BTC_mobile_west"] spawn BTC_vehicle_mobile_respawn;};};} else {{deleteVehicle _x} foreach BTC_vehs_mobile_west;};
	if (BTC_active_mobile == 1 && count BTC_vehs_mobile_east != 0) then {for "_i" from 0 to ((count BTC_vehs_mobile_east) - 1) do {_veh = (BTC_vehs_mobile_east select _i);_var = str (_veh);BTC_vehs_mobile_east_str = BTC_vehs_mobile_east_str + [_var];_veh setVariable ["BTC_mobile_east",_var,true];if (BTC_mobile_respawn == 1) then {_resp = [_veh,_var,"BTC_mobile_east"] spawn BTC_vehicle_mobile_respawn;};};} else {{deleteVehicle _x} foreach BTC_vehs_mobile_east;};
	if (BTC_active_mobile == 1 && count BTC_vehs_mobile_guer != 0) then {for "_i" from 0 to ((count BTC_vehs_mobile_guer) - 1) do {_veh = (BTC_vehs_mobile_guer select _i);_var = str (_veh);BTC_vehs_mobile_guer_str = BTC_vehs_mobile_guer_str + [_var];_veh setVariable ["BTC_mobile_guer",_var,true];if (BTC_mobile_respawn == 1) then {_resp = [_veh,_var,"BTC_mobile_guer"] spawn BTC_vehicle_mobile_respawn;};};} else {{deleteVehicle _x} foreach BTC_vehs_mobile_guer;};
	if (BTC_active_mobile == 1 && count BTC_vehs_mobile_civ != 0) then {for "_i" from 0 to ((count BTC_vehs_mobile_civ) - 1) do {_veh = (BTC_vehs_mobile_civ select _i);_var = str (_veh);BTC_vehs_mobile_civ_str = BTC_vehs_mobile_civ_str + [_var];_veh setVariable ["BTC_mobile_civ",_var,true];if (BTC_mobile_respawn == 1) then {_resp = [_veh,_var,"BTC_mobile_civ"] spawn BTC_vehicle_mobile_respawn;};};} else {{deleteVehicle _x} foreach BTC_vehs_mobile_civ;};
	if (BTC_active_mobile == 1) then {publicVariable "BTC_vehs_mobile_west_str";publicVariable "BTC_vehs_mobile_east_str";publicVariable "BTC_vehs_mobile_guer_str";publicVariable "BTC_vehs_mobile_civ_str";};
	//
	BTC_killed_pveh = [];publicVariable "BTC_killed_pveh";
	BTC_drag_pveh = [];publicVariable "BTC_drag_pveh";
	BTC_carry_pveh = [];publicVariable "BTC_carry_pveh";
	BTC_marker_pveh = [];publicVariable "BTC_marker_pveh";
	BTC_load_pveh = [];publicVariable "BTC_load_pveh";
	BTC_pullout_pveh = [];publicVariable "BTC_pullout_pveh";
	if (BTC_r_new_system == 1) then {

		BTC_anim_pveh = [];publicVariable "BTC_anim_pveh";
		BTC_cpr_pveh = [];publicVariable "BTC_cpr_pveh";
		BTC_ban_pveh = [];publicVariable "BTC_ban_pveh";
		BTC_med_pveh = [];publicVariable "BTC_med_pveh";
	};
};

if (isDedicated) exitWith {};

BTC_dragging = false;
BTC_respawn_cond = false;

// ========== CLIENT INIT

[] spawn {

	waitUntil {!isNull player};
	waitUntil {player == player};

	"BTC_drag_pveh" addPublicVariableEventHandler BTC_fnc_PVEH;
	"BTC_carry_pveh" addPublicVariableEventHandler BTC_fnc_PVEH;
	"BTC_marker_pveh" addPublicVariableEventHandler BTC_fnc_PVEH;
	"BTC_load_pveh" addPublicVariableEventHandler BTC_fnc_PVEH;
	"BTC_pullout_pveh" addPublicVariableEventHandler BTC_fnc_PVEH;
	"BTC_killed_pveh" addPublicVariableEventHandler BTC_fnc_PVEH;
	BTC_r_mobile_selected = objNull;
	BTC_r_bleeding = 0;
	BTC_r_bleeding_loop = false;
	player addRating 9999;
	BTC_r_list = [];
	BTC_side = playerSide;
	BTC_r_s_cam_view = [-15,-15,15];
	BTC_respawn_marker = format ["respawn_%1",playerSide];
	if (BTC_respawn_marker == "respawn_guer") then {BTC_respawn_marker = "respawn_guerrila";};
	if (BTC_respawn_marker == "respawn_civ") then {BTC_respawn_marker = "respawn_civilian";};
	BTC_r_base_spawn = "Land_HelipadEmpty_F" createVehicleLocal getMarkerPos BTC_respawn_marker;
	if (BTC_r_new_system == 0) then {

		player addEventHandler ["Killed",BTC_player_killed];

	} else {

		"BTC_cpr_pveh" addPublicVariableEventHandler BTC_fnc_PVEH;
		"BTC_ban_pveh" addPublicVariableEventHandler BTC_fnc_PVEH;
		"BTC_med_pveh" addPublicVariableEventHandler BTC_fnc_PVEH;
		"BTC_anim_pveh" addPublicVariableEventHandler BTC_fnc_PVEH;
		player setVariable ["BTC_r_status",[0,0,0,0,0],true];
		player addEventHandler ["HandleDamage", BTC_fnc_handledamage];
		player addEventHandler ["Killed", BTC_eh_killed];
		BIS_fnc_healthEffects_handleDamage_code = {};
		BIS_fnc_healtEffects_init = {};
		BTC_r_action_menu = true;
		BTC_r_med_effect = false;
		BTC_is_bleeding = false;
		enableCamShake true;
		BTC_r_unc = false;
		BTC_r_unc_loop = false;
		BTC_r_damage = 0;
		BTC_r_head = 0;
		BTC_r_damage_legs = 0;
		BTC_r_damage_hands = 0;
		BTC_r_hit = 0;
	};

	player setVariable ["BTC_need_revive",0,true];

	if (BTC_pvp == 1) then {player setVariable ["BTC_revive_side",str (BTC_side),true];};
	player setVariable ["BTC_dragged",0,true];

	if ([player] call BTC_is_class_can_revive) then {
		player addAction [("<t color=""#F44336""><img image='\a3\ui_f\data\map\VehicleIcons\pictureheal_ca.paa' size='1.0'/> ") + ("Первая помощь") + "</t>","scripts\=BTC=_revive\=BTC=_addAction.sqf",[[],BTC_first_aid], 8, true, true, "", "[] call BTC_check_action_first_aid", 10];
	};
	if (BTC_Medical_TruckToggle != 0) then {
		if (!([player] call BTC_is_class_can_revive)) then {
			player addAction [("<t color=""#F44336""><img image='\a3\ui_f\data\map\VehicleIcons\pictureheal_ca.paa' size='1.0'/> ") + (BTC_Medical_Trucks_addActionText) + "</t>","scripts\=BTC=_revive\=BTC=_addAction.sqf",[[],BTC_first_aid], 8, true, true, "", "[] call BTC_check_action_HEMTT", 10];
		};
	};
	player addAction [("<t color=""#EF5350""><img image='\a3\ui_f\data\map\VehicleIcons\pictureheal_ca.paa' size='1.0'/> ") + ("Тащить") + "</t>","scripts\=BTC=_revive\=BTC=_addAction.sqf",[[],BTC_drag], 8, true, true, "", "[] call BTC_check_action_drag", 10];
	player addAction [("<t color=""#EF5350""><img image='\a3\ui_f\data\map\VehicleIcons\pictureheal_ca.paa' size='1.0'/> ") + ("Нести") + "</t>","scripts\=BTC=_revive\=BTC=_addAction.sqf",[[],BTC_carry], 8, true, true, "", "[] call BTC_check_action_drag", 10];
	player addAction [("<t color=""#EF5350""><img image='\a3\ui_f\data\map\VehicleIcons\pictureheal_ca.paa' size='1.0'/> ") + ("Выгрузить раненого") + "</t>","scripts\=BTC=_revive\=BTC=_addAction.sqf",[[],BTC_pull_out], 8, true, true, "", "[] call BTC_pull_out_check", 10];

	if (BTC_active_mobile == 1) then {

		switch (true) do {
			case (BTC_side == west) : {{private ["_veh"];_veh = _x;_spawn = [_x] spawn BTC_mobile_marker;{_x addAction [("<t color=""#EF5350""><img image='\a3\ui_f\data\map\VehicleIcons\pictureheal_ca.paa' size='1.0'/> ") + (west_BTC_mobileRespawn_addActionText) + "</t>","scripts\=BTC=_revive\=BTC=_addAction.sqf",[[_veh],BTC_move_to_mobile], 8, true, true, "", format ["[""%1""] call BTC_mobile_check",_veh]];} foreach BTC_objects_actions_west;} foreach BTC_vehs_mobile_west_str;};
			case (BTC_side == east) : {{private ["_veh"];_veh = _x;_spawn = [_x] spawn BTC_mobile_marker;{_x addAction [("<t color=""#EF5350""><img image='\a3\ui_f\data\map\VehicleIcons\pictureheal_ca.paa' size='1.0'/> ") + (east_BTC_mobileRespawn_addActionText) + "</t>","scripts\=BTC=_revive\=BTC=_addAction.sqf",[[_veh],BTC_move_to_mobile], 8, true, true, "", format ["[""%1""] call BTC_mobile_check",_veh]];} foreach BTC_objects_actions_east;} foreach BTC_vehs_mobile_east_str;};
			case (str (BTC_side) == "guer") : {{private ["_veh"];_veh = _x;_spawn = [_x] spawn BTC_mobile_marker;{_x addAction [("<t color=""#EF5350""><img image='\a3\ui_f\data\map\VehicleIcons\pictureheal_ca.paa' size='1.0'/> ") + (resistance_BTC_mobileRespawn_addActionText) + "</t>","scripts\=BTC=_revive\=BTC=_addAction.sqf",[[_veh],BTC_move_to_mobile], 8, true, true, "", format ["[""%1""] call BTC_mobile_check",_veh]];} foreach BTC_objects_actions_guer;} foreach BTC_vehs_mobile_guer_str;};
			case (BTC_side == civilian) : {{private ["_veh"];_veh = _x;_spawn = [_x] spawn BTC_mobile_marker;{_x addAction [("<t color=""#EF5350""><img image='\a3\ui_f\data\map\VehicleIcons\pictureheal_ca.paa' size='1.0'/> ") + (civilian_BTC_mobileRespawn_addActionText) + "</t>","scripts\=BTC=_revive\=BTC=_addAction.sqf",[[_veh],BTC_move_to_mobile], 8, true, true, "", format ["[""%1""] call BTC_mobile_check",_veh]];} foreach BTC_objects_actions_civ;} foreach BTC_vehs_mobile_civ_str;};
		};

	} else {

		BTC_vehs_mobile_west_str = [];BTC_vehs_mobile_east_str = [];BTC_vehs_mobile_guer_str = [];BTC_vehs_mobile_civ_str = [];
	};


	if (({player isKindOf _x} count BTC_3d_can_see) > 0) then {if (BTC_pvp == 1) then {_3d = [] spawn BTC_3d_markers_pvp;} else {_3d = [] spawn BTC_3d_markers;};};

	BTC_revive_started = true;
	//hint "REVIVE STARTED";
};
