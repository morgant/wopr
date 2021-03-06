(* Telecommute - Launch/configure everything as I do when I need to telecommute.
 * 
 * v0.1   2011-07-21 - Morgan Aldridge <morgant@makkintosshu.com>
 *                     Initial version.
 * v0.2   2012-03-19 - Morgan Aldridge
 *                     Fix for Terminal opening extraneous window.
 * v0.3   2012-12-14 - Morgan Aldridge
 *                     Switch users if not the correct user, plus start a daily postmortem.
 * v0.3.1 2013-02-08 - Morgan Aldridge
 *                     Minor fix for Terminal/postmortem freeze.
 *)

-- If not running as the correct user, switch users
set user to do shell script "/usr/bin/whoami"
if user is not "morgan" then
	do shell script "/usr/local/bin/swusr -n morgan"
else
	-- Sign onto the VPN
	-- via http://macscripter.net/viewtopic.php?id=22992
	tell application "System Events"
		tell current location of network preferences
			set vpnService to service "SmallDog.com VPN" -- name of the VPN service
			if exists vpnService then
				repeat until connected of current configuration of vpnService
					connect vpnService
					delay 30
				end repeat
			else
				display dialog "ERROR! Couldn't find the specified VPN service!"
			end if
		end tell
	end tell
	
	-- Launch required apps
	tell application "Time Out" to run
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
