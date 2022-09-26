
//the datum that stores specific statistics from the current round.

/*
To add new statistics, include "var/the_thing_to_count = 0" in the list below indented accordingly.
Then, in the file where the thing you want to count happens, include "round_statistics.the_thing_to_count++"
to use said count anywhere else include round_statistics.the_thing_to_count in your code.
add [] around this to use it in text.
*/

GLOBAL_DATUM_INIT(round_statistics, /datum/round_statistics, new)

/datum/round_statistics
	var/weeds_destroyed = 0
