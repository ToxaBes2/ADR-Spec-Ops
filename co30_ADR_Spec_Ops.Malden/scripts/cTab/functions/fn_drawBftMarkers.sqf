/*
 	Name: cTab_fnc_drawBftMarkers
 	
 	Author(s):
		Gundy, Riouken

 	Description:
		Draw BFT markers
		
		List format:
			Index 0: Unit object
			Index 1: Path to icon A
			Index 2: Path to icon B (either group size or wingmen)
			Index 3: Text to display
			Index 4: String of group index

	
	Parameters:
		0: OBJECT  - Map control to draw BFT icons on
		1: INTEGER - Mode, 0 = draw normal, 1 = draw for TAD, 2 = draw for MicroDAGR
 	
 	Returns:
		BOOLEAN - Always TRUE
 	
 	Example:
		[_ctrlScreen,0] call cTab_fnc_drawBftMarkers;
*/
_ctrlScreen = _this select 0;
_mode = _this select 1;
_shadow = 1;
_textSize = 0.04;
_textFont = 'puristaMedium';
_textOffset = 'right';
_group = group player;
{
	call {
	    _v = vehicle _x;
	    if (_v distance2D player < 1000) then {
            _iconType = [_v] call QS_fnc_iconType;
	    	_color = [_x] call QS_fnc_iconColor;
	    	_pos = getPosASL _v;
	    	_iconSize = [_v] call QS_fnc_iconSize;
	    	_dir = getDir _v;
	    	_text = [_v] call QS_fnc_iconText;    
	    	_ctrlScreen drawIcon [
	    		_iconType,
	    		_color,
	    		_pos,
	    		_iconSize,
	    		_iconSize,
	    		_dir,
	    		_text,
	    		_shadow,
	    		_textSize,
	    		_textFont,
	    		_textOffset
	    	];
        };
    };
} count (units _group);
true