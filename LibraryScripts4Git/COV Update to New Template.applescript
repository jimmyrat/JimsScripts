--Copyright 2014 by James Lake.


--Need to make sure CurrentDay is not larger than number of days in that month DONE 1/11/2018
--Name the new file with the folder name, not the code from the old file name DONE 1/12/18
--Update the cover graphic to 20171227 xxxx graphic.tif, if it exists DONE 1/12/18
--Need to match Master Page in new doc (ie: Saddle-stitch) DONE 1/12/18


tell application "QuarkXPress 2017"
	activate
	with timeout of 1800 seconds
		
		if exists document 1 then
			
			--Get the closest upcoming wednesday for closing date
			set today to current date
			set twd to weekday of today
			if twd is 4 then
				set d to 7
			else
				set d to (7 + 4 - twd) mod 7
			end if
			set NextWednesday to today + (d * days)
			set FirstShortDate to (NextWednesday's year) * 10000 + (NextWednesday's month) * 100 + (NextWednesday's day)
			
			set ClosingDate to text returned of (display dialog "Enter the Closing Date" default answer FirstShortDate default button 2 with icon note)
			
			--Get the name of the original document
			set OldDocName to name of document 1
			
			--Get the path to the original document
			set DocPath to text 1 through -((count of characters of OldDocName) + 1) of ((file path of document OldDocName) as text)
			set FolderCode to text -5 through -2 of DocPath
			
			--Set the name of the new document
			set NewDocName to ((ClosingDate & " " & FolderCode & " COV.qxp") as text)
			
			try --Update the main graphic, if it exists
				tell (picture box 2 of document OldDocName whose name is "BackgroundBox")
					if (file path of image 1 as text) ends with " graphic.tif" then
						set image 1 to file ((DocPath & ClosingDate & " " & FolderCode & " graphic.tif") as text)
					end if
				end tell
			end try
			
			--Open the Rena Mach5 template
			tell application "Finder" to open alias "Macintosh HD:GRAPHICS 4:TEMPLATES:Cover (Mach5) Cover Template.qpt"
			
			delay 1
			
			--Get the name of the Rena Mach5 document
			set TemplateName to name of document 1
			
			--Delete the existing boxes
			set locked of every generic box of spread 1 of document TemplateName to false
			delete every generic box of spread 1 of document TemplateName
			
			--Repeat once for each page in the original document
			repeat with PageCounter from 1 to count of every page of document OldDocName
				show page PageCounter of document OldDocName
				
				--Make new page in Rena Mach5 document
				if PageCounter > 1 then tell document TemplateName to make new spread at end
				show page PageCounter of document TemplateName
				
				set OldMasterName to name of master spread of page PageCounter of document OldDocName
				if OldMasterName is "B-Inside" then
					set master spread of every page of last spread of document TemplateName to spread 4 of master document TemplateName
				else if OldMasterName is "C-Cover Saddle Stitch" then
					set master spread of every page of last spread of document TemplateName to spread 2 of master document TemplateName
				else if OldMasterName is "D-Inside Saddle Stitch" then
					set master spread of every page of last spread of document TemplateName to spread 3 of master document TemplateName
				end if
				
				--Show the original document
				show document OldDocName
				
				delay 1
				
				--Make sure nothing is selected
				set selection of document OldDocName to null
				
				--Change to item tool
				set tool mode of every document to drag mode
				
				--Select all items of original document
				set selected of (every generic box of page PageCounter of document OldDocName whose name does not start with "Master") to true
				
				--Group and name the items
				set name of group box 1 of page PageCounter of document OldDocName to "George"
				set grouped of group box "George" of page PageCounter of document OldDocName to true
				
				--Get the coordinates of selected items
				--set GroupOrigin to (origin of bounds of group box "George" of page PageCounter of document OldDocName) as list
				set OriginY to 0 --(coerce (item 1 of GroupOrigin) to integer) + 1.5
				if OldDocName does not contain "Inside" then
					set OriginX to "-1p" --(coerce (item 2 of GroupOrigin) to integer) + 39
				else --Inside ad
					set OriginX to "5p"
				end if
				
				--Copy selected items to Rena Mach5 document
				copy group box "George" of page PageCounter of document OldDocName to beginning of page PageCounter of document TemplateName
				set origin of bounds of group box "George" of page PageCounter of document TemplateName to {OriginY, OriginX}
				set grouped of group box "George" of page PageCounter of document TemplateName to false
				
			end repeat
			
			--Close document
			close document OldDocName without saving
			
			--Delete existing file if it exists
			tell application "Finder"
				if exists file ((DocPath & NewDocName) as text) then
					if button returned of (display dialog "The file " & NewDocName & " already exists.  Do you want to replace it?" buttons {"Cancel", "OK"} default button 2 with icon note) then
						move file ((DocPath & NewDocName) as text) to trash
					end if
				end if
			end tell
			
			--Save the new file to folder then close and open to keep Quark from crashing
			save document TemplateName in ((DocPath & NewDocName) as text) without template
			close document ((NewDocName) as text)
			delay 1
			open file ((DocPath & NewDocName) as text)
			
		else
			display dialog "You must have an open Catalog Cover QuarXPress document open before running this script." buttons {"Cancel"} default button 1 with icon stop
		end if
		
	end timeout
end tell


beep 2 --Let user know it's finished