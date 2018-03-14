--Copyright 1997 by James Lake.


tell application "Finder"
	activate
	
	with timeout of 1800 seconds
		
		--Set all variables that will be used later
		set CurrentUser to uppercase (characters 1 through -2 of (last word of (path to home folder as text) & ".") as text)
		set LocalShowPath to "Macintosh HD:SHOW FILES:"
		set ServerShowPath to "MAC_SERVER:SHOW FILES:"
		
		--Check to see if there are no folders in SHOW FILES on the server
		if (count of folders of folder ServerShowPath) = 0 then
			display dialog "There are no Show folders on MAC_SERVER to move here." buttons {"Cancel"} default button 1 with icon stop
			return
		end if
		
		--Get list of show code folders to put away from user
		set folderList to (choose from list ((name of every folder of folder ServerShowPath whose name does not end with "Close" and name does not end with "PL IMPOSITIONS") as list) with prompt "Choose Show Folders to move here" with multiple selections allowed) as list
		if folderList is {false} then return
		
		--Repeat for each folder chosen
		repeat with x from 1 to number of items in folderList
			
			--Get folder to put away
			set PutAwayFolder to item x of folderList
			
			--Check to see if the CAT folder is empty
			if (count of files of folder "CAT" of folder PutAwayFolder of folder ServerShowPath) ­ 0 then
				
				--Check to see if the CAT file has already been created
				if (exists (files of (folder "CAT" of folder PutAwayFolder of folder ServerShowPath) whose name ends with "CAT")) or ((not (exists (files of (folder "CAT" of folder PutAwayFolder of folder ServerShowPath) whose name ends with "CAT"))) and (button returned of (display dialog "The " & PutAwayFolder & " catalog hasn't been created yet.   Do you want to move the folder over anyway?" buttons {"Skip", "OK"} default button 1 with icon caution) is "OK")) then
					
					try --Create an empty Show Folder on this computer
						make folder in folder LocalShowPath with properties {name:PutAwayFolder}
					end try
					
					try --Move CAT folder from the server to this computer
						duplicate folder "CAT" of folder PutAwayFolder of folder ServerShowPath to folder PutAwayFolder of folder LocalShowPath
						delete every item of folder "CAT" of folder PutAwayFolder of folder ServerShowPath
					end try
					
					try --Move EPS Inserts folder from the server to this computer
						duplicate folder "EPS Inserts" of folder PutAwayFolder of folder ServerShowPath to folder PutAwayFolder of folder LocalShowPath
						delete every item of folder "EPS Inserts" of folder PutAwayFolder of folder ServerShowPath
					end try
					
					try --Move Imposition folder from the server to this computer
						duplicate folder "Imposition" of folder PutAwayFolder of folder ServerShowPath to folder PutAwayFolder of folder LocalShowPath
						delete every item of folder "Imposition" of folder PutAwayFolder of folder ServerShowPath
					end try
					
					--Rename the EPS Inserts folder on the server to indicate checker-outer
					set properties of folder "EPS Inserts" of folder PutAwayFolder of folder ServerShowPath to {name:("On " & CurrentUser & "'s Computer")}
					
					try --Open the catalog if only 1 folder was moved
						if number of items in folderList = 1 then open (first file of (folder "CAT" of folder PutAwayFolder of folder LocalShowPath) whose name ends with " CAT.qxp")
					end try
					
				end if
				
			else --Let user know CAT folder is empty
				display dialog "The " & PutAwayFolder & " CAT folder is empty.  Transfer files from AS/400 before running this script." buttons {"Skip"} default button 1 with icon stop
			end if
			
		end repeat
		
	end timeout
	
end tell

beep 2 --Let the user know it's finished