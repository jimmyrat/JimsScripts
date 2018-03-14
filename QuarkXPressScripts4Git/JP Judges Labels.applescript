--Copyright 2005 by James Lake.


--set some variables
set JudgeLabelTemplate to "MAC_SERVER:SHARED FILES:TEMPLATES:Judge Label Template.qpt"
set SavePath to path to desktop folder as text
set JudgeName to ""
set NewJudgeList to ""

tell application "QuarkXPress 2017"
	activate
	
	with timeout of 1800 seconds
		
		--Check to make sure a JP is open
		if (exists document 1) and (name of document 1 contains "JP") then
			--Get name of JP
			set ShowCode to (text 1 through 5 of ((name of document 1) as text) as text)
			if last character of ShowCode is " " then set ShowCode to text 1 through 4 of ShowCode
			--Get name of document for header
			set HeaderText to ("Judge Labels from " & ShowCode) as text
			--Check to make sure text is selected and contains a tab
			if selection contains tab then
				--Get the selected paragraphs
				set ListOfJudges to every paragraph of selection
				--Repeat once for each selected paragraph
				repeat with ParaCounter from 1 to count of items of ListOfJudges
					--Repeat once for each character in each paragraph, stopping at the first tab
					repeat with CharCounter from 1 to count of characters in item ParaCounter of ListOfJudges
						--Check to see if character is a tab
						if character CharCounter of item ParaCounter of ListOfJudges is not tab then
							--Add the character to the Judge Name
							set JudgeName to JudgeName & character CharCounter of item ParaCounter of ListOfJudges
						else --Exit repeat when tab is reached
							exit repeat
						end if
					end repeat
					--Replace the paragraph with just the Judge Name
					set NewJudgeList to NewJudgeList & JudgeName & return
					--Empty the variable for the next Judge name
					set JudgeName to ""
				end repeat
			else --Let user know that judge text needs to be selected
				display dialog "Please select every Judge to be included in the Labels. (Name should be separated from address by a tab)" buttons {"Cancel"} default button 1 with icon stop
			end if
		else --Let user know that JP needs to be open
			display dialog "Please open a JP from which to extract the Judges' Names." buttons {"Cancel"} default button 1 with icon stop
		end if
		
		--Open the Judge Label Template
		open file JudgeLabelTemplate
		
		try --Copy the Judges List to the label text boxes
			copy HeaderText & return & NewJudgeList to after story 1 of text box "StartBox" of document 1
		end try
		
		try --Show the last label to force it to show all the pages
			show last paragraph of story 1 of text box "StartBox" of document 1
		end try
		
		try --Place header at top of pages
			set PageCount to count of pages of document 1
			set before story 1 of text box "HeaderBox" of spread 1 of master document 1 to "page "
			set after story 1 of text box "HeaderBox" of spread 1 of master document 1 to "/" & (PageCount as text)
		end try
		
		--Save file to the Desktop
		save document 1 in (SavePath & (ShowCode & " Judge Labels.qxp") as text) as document without template
		
	end timeout
	
end tell


beep 2 --Let user know it's finished