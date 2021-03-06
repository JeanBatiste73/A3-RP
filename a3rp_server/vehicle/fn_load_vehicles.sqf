/**
* A3-RP
* Server-side
* file: load_vehicles.sqf
* desc: Load vehicles from database
*/

private _vehicles = call SRV_fnc_select_vehicles;

{
	private _vehicle_id 		= _x select 0;
	private _vehicle_classname 	= _x select 1;
	private _vehicle_damage 	= parseSimpleArray(_x select 2);
	private _vehicle_fuel 		= _x select 3;
	private _vehicle_pos 		= [_x select 4, _x select 5, _x select 6];
	private _vehicle_dir 		= _x select 7;
	private _vehicle_player_id 	= _x select 8;

	private _vehicle_keys 		= [_vehicle_id] call SRV_fnc_select_vehicle_key;
	private _vehicle 			= [_vehicle_classname, _vehicle_pos, _vehicle_dir] call SRV_fnc_create_vehicle;

	_vehicle setVariable ["vehicle_id", _vehicle_id, true];
	_vehicle setVariable ["vehicle_keys", _vehicle_keys, true];

	[_vehicle, _vehicle_damage] call SRV_fnc_set_vehicle_damage;
	_vehicle setFuel _vehicle_fuel;
} forEach _vehicles;