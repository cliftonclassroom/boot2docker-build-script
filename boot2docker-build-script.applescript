-- Setting the path and running boot2docker.
set boot2dockerPath to "/usr/local/bin/boot2docker"
repeat
	try
		-- Ensuring that boot2docker is initialzed.
		do shell script boot2dockerPath & " init"
		
		set boot2dockerStatus to do shell script boot2dockerPath & " status"
		if boot2dockerStatus is not "running" then
			do shell script boot2dockerPath & " up"
		end if
		exit repeat
	on error errStr number errorNumber
		if errorNumber is equal to 127 then
			set boot2dockerPath to text returned of (display dialog "boot2docker not found. Please type your boot2docker path below." default answer boot2dockerPath)
		else
			display alert errStr & "An unknown error occurred."
			return
		end if
	end try
end repeat

tell application "Finder"
	set parentPath to parent of (path to me)
	set workingDirectory to POSIX path of (parentPath as string)
	set imageName to name of parentPath
end tell

tell application "Terminal"
	tell application "System Events"
		set isTerminalRunning to (name of processes) contains "Terminal"
	end tell
	if isTerminalRunning then
		-- Opening new terminal window.
		do script ""
	end if
	
	activate
	do script boot2dockerPath & " ssh" in window 1
	do script "cd " & workingDirectory in window 1
	do script "docker build -t " & imageName & " ." in window 1
	do script "docker run -it --rm -v " & workingDirectory & ":/usr/src " & imageName & " /bin/bash" in window 1
	do script "cd /usr/src" in window 1
end tell