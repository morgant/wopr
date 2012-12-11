(* 
 * Go Home - Quit/disconnect/reconfigure everything as I do every day when I go home from the office.
 * 
 * v0.1   2011-07-19 - Morgan Aldridge <morgant@makkintosshu.com>
 *                     Initial version.
 *)

-- If certain apps are running, quit them
tell application "System Events"
	set processList to name of processes
	if processList contains "Mail" then
		tell application "Mail" to quit
	end if
	if processList contains "Adium" then
		tell application "Adium" to quit
	end if
	if processList contains "Time Out" then
		tell application "Time Out" to quit
	end if
end tell

-- Eject my Time Machine drive
tell application "Finder"
	if exists the disk "LaCie" then
		eject "LaCie"
	end if
end tell

-- Turn on AirPort & switch to the appropriate location
do shell script "/usr/sbin/networksetup -setairportpower on; /usr/sbin/scselect 'Automatic'"

-- We're done, go to sleep
tell application "Finder" to sleep
