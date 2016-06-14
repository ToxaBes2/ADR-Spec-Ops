/*
  Author: ToxaBes
  Description: Play psh-psh sound to active radio channel
*/
if (!hasInterface || isDedicated) exitWith {};
_player = objectFromNetId ( _this select 0);
_channelId = _this select 1;
_type = _this select 2;
_operativeUnits = ["B_Soldier_SL_F", "B_Helipilot_F"];
_commanderUnits = ["B_Soldier_SL_F"];
_soundIdStart = "playerRadioStart";
_soundIdEnd = "playerRadioEnd";
_play = false;
switch (_channelId) do {
  case 3 : {
      // group channel
      if (group player == group _player) then {
          _play = true;
      };
  };
  case 4 : {
      // vehicle channel
      if (vehicle player == vehicle _player) then {
          _play = true;
      };
  };
  case 6 : {
      // emergency channel
  };
  case 7 : {
      // operative channel
      if ((typeOf player) in _operativeUnits) then {
          _play = true;
          _soundIdStart = "playerOperativeStart";
          _soundIdEnd = "playerOperativeEnd";
      };
  };
  case 8 : {
      // command channel
      if ((typeOf player) in _commanderUnits) then {
          _play = true;
          _soundIdStart = "playerOperativeStart";
          _soundIdEnd = "playerOperativeEnd";
      };
  };
  default {};
};
if (!_play) exitWith {};
if (_type == "start") then {
    playSound _soundIdStart;
} else {
    playSound _soundIdEnd;
};
