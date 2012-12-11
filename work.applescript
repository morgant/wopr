(* 
 * Work - Launch/configure everything as I do every day when I get into the office.
 * 
 * v0.1   2011-07-19 - Morgan Aldridge <morgant@makkintosshu.com>
 *                     Initial version.
 * v0.2   2012-03-19 - Morgan Aldridge
 *                     Fixed disabling AirPort under Lion & changed order of activating Terminal to prevent extraneous window.
 *)

-- Turn off AirPort & switch to the appropriate location
do shell script "/usr/sbin/networksetup -setairportpower en0 off; /usr/sbin/scselect 'Small Dog Electronics, Inc.'"

-- Launch required apps
tell application "Time Out" to run
tell application "Adium" to run
tell application "Mail" to activate

-- If Terminal is not running yet, launch it and start a `screen` session
tell application "System Events"
	if "Terminal" is not in (name of processes) then
		tell application "Terminal"
			do script "screen -R"
			activate
		end tell
	end if
end tell

-- Make sure the volume is set to max (it's a MacBook Air that's closed, after all)
set volume 7
