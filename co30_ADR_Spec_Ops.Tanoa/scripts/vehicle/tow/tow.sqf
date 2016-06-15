/*
Author: Seth Duda
Improved by: Toxa Bes
License: MIT
Copyright: (c) 2016 Seth Duda
Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/
call compileFinal preprocessFileLineNumbers "scripts\vehicle\tow\functions.sqf";
if(!isDedicated) then {
	[] spawn {
		while {true} do {
			if(!isNull player && isPlayer player) then {
				if!(player getVariable ["SA_Tow_Actions_Loaded",false]) then {
					[] call SA_Add_Player_Tow_Actions;
					player setVariable ["SA_Tow_Actions_Loaded",true];
				};
			};
			missionNamespace setVariable ["SA_Nearby_Tow_Vehicles", (call SA_Find_Nearby_Tow_Vehicles)];
			sleep 3;
		};
	};
};
