/*
Author: ToxaBes
Description: punish object with light flash
Format: [object] call QS_fnc_punishObject;
*/
private ["_obj", "_pos", "_bolt", "_lighting", "_light"];
_obj = _this select 0;
_pos = getPos _obj;
_bolt = createVehicle ["LightningBolt", _pos, [], 0, "CAN_COLLIDE"];
_bolt setVelocity [0, 0, -10];
_lighting = "lightning_F" createvehiclelocal _pos;
_lighting setPos _pos;
_light = "#lightpoint" createvehiclelocal _pos;
_light setPos _pos;
_light setLightBrightness 30;
_light setLightAmbient [0.5, 0.5, 1];
_light setlightcolor [1, 1, 2];
deletevehicle _bolt;
deletevehicle _light;
deletevehicle _lighting;
_obj setDamage 1;
playSound (selectRandom ["thunder_1", "thunder_2"]);
[WEST, "HQ"] sideChat "Аид: нарушение правил, виновные наказаны.";
