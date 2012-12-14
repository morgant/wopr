(* 
 * Work - Launch/configure everything as I do every day when I get into the office.
 * 
 * v0.1   2011-07-19 - Morgan Aldridge <morgant@makkintosshu.com>
 *                     Initial version.
 * v0.2   2012-03-19 - Morgan Aldridge
 *                     Fixed disabling AirPort under Lion & changed order of activating Terminal to prevent extraneous window.
 * v0.3   2012-12-14 - Morgan Aldridge
 *                     Switch users if not the correct user, plus quit iChat & start a daily postmortem.
 *)

-- If not running as the correct user, switch users
set user to do shell script "/usr/bin/whoami"
if user is not "morgan" then
	do shell script "/usr/local/bin/swusr -n morgan"
else
	-- Turn off AirPort & switch to the appropriate location
	do shell script "/usr/sbin/networksetup -setairportpower en0 off; /usr/sbin/scselect 'Small Dog Electronics, Inc.'"
	
	-- Quit iChat/Messages
	tell application "iChat" to quit
	
	-- Launch required apps
	tell application "Time Out" to activate
	tell application "Adium" to activate
	tell application "SubEthaEdit" to activate
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
	
	-- Open a daily postmortem
	tell application "Terminal" to do script "/Users/morgan/bin/postmortem today && exit"
	
	-- Make sure the volume is set to max (it's a MacBook Air that's closed, after all)
	set volume 7
end if
