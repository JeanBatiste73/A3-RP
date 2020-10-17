/**
* A3-RP
* Client-side
* file: initPlayerLocal.sqf (https://community.bistudio.com/wiki/Event_Scripts#initPlayerLocal.sqf)
* desc: Handle auth and variables for the player. Executed after initServer.sqf
*/

if (!isMultiplayer) exitWith {};

/**
* Black screen
*/
0 cutText[localize "STR_loading", "BLACK FADED", 99999999];

client_log_me_id = 0;
client_account_id_received 		= compile("false");
client_players_list_received 	= compile("false");
client_ready_to_play 			= compile("false");
client_player_selected 			= compile("false");
client_player_spawn_selected 	= compile("false");
client_player_is_ready 			= compile("false");

["Server is loading..."] call client_fnc_log_me;

/**
* Wait until the server is ready
*/
waitUntil {call SRV_is_ready};
["The server is ready"] call client_fnc_log_me;

/**
* Ask database if account exist, if not, create it, then send back client ID
*/
["Asking account to the server..."] call client_fnc_log_me;
[] call auth_fnc_ask_account;
waitUntil {call client_account_id_received};
["The account is ready"] call client_fnc_log_me;

/**
* Ask database if account has existing players in database
*/
["Asking the list of player of this account to the server..."] call client_fnc_log_me;
[] call auth_fnc_ask_players;
waitUntil {call client_players_list_received};

/**
* Display cam sequence, then character selection, spawn
*/
waitUntil {!isNull (findDisplay 46)};
[] call client_fnc_cam_intro;
waitUntil {player getVariable ["client_cam_ready", false]};
createDialog "A3RP_player_list";

waitUntil {call client_player_selected};
/**
* If it's first spawn
*/
if (client_player_position isEqualTo [0,0,0]) then {
	createDialog "A3RP_spawn_menu";
} else {
	//TODO : TP player at his pos
};
waitUntil {call client_player_is_ready};