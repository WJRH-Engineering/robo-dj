#!/usr/bin/liquidsoap

# set("log.file",true)
# set("log.file.path", "/home/wjrh/robo-dj-install/log/general.log")

%include "/secrets/passwords.liq"
%include "lib/config.liq"
%include "lib/latch.liq"

set("server.telnet", true)
set("server.telnet.bind_addr", "0.0.0.0")

config_set("output.server", "api.wjrh.org")
config_set("output.port", "8000")
config_set("description", "WJRH Robotic Disc Jockey")

randomized_playlist = playlist(mode = 'randomized', reload=1, reload_mode = 'rounds')

stream_to = output.icecast(
	%mp3,
	host = config_get("output.server"),
	port = int_of_string(config_get("output.port")),
	password = icecast_password,
	description = config_get("description"),
	url = "api.wjrh.org:8000",
	fallible = true
)

# Define playlists
station_ids = randomized_playlist('/media/station-ids')
programming = randomized_playlist('/media/songs')

# setup station ID logic
station_id_times = { 0m or 15m or 30m or 45m }
latch_set_condition := station_id_times

# reset the station id latch every time an id is played
station_ids.on_track(fun(_) -> latch_reset())
latch_begin()

register_latch_commands("station_ids")

# use an alias for latch_get_value function
time_for_station_id = latch_get_value

radio = switch([
	(time_for_station_id, station_ids),
	({true}, programming)
])

stream_to(mount="robo-dj", mksafe(radio))
