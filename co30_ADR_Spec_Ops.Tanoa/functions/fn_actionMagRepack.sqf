/*
Author:	malashin
Description: Repack ammo in players magazines
*/
private ["_magList", "_currentMagClass", "_currentMagAmmo", "_currentMagSize", "_counter", "_currentAmmoArray", "_playerInVehicle", "_stance", "_vehicle", "_repackInProgress", "_repackTime", "_index", "_previousMagAmmo", "_magAmmoSum", "_t", "_progress", "_start", "_end", "_currentMagName"];


scopeName "main";


//Restrict use of this action while procedure is in progress
ADR_magRepack = true;


// Create array with all ammo and magazine amount [magazineClassname, [1st_magAmmo, 2nd_magAmmo, ...]]
_magList = [];
{
    _currentMagClass = _x select 0;
    _currentMagAmmo = _x select 1;
    _currentMagSize = getNumber (configFile >> "CfgMagazines" >> _currentMagClass >> "count");
    if ((_currentMagSize > 1) and (_x select 3 == -1)) then {
        if (count _magList == 0) then {
            _magList pushBack [_currentMagClass, [_currentMagAmmo]];
        } else {
            _counter = 0;
            for "_x" from ((count _magList) - 1) to 0 step -1 do {
                if ((_magList select _x) select 0 == _currentMagClass) then {
                    _magList set [_x, [_currentMagClass, ((_magList select _x) select 1) + [_currentMagAmmo]]];
                    _counter = _counter + 1;
                };
                if ((_x == 0) and (_counter == 0)) then {
                    _magList pushBack [_currentMagClass, [_currentMagAmmo]];
                };
            }
        };
    };
} forEach magazinesAmmoFull player;


// Sort all magAmmo in descending order [magazineClassname, [1st_magAmmo, 2nd_magAmmo, ...]]
{
    _currentMagClass = _x select 0;
    _currentAmmoArray = _x select 1;
    _currentAmmoArray sort false;
    _magList set [_forEachIndex, [_currentMagClass, _currentAmmoArray]];
} forEach _magList;


// Warn player that movement will break the process
["<t size = '.46'>Перепаковываю магазины</t><br /><t color='#F44336' size = '.48'>Не двигайтесь!</t>", 0, 0.8, 5, 0.5, 0] spawn BIS_fnc_dynamicText;


// Play animation if player is not in a vehicle
if (vehicle player == player) then {
    _playerInVehicle = false;
    _stance = stance player;
    call {
        if (_stance == "STAND") exitWith {
            call {
                if (currentweapon player == primaryweapon player) exitWith {
                    player playMove "AinvPercMstpSrasWrflDnon";
                };
                if (currentweapon player == handgunweapon player) exitWith {
                    player playMove "AinvPercMstpSrasWpstDnon";
                };
                if (currentweapon player == secondaryweapon player) exitWith {
                    player playMove "AinvPercMstpSrasWlnrDnon";
                };
                if (currentweapon player == "") exitWith {
                    player playMove "AinvPercMstpSnonWnonDnon";
                };
            };
        };
        if (_stance == "CROUCH") exitWith {
            call {
                if (currentweapon player == primaryweapon player) exitWith {
                    player playMove "AinvPknlMstpSrasWrflDnon";
                };
                if (currentweapon player == handgunweapon player) exitWith {
                    player playMove "AinvPknlMstpSrasWpstDnon";
                };
                if (currentweapon player == secondaryweapon player) exitWith {
                    player playMove "AinvPknlMstpSrasWlnrDnon";
                };
                if (currentweapon player == "") exitWith {
                    player playMove "AinvPknlMstpSnonWnonDnon";
                };
            };
        };
        if (_stance == "PRONE") exitWith {
            call {
                if (currentweapon player == primaryweapon player) exitWith {
                    player playMove "AinvPpneMstpSrasWrflDnon";
                };
                if (currentweapon player == handgunweapon player) exitWith {
                    player playMove "AinvPpneMstpSrasWpstDnon";
                };
                if (currentweapon player == "") exitWith {
                    player playMove "AinvPpneMstpSnonWnonDnon";
                };
            };
        };
    };
} else {
    _playerInVehicle = true;
    _vehicle = vehicle player;
};


// Start the repacking process, combine only two magazines per cycle
_repackInProgress = true;
while {_repackInProgress} do {
    _repackTime = 0;
    _currentMagClass = "";


    // Create new array by combining only two magazines that are closest to being full
    // Count ammo transfered from the second magazines as _repackTime (2 seconds for 1 bullet)
    {
        scopeName "magList";
        _index = _forEachIndex;
        _currentMagClass = _x select 0;
        _currentAmmoArray = _x select 1;
        _currentMagSize = getNumber (configFile >> "CfgMagazines" >> _currentMagClass >> "count");
        _previousMagAmmo = _currentMagSize;
        {
            _currentMagAmmo = _x;
            if (_previousMagAmmo == _currentMagSize) then {
                _previousMagAmmo = _currentMagAmmo;
            } else {
                _magAmmoSum = _previousMagAmmo + _currentMagAmmo;
                if (_magAmmoSum <= _currentMagSize) then {
                    _repackTime = _currentMagAmmo * 2;
                    _currentAmmoArray set [(_forEachIndex - 1), _magAmmoSum];
                    _currentAmmoArray deleteAt _forEachIndex;
                    _magList set [_index, [_currentMagClass, _currentAmmoArray]];
                    breakOut "magList";
                } else {
                    _repackTime = (_magAmmoSum - _currentMagSize) * 2;
                    _currentAmmoArray set [(_forEachIndex - 1), _currentMagSize];
                    _currentAmmoArray set [(_forEachIndex), _currentMagSize - _previousMagAmmo];
                    breakOut "magList";
                };
            };
        } forEach _currentAmmoArray;
    } forEach _magList;


    // Wait until player is fully transitioned to the specified animation
    if !(_playerInVehicle) then {
        waitUntil {animationState player in ["ainvpercmstpsraswrfldnon","ainvpercmstpsraswpstdnon","ainvpercmstpsraswlnrdnon","ainvpercmstpsnonwnondnon","ainvpknlmstpsraswrfldnon","ainvpknlmstpsraswpstdnon","ainvpknlmstpsraswlnrdnon","ainvpknlmstpsnonwnondnon","ainvppnemstpsraswrfldnon","ainvppnemstpsraswpstdnon","ainvppnemstpsnonwnondnon"]};
    };


    // Get the start time
    _t = time;


    // Create progress bar
    with uiNamespace do {
        magRepack_progressBar = findDisplay 46 ctrlCreate ["RscProgress", -1];
        magRepack_progressBar ctrlSetPosition [0.34, 0.9];
        magRepack_progressBar progressSetPosition 0;
        magRepack_progressBar ctrlCommit 0;

        magRepack_text = findDisplay 46 ctrlCreate ["RscStructuredText", -1];
	    magRepack_text ctrlSetPosition [ 0.48, 0.89 ];
	    magRepack_text ctrlCommit 0;

        [ "TIMER", "onEachFrame", {
            params[ "_start", "_end" ];
            _progress = linearConversion[ _start, _end, time, 0, 1 ];
            (uiNamespace getVariable "magRepack_progressBar") progressSetPosition _progress;
            (uiNamespace getVariable "magRepack_text") ctrlSetStructuredText parseText format["%1%2", round(100*_progress), "%"];
            if ( _progress > 1 ) then {
                [ "TIMER", "onEachFrame" ] call BIS_fnc_removeStackedEventHandler;
            };
        }, [ _t, _t + _repackTime ] ] call BIS_fnc_addStackedEventHandler;
    };


    // Repack one magazine for _repackTime seconds
    // Break the process if animation is interupted or player gets out of the vehicle
    while {time < (_t + _repackTime)} do {
        uiSleep 0.2;
        if !(_playerInVehicle) then {
            if !(animationState player in ["ainvpercmstpsraswrfldnon","ainvpercmstpsraswpstdnon","ainvpercmstpsraswlnrdnon","ainvpercmstpsnonwnondnon","ainvpknlmstpsraswrfldnon","ainvpknlmstpsraswpstdnon","ainvpknlmstpsraswlnrdnon","ainvpknlmstpsnonwnondnon","ainvppnemstpsraswrfldnon","ainvppnemstpsraswpstdnon","ainvppnemstpsnonwnondnon"]) then {
                ["<t color='#F44336' size = '.48'>Перепаковка магазинов прервана</t>", 0, 0.8, 3, 0.5, 0] spawn BIS_fnc_dynamicText;
                ctrlDelete (uiNamespace getVariable "magRepack_progressBar");
                ctrlDelete (uiNamespace getVariable "magRepack_text");
                _repackInProgress = false;
                breakTo "main";
            };
        } else {
            if (vehicle player != _vehicle) then {
                ["<t color='#F44336' size = '.48'>Перепаковка магазинов прервана</t>", 0, 0.8, 3, 0.5, 0] spawn BIS_fnc_dynamicText;
                ctrlDelete (uiNamespace getVariable "magRepack_progressBar");
                ctrlDelete (uiNamespace getVariable "magRepack_text");
                _repackInProgress = false;
                breakTo "main";
            };
        };
    };


    // Delete gui elements once process is finished
    ctrlDelete (uiNamespace getVariable "magRepack_progressBar");
    ctrlDelete (uiNamespace getVariable "magRepack_text");


    // Tell the player that one mag was repacked
    // If there are no more mags to repack, tell the player that the process is finished
    if (_repackTime == 0) then {
        _repackInProgress = false;
        ["<t color='#C6FF00' size = '.48'>Перепаковка магазинов завершена</t>", 0, 0.8, 3, 0.5, 0] spawn BIS_fnc_dynamicText;
    } else {
        _currentMagName = getText (configFile >> "CfgMagazines" >> _currentMagClass >> "displayName");
        [format ["<t color='#FFEB3B' size = '.48'>%1</t><br /><t size = '.46'>%2</t>", _currentMagName, "перепакован"], 0, 0.8, 3, 0.5, 0] spawn BIS_fnc_dynamicText;
        {
            _currentMagClass = _x select 0;
            _currentAmmoArray = _x select 1;
            player removeMagazines _currentMagClass;
            {
                player addMagazine [_currentMagClass, _x];
            } forEach _currentAmmoArray;
        } forEach _magList;
    };
};


// Delete the gui once more in case it gets stuck
ctrlDelete (uiNamespace getVariable "magRepack_progressBar");
ctrlDelete (uiNamespace getVariable "magRepack_text");


//Remove action use restriction after procedure is finished
ADR_magRepack = nil;
