set QXPLibraries to "Macintosh HD:Library:Application Support:Quark:QuarkXPress 2017:QXP Libraries"
set NewLibraries to "MAC_SERVER:SHARED FILES:LIBRARIES"

tell application "Finder"
	
	display dialog "Make sure all libraries are closed in QuarkXPress, then click OK." with icon caution
	
	delete every item of folder QXPLibraries
	duplicate (every file of folder NewLibraries whose name ends with ".qxl") to folder QXPLibraries with replacing
	
	set Lib2Open to choose from list {"None", "PL Library", "AD Library", "CAT Library", "JP Library"} with prompt "Select which Libraries you want to open:" default items "" with multiple selections allowed
	
	if Lib2Open does not contain "None" then
		if Lib2Open contains "PL Library" then
			set PLLibrary to every file of folder QXPLibraries whose name starts with "PL"
			open PLLibrary
		else if Lib2Open contains "AD Library" then
			set ADLibrary to every file of folder QXPLibraries whose name starts with "AD"
			open ADLibrary
		else if Lib2Open contains "CAT Library" then
			set CATLibrary to every file of folder QXPLibraries whose name starts with "CAT"
			open CATLibrary
		else if Lib2Open contains "JP Library" then
			set JPLibrary to every file of folder QXPLibraries whose name starts with "JP"
			open JPLibrary
		end if
	end if
	
end tell


beep 2 --Tell user script is finished