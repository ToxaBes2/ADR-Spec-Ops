
if (!isDedicated) then {	
	player addAction [
		("<t color='#00ff00'>" + localize "STRD_squadm" + "</t>"), 
		Compile preprocessFileLineNumbers "scripts\DOM_squad\open_dialog.sqf", [], -80, false
	];	
};
