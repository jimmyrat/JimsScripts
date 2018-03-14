--Copyright 1997 by James Lake.


global ShowCode, ShowName, LongShowDate, MidShowDate, ShortShowDate, ShowDate, PaperSize, DoCards, DoLabels, DoList, BoxResults, TempFile, Logo, BreedCounter, Breed, CardNumber, ThisComputer, DesktopFolder, TrophyCardTemplate, TrophyLabelTemplate, TrophyListTemplate


script FormatText
	
	tell application "QuarkXPress 2017"
		
		
	end tell
	
end script


tell application "QuarkXPress 2017"
	activate
	
	--Make sure a document is open
	if not (exists document 1) then display dialog "Please open a Premium List document before running this script." buttons "Cancel" default button 1 with icon stop
	--Make sure a text box is selected
	if not (exists current box) then display dialog "Please click in the first linked text box that contains the prizes before running this script," buttons "Cancel" default button 1 with icon stop
	--Make sure the selected text box contains prizes with correct style sheets
	if (count of (paragraphs of story 1 of current box of document 1 whose paragraph style is "PL-PrizeBreed")) = 0 then display dialog "Breed names in the breed prizes need to be set to the PL-PrizeBreed style sheet" buttons "Cancel" default button 1 with icon stop
	if (count of (paragraphs of story 1 of current box of document 1 whose paragraph style is "PL-Prize")) = 0 then display dialog "'Offered by' lines in the breed prizes need to be set to the PL-Prize style sheet" buttons "Cancel" default button 1 with icon stop
	--Make sure that all the "each class" lines are listed individually
	if (count of (paragraphs of story 1 of current box of document 1 whose paragraph style is "PL-Prize" and it contains "in each class")) > 0 then
		set color of (every paragraph of story 1 of current box of document 1 where it contains "in each class") to "Red"
		display dialog "Please list 'IN EACH CLASS' prizes separately." buttons "Cancel" default button 1 with icon stop
	end if
	--Make sure last paragraph isn't blank
	if (count of characters of paragraph -1 of story 1 of current box of document 1) < 1 then delete character -1 of story 1 of current box of document 1
	
	--Set all the variables, including user input
	set ThisComputer to "Macintosh HD"
	set DesktopFolder to (path to desktop) as text
	set ShowName to (text returned of (display dialog "Enter Club Name:" default answer "" buttons {"Cancel", "OK"} default button 2 with icon note))
	set ShowCode to uppercase (text returned of (display dialog "Enter Show Code:" default answer (uppercase (characters 1 through 4 of ShowName as text)) buttons {"Cancel", "OK"} default button 2 with icon note))
	set ShowDate to (text returned of (display dialog "Enter Show Date:" default answer "" buttons {"Cancel", "OK"} default button 2 with icon note))
	set DoCards to true
	set DoLabels to true
	set DoList to true
	set TrophyCardTemplate to alias "MAC_SERVER:SHARED FILES:TEMPLATES:Trophy Card Template.qpt"
	set TrophyLabelTemplate to alias "MAC_SERVER:SHARED FILES:TEMPLATES:Trophy Label Template.qpt"
	set TrophyListTemplate to alias "MAC_SERVER:SHARED FILES:TEMPLATES:Trophy List Template.qpt"
	set Logo to (("MAC_SERVER:LOGOS: CODED LOGOS:" & ShowCode) as text)
	set TempFile to (((path to desktop) & "temp.txt") as text)
	set BreedCounter to 1
	set Breed to ""
	set CardNumber to 1
	
end tell

set ShowMM to month of date ShowDate as integer
if ShowMM < 10 then set ShowMM to "0" & ShowMM
set ShowDD to day of date ShowDate
if ShowDD < 10 then set ShowDD to "0" & ShowDD
set ShowYY to text 3 through 4 of ((year of date ShowDate) as text)
set ShortShowDate to (ShowMM & ShowDD & ShowYY) as text
set MidShowDate to ((month of date ShowDate & " " & day of date ShowDate & ", " & year of date ShowDate) as text)
set LongShowDate to date string of date ShowDate

tell application "QuarkXPress 2017"
	activate
	
	--Prepares the text of the selected text box for importing
	tell current box of document 1
		
		try --Makes sure the Junior Show and Obedience Breed & Special prizes are included
			set style sheet of every paragraph of story 1 whose style sheet is "PL-Header" and it starts with "junior" or it starts with "obedience" to "PL-PrizeBreed"
		end try
		try --Deletes the unneeded lines
			delete (every paragraph of story 1 whose style sheet is not "PL-PrizeBreed" and style sheet is not "PL-Prize")
		end try
		--Inserts the XTAG style sheet codes to the correct lines
		copy "@Breed:" to before (every paragraph of story 1 whose style sheet is "PL-PrizeBreed")
		copy "@Class:" to before (every paragraph of story 1 whose style sheet is "PL-Prize")
		set every text of story 1 where it is " - " to (return & "@Prize:")
		
		try
			repeat --repeat for each line until a blank line is reached
				--Gets the name of the Breed, then deletes it because the next IF will add it in front of every Class line
				if paragraph BreedCounter of story 1 begins with "@Breed" then
					set Breed to (characters 1 through -2 of paragraph BreedCounter of story 1) as text
					delete paragraph BreedCounter of story 1
					--Inserts the name of the Breed before every Class line
				else if paragraph BreedCounter of story 1 begins with "@Class" then
					copy "@Number:" & CardNumber & return to before paragraph BreedCounter of story 1
					set CardNumber to CardNumber + 1
					copy Breed & return to before paragraph (BreedCounter + 1) of story 1
					set BreedCounter to BreedCounter + 3
					--Just skips over the prize to the next Breed or Class line
				else if paragraph BreedCounter of story 1 begins with "@Prize" or paragraph BreedCounter of story 1 begins with "@Number" then
					set BreedCounter to BreedCounter + 1
				else
					exit repeat
				end if
			end repeat
		end try
		
		--Inserts the XTAGS start code
		copy ("<v9.10><e8>" & return) to before character 1
		
		--Saves the text to a file in the trash
		save story 1 in file TempFile
		
	end tell
	
	--Close the original document without saving changes
	close document 1 without saving
	
	--Sets up the Trophy Cards
	if DoCards is true then
		
		--Open the template
		open TrophyCardTemplate
		
		tell (every picture box of page 1 of spread 1 of master document 1 whose name is "Logo")
			try --Place the logo matching the show code into the picture box on master page
				try
					set image 1 to alias ((Logo & ".tif") as text)
				on error
					set image 1 to alias ((Logo & ".jpg") as text)
				end try
			on error --If script can't find logo on server, ask user to find one
				set image 1 to (choose file of type {"TIFF", "EPSF", "JPEG"} with prompt "Can't find the " & ShowCode & " club logo - please choose the correct logo.")
			end try
			--Size the picture to the picture box
			set bounds of image 1 to proportional fit
		end tell
		
		--Inserts the club name and date into the text box on the master page
		set paragraph 1 of (every text box of page 1 of spread 1 of master document 1 whose name is "Club/Date") to ShowName & return
		set paragraph 2 of (every text box of page 1 of spread 1 of master document 1 whose name is "Club/Date") to LongShowDate
		--Gets the text from the file saved in the trash
		set story 1 of text box "StartBox" of page 1 of document 1 to file TempFile
		--Makes sure all the pages are showing
		show character -1 of story 1 of text box "StartBox" of page 1 of document 1
		show page 1 of document 1
		
		--Save the document onto the desktop
		save document 1 in DesktopFolder & ShowCode & " " & ShortShowDate & " Trophy Cards.qxp" as document without template
		
	end if
	
	--Sets up the Trophy Labels
	if DoLabels is true then
		
		--Open the template
		open TrophyLabelTemplate
		
		--Inserts the club name into the text box on the master page
		set story 1 of (every text box of page 1 of spread 1 of master document 1 whose name is "Club/Date") to ShowName
		--Gets the text from the file saved in the trash
		set story 1 of text box "StartBox" of page 1 of document 1 to file TempFile
		--Makes sure all the pages are showing
		show character -1 of story 1 of text box "StartBox" of page 1 of document 1
		show page 1 of document 1
		
		--Save the document onto the desktop
		save document 1 in DesktopFolder & ShowCode & " " & ShortShowDate & " Trophy Labels.qxp" as document without template
		
	end if
	
	--Sets up the Trophy List
	if DoList is true then
		
		--Open the template
		open TrophyListTemplate
		
		--Inserts the club name and date into the text box on the master page
		set story 1 of (every text box of page 1 of document 1 whose name is "Club/Date") to ShowName & " ¥ " & MidShowDate
		--Gets the text from the file saved in the trash
		set story 1 of text box "StartBox" of page 1 of document 1 to file TempFile
		
		--Place a checkbox in front of each breed
		repeat with ParaCounter from 1 to count of paragraphs of story 1 of text box "StartBox" of page 1 of document 1
			if name of style sheet of paragraph ParaCounter of story 1 of text box "StartBox" of page 1 of document 1 is "Breed" then copy story 1 of text box "CheckBox" of page 1 of document 1 to before paragraph ParaCounter of story 1 of text box "StartBox" of page 1 of document 1
		end repeat
		delete text box "CheckBox" of page 1 of document 1
		
		--Makes sure all the pages are showing
		show character -1 of story 1 of text box "StartBox" of page 1 of document 1
		show page 1 of document 1
		
		--Save the document onto the desktop
		save document 1 in DesktopFolder & ShowCode & " " & ShortShowDate & " Trophy List.qxp" as document without template
		
	end if
	
end tell

tell application "Finder"
	delete file TempFile
end tell

beep 2 --Let the user know it's finished