--Copyright 1998 by James Lake.


set CodeList to {"algd", "alps", "mtdc", "haha", "gndc", "gnsu", "msdc", "bbyt", "dftc", "dchx", "nslr", "bydc", "bpug", "dpsa", "slvc", "htgd"}

set ClubType to "specialty" --"allbreed", "national", "obedience", "combined", "specialty"

repeat with x from 1 to count of items in CodeList
	
	--set some variables
	set OfficersInfo to ""
	set UserNme to "USER"
	set Passwrd to "PWORD"
	
	--Get information from User
	with timeout of 600 seconds
		--Get the Show Code (and change case to lower)
		set ShowCode to lowercase (item x of CodeList) --lowercase (text 1 through 4 of text returned of (display dialog "Enter Show Code." default answer "" buttons {"Cancel", "OK"} default button 2 with icon note))
	end timeout
	
	with timeout of 600 seconds
		--Get the Club Type
		--set ClubType to ((choose from list {"allbreed", "national", "obedience", "combined", "specialty"} with prompt "Choose the Club Type." default items "allbreed" without multiple selections allowed and empty selection allowed) as text)
	end timeout
	
	--Check to see if temp file already exists
	set SaveFile to (((path to desktop folder) as text) & ShowCode & ".html")
	tell application "System Events"
		if exists file SaveFile then delete file SaveFile
	end tell
	
	--Set file location to save the html file into
	if ClubType is "allbreed" then
		set WebPath to "ftp://" & UserNme & ":" & Passwrd & "@192.168.0.1//webdata/jodstwo/clubs/allbreedclubs/" & ShowCode & ".html"
	else if ClubType is "national" then
		set WebPath to "ftp://" & UserNme & ":" & Passwrd & "@192.168.0.1//webdata/jodstwo/clubs/nationalbreedclubs/" & ShowCode & ".html"
	else if ClubType is "obedience" then
		set WebPath to "ftp://" & UserNme & ":" & Passwrd & "@192.168.0.1//webdata/jodstwo/clubs/obedienceclubs/" & ShowCode & ".html"
	else if ClubType is "combined" then
		set WebPath to "ftp://" & UserNme & ":" & Passwrd & "@192.168.0.1//webdata/jodstwo/clubs/combspecclubs/" & ShowCode & ".html"
	else if ClubType is "specialty" then
		set WebPath to "ftp://" & UserNme & ":" & Passwrd & "@192.168.0.1//webdata/jodstwo/clubs/specialtyclubs/" & ShowCode & ".html"
	end if
	
	tell application "Google Chrome"
		activate
		--Open the page from AS/400
		open location (("http://www.onofrio.com/execpgm/clubcom?key=" & (uppercase ShowCode)) as text)
		--Wait until the page loads
		set chromeLoading to loading of active tab of window 1
		repeat while chromeLoading = true
			delay 1
			tell application "Google Chrome" to set chromeLoading to loading of active tab of window 1
		end repeat
		--Save the page to the desktop and close
		save active tab of window 1 in SaveFile as "only html"
		delay 1
		close active tab of window 1
	end tell
	
	--Transfer the file to JODS2
	do shell script (("curl -T " & quoted form of POSIX path of SaveFile & " " & WebPath) as text)
	tell application "System Events"
		delete file SaveFile
	end tell
	
	tell application "Google Chrome"
		--activate --Open the html file so user knows it's done
		--open location "http://www.onofrio.com" & text 39 through -1 of WebPath
	end tell
	
	delay 1
	
end repeat

beep 2 --Let user know it's finished