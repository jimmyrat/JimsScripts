set MySystemScripts to (path to home folder as text) & "Library:Scripts"
set MyQXPScripts to "Macintosh HD:Library:Application Support:Quark:QuarkXPress 2017:Scripts"
set ServerSystemScripts to "MAC_SERVER:SHARED FILES:UPDATES FOR MACS:to Users-username-Library:Scripts"
set ServerQXPScripts to "MAC_SERVER:SHARED FILES:UPDATES FOR MACS:to Applications:to QuarkXPress folder:Scripts"

if MySystemScripts does not contain "jlake" then
	
	tell application "Finder"
		
		delete (every item of folder MyQXPScripts whose name does not start with "Logon MacServer " and name does not start with "AS400 Logon")
		
		duplicate items of folder ServerSystemScripts to folder MySystemScripts with replacing
		
		duplicate items of folder ServerQXPScripts to folder MyQXPScripts with replacing
		
	end tell
	
	tell application "QuarkXPress 2017"
		activate
		if (count of documents) = 0 then
			quit
		else
			display dialog "Please quit and restart QuarkXPress to re-enable scripts in the Quark Script menu." buttons {"OK"} default button 1 with icon note
		end if
		delay 5
		activate
	end tell
	
end if


beep 2 --Tell user that script is finished