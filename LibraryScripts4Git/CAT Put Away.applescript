--Copyright 1996 by James Lake.


tell application "Finder"
	activate
	
	with timeout of 1800 seconds
		
		--Set the variables
		set CurrentUser to uppercase (short user name of (system info))
		set LocalShowPath to alias "Macintosh HD:SHOW FILES:"
		set ServerShowPath to alias "MAC_SERVER:SHOW FILES:"
		
		--Check to see if there are no folders in SHOW FILES on this computer
		if (count of folders of folder LocalShowPath) = 0 then
			display dialog "There are no Show folders on this computer to put away." buttons {"Cancel"} default button 1 with icon stop
			return
		end if
		
		--Get list of show code folders to put away from user
		set ListofNames to ((name of every folder of folder LocalShowPath) as list)
		if (count of ListofNames) is 1 then
			set folderList to ((item 1 of ListofNames) as text) as list
		else --No default item pre-selected
			set folderList to (choose from list ListofNames with prompt "Select Show Folders to put away:" & return & "     (Hold down Apple key for" & return & "     multiple folders)" with multiple selections allowed) as list
		end if
		--End the script if user clicks cancel
		if folderList is {false} then return
		
		--Repeat for each folder chosen
		repeat with FolderCounter from 1 to number of items in folderList
			
			--Used to skip a file and continue with rest of files selected if something bad happens
			set SkipButton to "Continue"
			
			--Get folder to put away
			set PutAwayFolder to item FolderCounter of folderList
			
			try --See if there are any files in the Show Code folder on the server
				set StrayFiles to (name of every file of (every folder of folder PutAwayFolder of folder ServerShowPath whose name is not "JP"))
				if StrayFiles is {} then set StrayFiles to ""
				
				--If files exist, then ask if user wants to skip this file or continue
				if StrayFiles ­ "" then
					set SkipButton to button returned of (display dialog "The " & PutAwayFolder & " folder on MAC_SERVER contains documents.  Are you sure you want to REPLACE this folder?" buttons {"Skip", "Continue"} default button 1 with icon caution)
				end if
				
			on error --If folder doesn't exist on Server, then tell user this show will be skipped
				set SkipButton to button returned of (display dialog "The " & PutAwayFolder & " folder on MAC_SERVER does not exist.  Make sure it hasn't been moved to a Closing Date folder and try again." buttons {"Skip", "Find"} default button 1 with icon note)
			end try
			
			if SkipButton is "Find" then
				
				try --Let user select the Closing Folder that contains the Show Folder
					set ServerShowPath to ServerShowPath & ((choose from list ((name of every folder of folder ServerShowPath whose name ends with "Close") as list) with prompt "Select the Show CLOSING folder that contains the Show Folder") as list) as text
				on error
					set SkipButton to "Skip"
				end try
			end if
			
			if SkipButton is not "Skip" then
				
				try --Delete all folders in ShowCode folder on the server except for JP folder
					delete (every folder of folder PutAwayFolder of folder ServerShowPath whose name is not "JP" and name is not "WEB" and name is not "IMPO" and name does not start with "Imposed on ")
				on error
					--Let user skip this file or continue if there is no placeholder folder on the server
					set SkipButton to button returned of (display dialog "The " & PutAwayFolder & " placeholder folder is not on the server.  This is unusual, but you can continue putting away this catalog." buttons {"Skip", "Continue"} default button 2 with icon caution)
				end try
				
			end if
			
			if SkipButton is not "Skip" then
				
				--Create a Show Folder on the server if one does not exist
				if not (exists folder PutAwayFolder of folder ServerShowPath) then make folder in folder ServerShowPath with properties {name:PutAwayFolder}
				
				try --Put the CAT folder back on the server
					duplicate folder "CAT" of folder PutAwayFolder of folder LocalShowPath to folder PutAwayFolder of folder ServerShowPath
				end try
				
				try --Put the EPS Inserts folder back on the server
					duplicate folder "EPS Inserts" of folder PutAwayFolder of folder LocalShowPath to folder PutAwayFolder of folder ServerShowPath
				end try
				
				--Delete the local copy of the folder
				delete folder PutAwayFolder of folder LocalShowPath
				
			end if
			
		end repeat
		
	end timeout
	
end tell

beep 2 --Let the user know it's finished