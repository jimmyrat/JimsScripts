--Copyright 2005 by James Lake.


tell application "QuarkXPress 2017"
	--activate
	
	tell document 1
		
		set ScaleLimit to null
		repeat until ScaleLimit is not null
			set HorScale to horizontal scale of (paragraph 1 of selection) as integer
			set ScaleLimit to text returned of (display dialog "What is the minimum scale percentage?" default answer (HorScale - 10) buttons {"Cancel", "OK"} default button 2 with icon note) as integer
			set OldHorScale to HorScale
			if ScaleLimit = HorScale then
				display dialog "That is the current horizontal scale.  Input a lower value." buttons {"OK"} default button 1 with icon note
				set ScaleLimit to null
			else if ScaleLimit > HorScale then
				display dialog "That is larger than the horizontal scale.  Input a lower value." buttons {"OK"} default button 1 with icon note
				set ScaleLimit to null
			else if ScaleLimit < 10 then
				display dialog "That is smaller than Quark's horizontal scale minimum.  Input a higher value." buttons {"OK"} default button 1 with icon note
				set ScaleLimit to null
			end if
		end repeat
		
		set LineCount to count of lines of paragraph 1 of selection
		if LineCount = 1 then display dialog "This paragraph already has only one line." buttons {"Cancel"} default button 1 with icon stop
		
		repeat until (count of lines of selection) = LineCount - 1
			set HorScale to HorScale - 1
			if HorScale < ScaleLimit then
				set horizontal scale of paragraph 1 of selection to OldHorScale
				display dialog "minimum scale limit reached." buttons {"OK"} default button 1
				exit repeat
			end if
			set horizontal scale of paragraph 1 of selection to HorScale
		end repeat
		
	end tell
	
end tell

beep 2 --Let user know its finished