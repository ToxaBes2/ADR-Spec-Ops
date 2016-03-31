Private ["_name","_vehicle","_vehname","_weapname","_weap","_target","_picture","_vehtarget","_azimuth","_wepdir","_hudnames","_ui"];	   
disableSerialization;
while {true} do  {
  	1000 cutRsc ["HudNames","PLAIN"];
   	_ui = uiNameSpace getVariable "HudNames";
 	  _HudNames = _ui displayCtrl 99999;
    if (player != vehicle player) then {
        _name = "";
        _vehicle = assignedVehicle player;
        _vehname= getText (configFile >> "CfgVehicles" >> (typeOf vehicle player) >> "DisplayName");
        _weapname = getarray (configFile >> "CfgVehicles" >> typeOf (vehicle player) >> "Turrets" >> "MainTurret" >> "weapons"); 
        _weap = _weapname select 0;
        _name = format ["<t size='1.25' color='#FFCC00' shadow='1'>%1</t><br/>", _vehname];	      
        {
            _role = roleDescription _x;
            if((driver _vehicle == _x) || (gunner _vehicle == _x)) then {	                
                if(driver _vehicle == _x) then {
                    _name = format ["<t size='0.85' color='#FFFFFF' shadow='1'>%1 %2</t> <img size='0.7' color='#CCFF66' shadow='1' image='a3\ui_f\data\IGUI\Cfg\Actions\getindriver_ca.paa'/> <t size='0.85' color='#FFFFFF' shadow='1'>(%3)</t><br/>", _name, (name _x), _role];
                } else {
	                  _target = cursorTarget;
       				      _picture = getText (configFile >> "cfgVehicles" >> typeOf _target >> "displayname");
       				      _vehtarget =  format ["%1",_picture];
	                  _wepdir =  (vehicle player) weaponDirection _weap;
			              _Azimuth = round  (((_wepdir select 0) ) atan2 ((_wepdir select 1) ) + 360) % 360;
                    _name = format ["<t size='0.85' color='#FFFFFF' shadow='1'>%1 %2</t> <img size='0.7' color='#CCFF66' shadow='1' image='a3\ui_f\data\IGUI\Cfg\Actions\getingunner_ca.paa'/> <t size='0.85' color='#FFFFFF' shadow='1'>(%5)</t><br/> <t size='0.85' color='#FFFFFF'>Азимут :<t/> <t size='0.85' color='#ff0000'>%3</t><br/><t size='0.85' color='#FFFFFF'> Цель : </t><t size='0.85' color='#ff0000'>%4</t><br/>", _name, (name _x), _Azimuth, _vehtarget, _role];                  
                }; 
            } else {
                _name = format ["<t size='0.85' color='#FFFFFF' shadow='1'>%1 %2</t> <img size='0.7' color='#CCFF66' shadow='1' image='a3\ui_f\data\IGUI\Cfg\Actions\getincargo_ca.paa'/> <t size='0.85' color='#FFFFFF' shadow='1'>(%3)</t><br/>", _name, (name _x), _role];
            };              
        } forEach crew _vehicle;
      	_HudNames ctrlSetStructuredText parseText _name;
      	_HudNames ctrlCommit 0;       	       
    };
    sleep 2;
};
