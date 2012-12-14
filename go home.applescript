(* 
 * Go Home - Quit/disconnect/reconfigure everything as I do every day when I go home from the office.
 * 
 * v0.1   2011-07-19 - Morgan Aldridge <morgant@makkintosshu.com>
 *                     Initial version.
 * v0.2   2012-03-19 - Morgan Aldridge
 *                     Updated to also eject my personal drive, if it's mounted.
 * v0.3   2012-12-14 - Morgan Aldridge
 *                     Only run if correct user, plus stop time machine & log out.
 *)

-- Only running as the correct user
set user to do shell script "/usr/bin/whoami"
if user is "morgan" then
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
		if processList contains "SubEthaEdit" then
			tell application "SubEthaEdit" to quit
		end if
	end tell
	
	-- Stop Time Machine if it's running
	if IsTimeMachineRunning() then
		do shell script "/Applications/Time\\ Machine.app/Contents/MacOS/Time\\ Machine 3"
		delay 5
	end if
	
	-- Eject my Time Machine & personal drives 
	tell application "Finder"
		if exists the disk "LaCie" then
			eject "LaCie"
		end if
		if exists the disk "kikkutsushita" then
			eject "kikkutsushita"
		end if
	end tell
	
	-- Turn on AirPort & switch to the appropriate location
	do shell script "/usr/sbin/networksetup -setairportpower on; /usr/sbin/scselect 'Automatic'"
	
	-- We're done, log out
	tell application "System Events" to log out
end if

-- Function to determine whether Time Machine is running or not
on IsTimeMachineRunning()
	try
		do shell script "ps auxc | grep backupd"
		return true
	on error
		return false
	end try
end IsTimeMachineRunning
