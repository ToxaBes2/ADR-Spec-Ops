/*
Author: ToxaBes
Description: show decimal azimuth for artillery gunner
*/
class ArtilleryHUD {
    idd = -1;
    duration = 999999;
    onLoad = "uiNamespace setVariable ['ArtilleryHud', _this select 0]";
    class Controls {
        class TXT {
            idc = 20000;
            type = 0;                           
            style = ST_LEFT;                          
            x = 0.45; y = -0.13;                     
            w = 0.1; h = 0.05;                  
            colorText[] = {1, 1, 1, 1};         
            colorBackground[] = {0, 0, 0, 1}; 
            font = "TahomaB";                   
            SizeEx = .04;                       
            text = "";     
        };
    };
};
