--  Created by James Lake 1997.
--  Copyright (c) 2003 beyond vision. All rights reserved.


global CurrentUser, LocalPLPath, ServerPLPath, PLTrackingFolder, ShowCode, ShowName, FolderName


--Set user-input variables
set ShowButton to display dialog "Enter Show Code and Sequence Number:" default answer "" buttons {"Cancel", "Put Away All", "OK"} default button 3
set ShowCode to uppercase (text returned of ShowButton)
set ButtonAnswer to button returned of ShowButton

--Verify the variables
if ButtonAnswer is "OK" and (ShowCode is "" or ((count of characters of ShowCode) ­ 4 and (count of characters of ShowCode) ­ 7)) then
	--Notify user that input is wrong
	display dialog "You must enter a four-letter Show Code or Show Code with Sequence Number." buttons {"OK"} default button 1
	
else if ButtonAnswer is "Put Away All" then
	tell application "Finder"
		set LocalPLPath to "Macintosh HD:PL FILES:"
		set FolderCount to count of folders of folder LocalPLPath
		repeat with x from 1 to FolderCount
			set ShowCode to name of folder 1 of folder LocalPLPath
			run MainScript --Do the MainScript subroutine
		end repeat
	end tell
	
else --Variables OK, run the script
	run MainScript --Do the MainScript subroutine
end if

beep 2 --Let the user know it's finished


script PutAway --This defines a subroutine
	
	tell application "Finder"
		activate
		with timeout of 600 seconds
			set PlaceholderFile to (file (("Checked out by " & CurrentUser) as text) of folder FolderName of ServerPLPath) as text
			try --Get name of most recently modified file
				set ModFile to (item 1 of (sort (get files of folder FolderName of folder LocalPLPath) by modification date)) as alias
				set ModName to name of ModFile
				set ModDate to modification date of ModFile
			end try
			--Create a time stamp for the current time
			set CurrentDate to (current date)
			set CurrentDay to day of CurrentDate
			set CurrentMonth to month of CurrentDate as integer
			if CurrentMonth < 10 then set CurrentMonth to ("0" & CurrentMonth) as text
			set CurrentYear to year of CurrentDate
			set DateStamp to CurrentYear & CurrentMonth & CurrentDay as text
			set t to time of (current date)
			tell (1000000 + (t div hours) * 10000 + (t mod hours div minutes) * 100 + t mod minutes) as text to set CurrentTime to text 2 thru 3 & ":" & text 4 thru 5 & ":" & text 6 thru 7
			set CurrentHour to text 1 through 2 of CurrentTime
			set CurrentMinute to text 4 through 5 of CurrentTime
			set CurrentSecond to text 7 through 8 of CurrentTime
			set DateStamp to CurrentYear & CurrentMonth & CurrentDay & " " & CurrentHour & "_" & CurrentMinute & "_" & CurrentSecond
			try --Let user know if a file was not modified today
				if date string of ModDate is not date string of CurrentDate then display dialog "The most recent file in this folder was NOT modified today:" & return & return & "     " & ModName & return & return & "If you made changes to this file or another file in this folder, they may not have been saved. Click the Cancel button and contact the Macintosh Administrator." buttons {"Cancel", "OK"} default button 2 with icon caution
			end try
			--Get the folder content information
			set FolderList to (LocalPLPath & FolderName)
			set the ItemList to list folder FolderList without invisibles
			set FolderList to FolderList as string
			set FinishedList to {}
			--Create a list of files in the PL folder with modification dates
			repeat with i from 1 to number of items in the ItemList
				set FolderItem to item i of the ItemList
				set FolderItem to (FolderList & ":" & FolderItem) as alias
				set FileInfo to info for FolderItem
				set FileDate to modification date of FileInfo
				set FinishedList to FinishedList & (FolderItem as text) & " modified on " & FileDate & return
			end repeat
			set FinishedList to FinishedList as text
			try --Put the folder content information into the PL tracking file
				open for access file PlaceholderFile with write permission
				set eof of file PlaceholderFile to 0
				write FinishedList to file PlaceholderFile
				--Close the file
				close access file PlaceholderFile
			on error --Close the file and notify user
				close access file PlaceholderFile
				beep 2
				display dialog "Sorry, something bad happened while editing the file." buttons {"Cancel"} default button 1 with icon stop
			end try
			try --Move the placeholder folder to the PL tracking folder on the server
				set PLAction to "" --choose from list {"typed", "corrected", "club corrections", "imposed"} with title "PL Put Away" with prompt "Reason for checking out the PL?" OK button name "OK" cancel button name "Cancel"
				move file PlaceholderFile to PLTrackingFolder
				set name of file (("Checked out by " & CurrentUser) as text) of PLTrackingFolder to ((FolderName & " " & DateStamp & "" & PLAction & " by " & CurrentUser) as text)
			on error --Delete the placeholder folder so future placeholders can be moved here
				delete file (("Checked out by " & CurrentUser) as text) of PLTrackingFolder
			end try
			try --Delete the empty folder on the server
				delete folder FolderName of ServerPLPath
			end try
			--Copy the folder from this computer to the server
			move folder FolderName of folder LocalPLPath to ServerPLPath
			--Move the local copy of the folder to the trash
			delete folder FolderName of folder LocalPLPath
		end timeout
	end tell
	
end script


script CheckOut --This defines a subroutine
	
	tell application "Finder"
		activate
		with timeout of 600 seconds
			--Move the folder from the server to this computer
			move folder FolderName of ServerPLPath to folder LocalPLPath
			--Delete the original folder on the server
			delete folder FolderName of ServerPLPath
			--Create a placeholder folder on the server
			make folder in ServerPLPath with properties {name:FolderName}
			make file in folder FolderName of ServerPLPath with properties {name:("Checked out by " & CurrentUser)}
		end timeout
	end tell
	
end script


script MainScript --This defines a subroutine
	
	--Set all variables that will be used later
	set CurrentUser to uppercase ((system attribute "USER") as text)
	set LocalPLPath to "Macintosh HD:PL FILES:"
	tell application "System Events"
		if not (exists alias "MAC_SERVER:") then mount volume "MAC_SERVER" on server "MAC_SERVER"
	end tell
	set ServerPLPath to alias "MAC_SERVER:PL FILES:"
	set PLTrackingFolder to alias "MAC_SERVER:PL FILES: TRACKING FOLDER"
	tell application "System Events"
		set ShowName to (name of every folder of ServerPLPath whose name starts with ShowCode) as text
	end tell
	set FolderName to ShowName as text
	
	tell application "Finder"
		
		--Not on local, checked out by user on Server
		if (not (exists folder FolderName of folder LocalPLPath)) and (exists file ("Checked out by " & CurrentUser) of folder FolderName of ServerPLPath) then
			display dialog "The " & ShowCode & " folder is already checked out to this computer, but is not in the PL FILES folder.  This could indicate a serious problem." buttons "Quit" default button 1 with icon stop
			
			--Not on local, checked out by other on Server
		else if (not (exists folder FolderName of folder LocalPLPath)) and (exists (file 1 of folder FolderName of ServerPLPath whose name starts with "Checked out by ")) then
			set Borrower to text 16 through -1 of (get name of file 1 of folder FolderName of ServerPLPath)
			display dialog "The " & ShowCode & " folder is already checked out by " & Borrower & "." buttons "Quit" default button 1 with icon stop
			
			--Not on local, on Server
		else if (not (exists folder FolderName of folder LocalPLPath)) and (exists folder FolderName of ServerPLPath) then
			run CheckOut --Do the CheckOut subroutine
			
			--On local, Checked out by user on Server, Placeholder folder contains files
		else if (exists folder FolderName of folder LocalPLPath) and (exists file ("Checked out by " & CurrentUser) of folder FolderName of ServerPLPath) and ((count of items of folder FolderName of ServerPLPath) > 1) then
			display dialog "Files have been placed in the Placeholder folder on the Server and must be moved to your computer before PL is put away." buttons "Quit" default button 1 with icon stop
			
			--On local, checked out by user on Server
		else if (exists folder FolderName of folder LocalPLPath) and (exists file ("Checked out by " & CurrentUser) of folder FolderName of ServerPLPath) then
			run PutAway --Do the PutAway subroutine
			
			--On local, checked out by other on Server
		else if (exists folder FolderName of folder LocalPLPath) and (exists (file 1 of folder FolderName of ServerPLPath whose name starts with "Checked out by ")) then
			set Borrower to text 16 through -1 of (get name of file 1 of folder FolderName of ServerPLPath)
			display dialog "The " & ShowCode & " folder  is on this computer, but is also checked out from the Server by " & Borrower & ".  This could indicate a serious problem." buttons "Quit" default button 1 with icon stop
			
			--On local, not on Server
		else if (exists folder FolderName of folder LocalPLPath) and (not (exists folder FolderName of ServerPLPath)) then
			set DlgInfo to button returned of (display dialog "The " & ShowCode & " folder did not have a placeholder on the Server.  This is unusual, but happens with new PLs." buttons {"Quit", "OK"} default button 2 with icon note)
			if DlgInfo is not "Quit" then run PutAway --Do the PutAway subroutine
			
			--Not on local, not on Server
		else if (not (exists folder FolderName of folder LocalPLPath)) and (not (exists folder FolderName of ServerPLPath)) then
			display dialog "The " & ShowCode & " folder was not found on this computer or on the Server.  Please try a different Show Code or include the Sequence Code" buttons "Quit" default button 1 with icon stop
			
			--On local, on Server
		else if (exists folder FolderName of folder LocalPLPath) and (exists folder FolderName of ServerPLPath) then
			display dialog "The " & ShowCode & " folder is on this computer, and also on the Server.  This could indicate a serious problem." buttons "Quit" default button 1 with icon stop
			
		end if
		
	end tell
	
end script