[] spawn {
	if !(hasInterface) exitWith{};
	waitUntil {!isNull findDisplay 12};
	findDisplay 12 displayCtrl 51 ctrlAddEventHandler ["MouseButtonDblClick", {
		[] spawn {
			waitUntil{ctrlEnabled (findDisplay 54 displayCtrl 1)};
			findDisplay 54 displayCtrl 1 ctrlAddEventHandler ['ButtonClick', {
				[] spawn {
					if (count allMapMarkers > 0) then {
						_newMarker = (allMapMarkers select count allMapMarkers - 1);
						if ( _newMarker select [ 0, 13 ] == "_USER_DEFINED" ) then {
							_text = markerText _newMarker;
							_time = [daytime, "HH:MM"] call BIS_fnc_timeToString;
							_newMarker setMarkerText format ["%1 [%2]", _text, _time];
						};
					};
				};
			}];
		};
	}];
};