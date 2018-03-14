(*
	Copyright © 1994-2006 - All Rights Reserved
	Quark, Inc.
	http://www.Quark.com

	Copying and sharing of this script in whole or in part is allowed.  The authors are 
	not responsible for any losses caused by the use of or failure of this software.
*)

tell application "QuarkXPress 2017"
	activate
	
	try
		-- This line allows the user to specify a folder into which the EPS files will be saved
		set DestFolder to (choose folder with prompt "Select a folder in which to the save the EPS files.") as text
		
		-- This section will parse the document name, to use when saving the EPS files
		tell document 1
			set DocName to name as text
			set olddelims to AppleScript's text item delimiters
			set AppleScript's text item delimiters to " :"
			try
				set DocName to item 1 of (text items 1 thru -2 of DocName)
				set AppleScript's text item delimiters to olddelims
			on error errmsg
				set AppleScript's text item delimiters to olddelims
				log errmsg
			end try
			set AppleScript's text item delimiters to "."
			if text item -1 of DocName = "qxd" then
				try
					set DocName to text items 1 thru -2 of DocName
					set AppleScript's text item delimiters to olddelims
				on error errmsg
					set AppleScript's text item delimiters to olddelims
					log errmsg
				end try
			end if
			
			-- This section will cycle through the pages and save each as an EPS
			try
				set overwrite to null
				set curPage to page number of current page
				set pageCnt to count of pages
				repeat with i from 1 to count of pages
					-- This section will create the sequential number for the file
					set fileNum to ""
					repeat until (length of (fileNum as text)) = (length of (pageCnt as text))
						if fileNum = "" then
							set fileNum to i
						else
							set fileNum to "0" & fileNum
						end if
					end repeat
					
					-- This line will create the name for the file
					set FilePath to DestFolder & DocName & "_" & fileNum & ".eps"
					
					-- This following line will invoke a dialog for the first file whose name already exists
					-- This selection will be applied to subsequent files, so the dialog won't be display again
					set overwrite to my ifFileExists(FilePath, overwrite)
					
					-- The following section performs the save, if appropriate
					if overwrite is true or overwrite is null or overwrite is "temp" then
						show page i
						save page i in FilePath EPS format Standard EPS EPS data binary EPS OPI include images scale 100 bleed "p0" Output Setup "as is" with transparent page and include preview
					else if overwrite is "Quit" then
						-- The user cancelled from the duplicate file notification dialog
						-- This will end the script
						error "User canceled" number -128
					end if
				end repeat
				
				-- The following beep will provide feedback of script completion
				beep 2
			on error errmsg number errnum
				error errmsg number errnum
			end try
		end tell
	on error errmsg number errnum
		if errnum is -108 then
			beep
			display dialog errmsg & return & return & Â
				"Try allocating more memory to " & name & "." buttons {"OK"} default button 1 with icon stop
			return
		else if errnum is not -128 then
			beep
			display dialog errmsg & " [" & errnum & "]" buttons {"OK"} default button 1 with icon stop
		end if
		return
	end try
end tell

--=================================== Handlers =========================================
-- Below is the handler (subroutine) that is called from the above script
--===================================================================================

on ifFileExists(FilePath, bOverWrite)
	if bOverWrite is null then
		-- This section will check to see if a file exists, until a matching name has been found
		tell application "Finder"
			if exists alias FilePath then
				tell application "QuarkXPress 2017"
					set overwrite to button returned of (display dialog "A file(s) with the same name already exists at this location. Saving will delete the existing file(s)." & return & return & Â
						"Do you want to save anyway?" buttons {"Cancel", "Don't Save", "Save"} default button "Save" with icon caution)
				end tell
				if overwrite is "Save" then
					return true
				else if overwrite is "Don't Save" then
					return false
				else if overwrite is "Cancel" then
					return "Quit"
				end if
			else
				return null
			end if
		end tell
	else if bOverWrite is true then
		-- This section will keep creating files regardless of whether the names already exist
		return true
	else if bOverWrite is false or bOverWrite is "temp" then
		try
			tell application "Finder"
				if exists alias FilePath then
					-- This line will ensure that files whose names already exist are not created, 
					-- if you user previous chose to skip such file
					return false
				else
					-- This line will ensure that files whose names don't already exist will be created, 
					-- if the user previously chose to not overwrite existing files
					return "temp"
				end if
			end tell
		on error errmsg number errnum
			beep
			display dialog errmsg & " [" & errnum & "]" buttons {"Cancel"} default button 1 with icon stop
			return
		end try
	end if
end ifFileExists
