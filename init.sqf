ts_enabled = false;

[] spawn {
	if !(hasInterface) exitWith{};
	waitUntil {!(isNull player)};
	ts_enabled = profileNameSpace getVariable ["timemarkers_ts_enabled", false];
	waitUntil {!isNull findDisplay 12};
	findDisplay 12 displayCtrl 51 ctrlAddEventHandler ["MouseButtonDblClick", {
		[] spawn {
			disableSerialization;
			waitUntil{!(isNull (findDisplay 54))};
			_markerdialog = findDisplay 54;
			_interface_div = getResolution select 5;
			waitUntil{ctrlEnabled (_markerdialog displayCtrl 1)};
			_markerdialog_ok = _markerdialog displayCtrl 1;
			_markerdialog_cancel = _markerdialog displayCtrl 2;
			sleep 0.01;

			_markerdialog_ok_pos = ctrlPosition _markerdialog_ok;
			_markerdialog_cancel_pos = ctrlPosition _markerdialog_cancel;
			_markerdialog_elem_height = (_markerdialog_ok_pos select 3);
			_markerdialog_ll_corner_x = (_markerdialog_ok_pos select 0);
			_markerdialog_ll_corner_y = (_markerdialog_ok_pos select 1) + _markerdialog_elem_height;
			_markerdialog_lr_corner_x = (_markerdialog_cancel_pos select 0) + (_markerdialog_cancel_pos select 2);
			_markerdialog_width = _markerdialog_lr_corner_x - _markerdialog_ll_corner_x;
			_markerdialog_btn_padding_y = 0.002 / _interface_div;

			_markerdialog_ok ctrlSetPosition [_markerdialog_ll_corner_x, _markerdialog_ll_corner_y + _markerdialog_btn_padding_y];
			_markerdialog_cancel ctrlSetPosition [_markerdialog_cancel_pos select 0, _markerdialog_ll_corner_y + _markerdialog_btn_padding_y];
			_markerdialog_ok ctrlCommit 0;
			_markerdialog_cancel ctrlCommit 0;

			_elem_bg_extender = _markerdialog ctrlCreate ["IGUIBack", -1];
			_elem_bg_extender ctrlSetPosition [_markerdialog_ll_corner_x, _markerdialog_ll_corner_y - _markerdialog_elem_height, _markerdialog_width, _markerdialog_elem_height];
			_elem_bg_extender ctrlSetBackgroundColor [0, 0, 0, 0.75];
			_elem_bg_extender ctrlCommit 0;

			_elem_ts_checkbox = _markerdialog ctrlCreate ["RscCheckBox", -1];
			_elem_ts_checkbox cbSetChecked ts_enabled;
			_elem_ts_checkbox ctrlSetScale _interface_div;
			_elem_ts_checkbox ctrlSetPosition [_markerdialog_ll_corner_x, _markerdialog_ll_corner_y - _markerdialog_elem_height];
			_elem_ts_checkbox ctrlCommit 0;
			_elem_ts_checkbox ctrlAddEventHandler ['CheckedChanged', {
				ts_enabled = ((_this select 1) == 1);
				profileNameSpace setVariable ["timemarkers_ts_enabled", ts_enabled];
				saveProfileNamespace;
			}];

			_elem_ts_desc = _markerdialog ctrlCreate ["RscText", -1];
			_elem_ts_desc ctrlSetPosition [_markerdialog_ll_corner_x + 0.014 / _interface_div, _markerdialog_ll_corner_y - _markerdialog_elem_height + 0.005];
			_elem_ts_desc ctrlSetScale 0.75;
			_elem_ts_desc ctrlSetText "Add timestamp";
			_elem_ts_desc ctrlCommit 0;

			_markerdialog_ok ctrlAddEventHandler ['ButtonClick', {
				[] spawn {
					if (ts_enabled) then {
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
