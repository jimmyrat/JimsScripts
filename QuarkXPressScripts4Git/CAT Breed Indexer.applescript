--Copyright 1996 by James Lake.


global GroupFileList, GroupFileCount, CATPath, CancelScipt, header, DocName, AnchorList, BreedList


script CheckAnchored --This defines a subroutine
	
	tell application "QuarkXPress 2017"
		activate
		
		try
			repeat with AnchorCounter from 1 to count of items in AnchorList
				--Only get unique page numbers
				if AnchorPageList does not contain (name of page 1 of (item AnchorCounter of AnchorList)) then
					--Put comma in between page numbers
					if AnchorCounter > 1 then set AnchorPageList to AnchorPageList & ", "
					--Get the page number
					set AnchorPageList to AnchorPageList & (name of page 1 of (item AnchorCounter of AnchorList))
				end if
			end repeat
			--Notify user and cancel
			if button returned of (display dialog "There are anchored text boxes on pages " & AnchorPageList & " that may lock up this script.  You can continue if these are not in the catalog entries (ie: within agility)." buttons {"Stop", "Continue"} default button 2 with icon caution) is "Stop" then set CancelScript to true
		end try
		
	end tell
	
end script


script OrderGroups --This defines a subroutine
	
	--Duplicate this variable for reordering
	copy GroupFileList to FileListOrdered
	
	--Check to see if reordering is necessary
	set ReorderGroups to false
	
	repeat with GroupCodeCounter from 1 to GroupFileCount
		
		if GroupCodeCounter = 1 then
			set GroupCode to (text 4 through 7 of item GroupCodeCounter of FileListOrdered)
		else
			if text 4 through 7 of item GroupCodeCounter of FileListOrdered ­ GroupCode then
				set ReorderGroups to true
				exit repeat
			end if
		end if
		
	end repeat
	
	if ReorderGroups is true then
		
		repeat with GrpFileCounter from 1 to (count of items of GroupFileList)
			activate --Let the user choose the files in catalog order
			
			if (count of items of GroupFileList) = 1 then
				set item GrpFileCounter of FileListOrdered to item 1 of GroupFileList
				exit repeat
			else
				
				set FileToCheck to (choose from list GroupFileList with prompt "Choose file " & GrpFileCounter)
				
				--If cancel button is clicked then quit script and notify user
				if FileToCheck is false then
					with timeout of 3600 seconds
						tell me to quit (activate)
						display dialog "The CAT Pasteup script was canceled." buttons {"Cancel"} default button 1 with icon stop
						tell me to quit
					end timeout
				end if
				
				--Repeat once for each item left in list
				repeat with GrpItemCounter from 1 to count of items of GroupFileList
					
					--Check to see if this item contains FileToCheck
					if item GrpItemCounter of GroupFileList contains FileToCheck then
						--Put this item in its correct place
						set item GrpFileCounter of FileListOrdered to item GrpItemCounter of GroupFileList
						--Remove the item from the list after it is chosen
						set GroupFileList to exclude items (item GrpItemCounter of GroupFileList) from GroupFileList
						exit repeat
					end if
					
				end repeat
				
			end if
			
		end repeat
		
		--Set the final info into the correct variable
		copy FileListOrdered to GroupFileList
		
	end if
	
	return GroupFileList
	
end script


script BreedIndexer --This defines a subroutine
	
	tell application "QuarkXPress 2017"
		activate
		
		
	end tell
	
end script


tell application "SKProgressBar"
	
	set title to "CAT Breed Indexer"
	set header to "Preparing catalog for indexing..."
	set footer to "Copyright 1996 James Lake"
	set footer alignment to center
	--set image path to iconPath
	set show window to true
	
	activate
	
	tell progress bar
		set indeterminate to true
		start animation
	end tell
	
end tell


tell application "QuarkXPress 2017"
	activate
	
	--Set some variables
	set DocName to name of document 1
	set ShowCode to text 1 through 4 of DocName
	
	--Set some variables
	set ParaCounter to 1
	
	--Check for StartBox
	if not (exists text box "StartBox" of page 1 of document DocName) then
		--Check to see if selected text box can be used without intervention
		if (exists current box) and (exists story 1 of current box) and (box wraps of current box is true) and ((count of (every paragraph of current box whose name of paragraph style is "Breed/Class,Large")) > 1) then
			set name of current box to "StartBox"
		else
			display dialog "The starting text box on page 1 has been deleted.  Please select a text box that contains catalog entries and run this script again." buttons {"Cancel"} default button 1 with icon stop
		end if
	end if
	
end tell

tell application "Finder"
	--Set some variables
	set ThisComputer to path to startup disk
	try
		set CATPath to alias ((ThisComputer & "SHOW FILES:" & ShowCode & ":CAT:") as text)
	on error
		set CATPath to alias (("MAC_SERVER:SHOW FILES:" & ShowCode & ":CAT:") as text)
	end try
	set AnchorPageList to ""
	set CancelScript to false
end tell

tell application "QuarkXPress 2017"
	activate
	
	--Check to make sure a catalog is open
	if number of documents = 0 or text -5 through -7 of DocName is not "CAT" then display dialog "Please open a catalog before running this script." buttons {"Cancel"} default button 1 with icon stop
	
	try --Check for anchored text boxes
		set AnchorList to object reference of (every generic box of document DocName whose anchored is true)
	end try
	
	with timeout of 1800 seconds
		do script {CheckAnchored} --Do the CheckAnchored subroutine
	end timeout
	
	try --Get list of Group Files in the show folder
		tell application "Finder" to set GroupFileList to (name of every file of CATPath whose name starts with "GRP") as list
		set GroupFileCount to count of items in GroupFileList
	on error --If no files exist, then delete progress box and notify user
		set CancelScript to true
		display dialog "You need to transfer the groups from the IBM before running this script." buttons {"Cancel"} default button 1 with icon stop
	end try
	
	--Clear any old text boxes left over from previous attempts, then make temporary text box to pull groups into
	if exists text box "George" of page 1 of document DocName then delete text box "George" of page 1 of document DocName
	make text box at beginning of page 1 of document DocName with properties {bounds:{"-39 pt", "12 pt", "3 pt", "336 pt"}, name:"George"}
	
	if CancelScript is false then
		
		with timeout of 1800 seconds
			set GroupFileList to (do script {OrderGroups}) --Do the OrderGroups subroutine
		end timeout
		
		--Pull in each group file into the temporary text box
		repeat with GroupCounter from 1 to GroupFileCount
			set GroupFilePath to (((CATPath as text) & item GroupCounter of GroupFileList) as text)
			set after story 1 of text box "George" of page 1 of document DocName to file GroupFilePath
		end repeat
		
		--Delete the Show Name and Show Date headers
		delete (every paragraph of story 1 of text box "George" of page 1 of document DocName whose paragraph style is "ShowName")
		delete (every paragraph of story 1 of text box "George" of page 1 of document DocName whose paragraph style is "ShowDate")
		
		with timeout of 1800 seconds
			--Get the list of breeds and groups to get page numbers for
			set BreedList to object reference of every paragraph of story 1 of text box "StartBox" of page 1 of document DocName whose paragraph style is "Breed/Class,Large" and it does not contain "Group" and it does not contain "Class" and it does not contain "Combined" and it does not contain "Best" or paragraph style is "Group" and it does not contain "Breeds" and it does not contain "Variety" and it does not contain "Index"
		end timeout
		
		--Start the counter
		set counter to (count of items of BreedList)
		
		--Start the counter
		tell application "SKProgressBar"
			activate
			tell progress bar
				set indeterminate to false
				start animation
				set maximum value to counter
			end tell
		end tell
		
		with timeout of 1800 seconds
			--do script {BreedIndexer} --Do the BreedIndexer subroutine			
			--Goes through each paragraph in BreedList
			repeat with BreedCounter from 1 to count of items in BreedList
				
				try --Gets the page number of the paragraphs one at a time
					set PageNumber to name of page 1 of text box 1 of (item BreedCounter of BreedList)
					--Correction to get rid of return at end of breed
					set (item BreedCounter of BreedList) to text 1 through -2 of ((item BreedCounter of BreedList) as text)
					--Change some headers so they match the group pages
					if ((item BreedCounter of BreedList) as text) is "English Toy Spaniels (Blenheim & Prince Charles)" then set item BreedCounter of BreedList to "English Toy Spaniels (B & P C)"
					if ((item BreedCounter of BreedList) as text) is "English Toy Spaniels (King Charles & Ruby)" then set item BreedCounter of BreedList to "English Toy Spaniels (K C & R)"
					if ((item BreedCounter of BreedList) as text) is "Miscellaneous Class" then set item BreedCounter of BreedList to "Miscellaneous Classes"
					if ((item BreedCounter of BreedList) as text) is "Junior Showmanship Competition" then set item BreedCounter of BreedList to "Junior Showmanship Classes"
					if ((item BreedCounter of BreedList) as text) is "Obedience Entries" then set item BreedCounter of BreedList to "Obedience Trial Classes"
					if ((item BreedCounter of BreedList) as text) is "Cirneco dell Etna" then set item BreedCounter of BreedList to "Cirneco dellÕEtna"
					--Plug the page number into the Variety Group Pages of each show at end of catalog
					set character before last character of (every paragraph of story 1 of text box "George" of page 1 of document DocName whose paragraph style is "GroupNumbers" and it contains (tab & (item BreedCounter of BreedList) & tab as text) or it contains (tab & ((item BreedCounter of BreedList) as text) & "  (brace)" & tab)) to PageNumber
				end try
				
				--Update the counter
				set counter to counter - 1
				
				tell application "SKProgressBar"
					activate
					tell progress bar
						increment by 1.0
					end tell
					set header to ((counter & " breeds left to check") as text)
				end tell
				
			end repeat
		end timeout
		
		--Copy the group pages to the end of the catalog
		copy story 1 of text box "George" of page 1 of document DocName to after story 1 of text box "StartBox" of page 1 of document DocName
		show last character of story 1 of text box "StartBox" of page 1 of document DocName
		--Delete the temporary text box "George"
		delete text box "George" of page 1 of document DocName
		
		--Quit the progress bar
		tell application "SKProgressBar" to quit
		
		--Let the user know how the page count came out
		set PageCount to (count of pages of document DocName)
		set PageCountOver to PageCount mod 8
		activate
		if PageCountOver = 0 then
			display dialog "This catalog contains " & PageCount & " pages which is correct.  You do not need to add any notes." buttons {"OK"} default button 1
		else if (PageCountOver = 1) or (PageCountOver = 2) then
			display dialog "This catalog contains " & PageCount & " pages.  You need to delete " & PageCountOver & " page(s) or add " & (8 - PageCountOver) & " note(s)." buttons {"OK"} default button 1
		else if PageCountOver > 2 then
			display dialog "This catalog contains " & PageCount & " pages.  You need to add " & (8 - PageCountOver) & " note(s)." buttons {"OK"} default button 1
		end if
		
	end if
	
end tell

beep 2 --Let the user know it's finished