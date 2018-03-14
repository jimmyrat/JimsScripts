--Copyright 1997 by James Lake.


tell application "QuarkXPress 2017"
	--Make sure a document is open
	if document 1 exists then
		try --Ask the user for name, then name selected box
			if (count of (every generic box of document 1 whose selected is true)) = 1 then
				set BoxName to name of current box of document 1
			else
				set BoxName to ""
			end if
			set name of every generic box of current page of document 1 whose selected is true to text returned of (display dialog "What name?" default answer BoxName buttons {"Cancel", "OK"} default button 2 with icon note)
		on error --Tell user to select a box first
			display dialog "You need to have a text or picture box selected before running this script." buttons "Cancel" default button 1 with icon stop
		end try
	else --If no document is open, then tell user and quit
		display dialog "This script requires an" & return & "open QuarkXPress document." buttons "Cancel" default button 1 with icon stop
	end if
end tell

beep 2 --Let the user know it's finished