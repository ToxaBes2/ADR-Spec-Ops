private ["_completeTextJet"];

_completeTextJet = "<t align='center'><t size='2.2'>Внимание</t><br/><t size='1.5' color='#08b000'>Штурмовик уничтожен</t><br/>____________________<br/>Противник лишился авиаподдержки<br/><br/>Возвращайтесь к выполнению основной задачи.</t>";
GlobalHint = _completeTextJet; publicVariable "GlobalHint"; hint parseText _completeTextJet;
showNotification = ["EnemyJetDown", "Воздушная цель нейтрализована!"]; publicVariable "showNotification";