/*
 * This file contains parameters to config and function call to start an instance of
 * traffic in the mission. The file is edited by the mission developer.
 *
 * See file Engima\Traffic\Documentation.txt for documentation and a full reference of
 * how to customize and use Engima's Traffic.
 */

 private ["_parameters"];

// Set traffic parameters.
_parameters = [
	["SIDE", civilian],
	["VEHICLES", ["B_Quadbike_01_F", "C_SUV_01_F", "I_G_Offroad_01_F", "C_Offroad_02_unarmed_F"]],
	["VEHICLES_COUNT", 12],
	["MIN_SPAWN_DISTANCE", 1500],
	["MAX_SPAWN_DISTANCE", 5500],
	["MIN_SKILL", 1],
	["MAX_SKILL", 1],
	["DEBUG", false]
];

// Start an instance of the traffic
_parameters spawn ENGIMA_TRAFFIC_StartTraffic;
