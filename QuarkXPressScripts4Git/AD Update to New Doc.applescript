--Copyright 2014 by James Lake.


tell application "QuarkXPress 2017"
	activate
	
	with timeout of 1800 seconds
		
		--Get name of old ad file
		set OldFileName to name of document 1
		set OldFilePath to file path of document 1
		set PageWidth to coerce (get page width of document 1) to real
		
		if name of every generic box of page 1 of document 1 does not contain "AdListBox" then
			
			if PageWidth is 33 then
				--Open an ad template and get name
				open file "MAC_SERVER:SHARED FILES:TEMPLATES:AD Template.qpt"
			else
				open file "MAC_SERVER:SHARED FILES:TEMPLATES:AD Template (8.5x11).qpt"
			end if
			
			set NewFileName to name of document 1
			
			tell every document --Set some view options
				--set properties to {page rule origin:{"3p6", "3p"}}
				set view scale to 100
				--set guides showing to false
			end tell
			
			--create new pages in new ad file as needed
			set CountOldPages to count of pages of document OldFileName
			set CountNewPages to count of pages of document NewFileName
			if CountOldPages > CountNewPages then
				repeat until CountNewPages = CountOldPages
					tell document NewFileName to make new page at beginning
					set CountNewPages to CountNewPages + 1
				end repeat
			end if
			
			--Repeat once for each page in the old ad file
			repeat with PageCounter from 1 to CountOldPages
				
				--Change to item tool
				set tool mode of every document to drag mode
				
				--Select all items of old ad file
				set selected of (every generic box of page PageCounter of document OldFileName) to true
				
				--Copy selected items to new ad file
				copy every generic box of page PageCounter of document OldFileName to beginning of page PageCounter of document NewFileName
				
			end repeat
			
			--Close the old ad file
			close document OldFileName saving no
			
		else
			display dialog "Wrong script!  Do not try to update Ad Listing Sheets." buttons {"Cancel"} default button 1 with icon stop
		end if
		
	end timeout
	
end tell

--Delete the old ad file
tell application "Finder" to move file OldFilePath to trash

--Let user know script is finished
beep 2