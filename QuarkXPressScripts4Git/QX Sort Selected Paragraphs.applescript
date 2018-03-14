--Copyright 1998 by James Lake.


tell application "QuarkXPress 2017"
	activate
	--Check to make sure a document is open
	if exists document 1 then
		--Check to make sure a text box is selected
		if (exists current box) and (class of current box is text box) then
			--Check to make sure some text is highlighted
			if exists character 1 of the selection then
				--Give user a chance to cancel
				display dialog "This script sorts the selected paragraphs in the current text box.  Make sure you save the document before running this script so you can revert to saved if doesn't do what you expected." buttons {"Cancel", "OK"} default button 2 with icon note
				set NewList to ""
				set ListToSort to every paragraph of contents of the selection
				--Sort the list
				set ListToSort to sortlist ListToSort
				--Repeat once for each paragraph
				repeat with Para in ListToSort
					--Change the list back into a story
					set NewList to NewList & Para
				end repeat
				--Put the sorted text back into text box
				copy NewList to contents of the selection
			else --Let user know that no text was selected
				display dialog "Please highlight some text before running this script." buttons {"Cancel"} default button 1 with icon stop
			end if
		else --Let user know text box wasn't selected
			display dialog "Please select a text box before running this script." buttons {"Cancel"} default button 1 with icon stop
		end if
	else --Let user know Quark document wasn't open
		display dialog "You must have a Quark document open before running this script." buttons {"Cancel"} default button 1 with icon stop
	end if
end tell