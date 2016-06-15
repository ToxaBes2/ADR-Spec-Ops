/*
Author: ToxaBes
Description: rescue hostage
*/
player playMove "AinvPercMstpSrasWrflDnon_Putdown_AmovPercMstpSrasWrflDnon";
sleep 1;
deleteVehicle (_this select 0);
SM_SUCCESS_RESCUE = SM_SUCCESS_RESCUE + 1; publicVariable "SM_SUCCESS_RESCUE";
hqSideChat = format ["Заложников освобождено: %1", SM_SUCCESS_RESCUE]; publicVariable "hqSideChat"; [WEST,"HQ"] sideChat hqSideChat;	