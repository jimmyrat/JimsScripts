--Copyright 2017 by James Lake.


--Need to create html link for each ad in ad listing sheet --DONE 5/31/17
--Only run on ads listed on ad listing sheet, not on ads found in folder
--Only run on ads listed in red, not blue.  Ads with corrections should be set from blue back to red
--Doesn't update ad counts set from ADs 1 script
--Remove asterisks from PDF names of color ads


global NewFile


on Setup() --This defines a subroutine
	
	tell application "Finder"
		activate
		
		--Set some variables
		set YearFolder to container of NewFile
		set ShowFolder to container of container of NewFile
		set ShowCode to text 1 through 4 of (name of ShowFolder as text)
		set ClosingDate to text 1 through 8 of (name of NewFile as text)
		set WebPath to (("Macintosh SSD:Library:WebServer:Documents:" & ClosingDate & ":") as text)
		set UserNme to "USER"
		set Passwrd to "PWORD"
		set AdOB to ""
		set AdIF to ""
		set AdIB to ""
		set OnePgAdCounter to 0
		set BadFile to "false"
		set FileList to (every file of YearFolder whose kind contains "Quark" and name of it starts with ClosingDate)
		
		try --Delete existing PDF
			tell application "Finder" to delete file ((WebPath & ClosingDate & " Cover Ad Placement.pdf") as text)
		end try --Export as PDF
		try --Delete any existing PDFs
			delete (every file of folder ((WebPath) as text) whose name starts with ((ShowCode & " AD") as text))
		end try
		
	end tell
	
	--Repeat once for each file to be PDFed
	repeat with FileCounter from 1 to count of items in FileList
		
		with timeout of 1800 seconds
			
			tell application "Finder"
				--Get the name and path of the file
				set FileName to name of (item FileCounter of FileList) as text
				set Filepath to (item FileCounter of FileList) as alias
				set AdFolder to container of file Filepath
				set AdName to text 13 through -5 of FileName
				set AdNumber to text 10 through 12 of FileName
				if last character of AdNumber is " " then set AdNumber to text 1 through -2 of AdNumber
				if first character of AdNumber is " " then set AdNumber to (("0" & character 2 of AdNumber) as text)
				
			end tell
			
			tell application "QuarkXPress 2017"
				activate
				
				--Open the ad file
				open file (Filepath as text) do auto picture import no without reflow
				
				--Set some view options
				set properties of document FileName to {page rule origin:{"3p6", "3p"}}
				set view scale of document FileName to 100
				set NoDiskFile to "false"
				set SkipNotice to "false"
				
				if FileName contains "00 Ad Listing Sheet" then
					
					set AdList to story 1 of text box "AdListBox" of document FileName
					
					repeat with AdCounter from (count of paragraphs in AdList) to 1 by -1
						
						if (count of characters of paragraph AdCounter of AdList) > 5 then
							
							--Split the Ad line into separate items
							tell me to set AdText to split(paragraph AdCounter of AdList, "	")
							set AdNumber2 to item 2 of AdText as text
							set AdStatus to ((name of color of word 1 of paragraph AdCounter of story 1 of text box "AdListBox" of document FileName) as text)
							if (count of characters of AdNumber2) is 1 then
								set AdNumber2Fixed to (("0" & AdNumber2) as text)
							else
								set AdNumber2Fixed to AdNumber2
							end if
							set Advertiser2 to item 3 of AdText as text
							set AdSize2 to item 4 of AdText as text
							
							--Skip lines with no page size/count listed, usually OB, IF, or IB
							if AdSize2 is not "" and AdSize2 is not "	" and AdSize2 is not null and AdStatus is "Red" then
								
								tell application "Finder"
									if AdNumber2 is "OB" then
										try
											set AdOB to Advertiser2
										on error
											set AdOB to ""
										end try
									else if AdNumber2 is "IF" then
										try
											set AdIF to Advertiser2
										on error
											set AdIF to ""
										end try
									else if AdNumber2 is "IB" then
										try
											set AdIB to Advertiser2
										on error
											set AdIB to ""
										end try
									end if
								end tell
								set AdTotal to story 1 of text box 6 of page 1 of document FileName
								set PhotoTotal to story 1 of text box 7 of page 1 of document FileName
								set LateAdtotal to story 1 of text box 8 of page 1 of document FileName
								set LatePhotoTotal to story 1 of text box 9 of page 1 of document FileName
								set ClosingDate to story 1 of text box "ClosingDateBox" of document FileName
								try
									tell application "Finder" to set FileLabel to label index of file (((AdFolder as text) & ClosingDate & " " & AdNumber2 & " " & Advertiser2 & ".qxp") as text)
								on error
									set FileLabel to 0
								end try
								try --Delete hyperlink
									activate
									set tool mode of document FileName to contents mode
									set selection to (text 1 of paragraph AdCounter of story 1 of text box "AdListBox" of page 1 of document FileName where it is AdNumber2 & "	" & Advertiser2)
									delay 1
									tell application "System Events"
										click menu item "Remove" of menu "Hyperlink" of menu item "Hyperlink" of menu "Style" of menu bar item "Style" of menu bar 1 of application process "QuarkXPress"
									end tell
									delay 1
								end try
								try --Create hyperlink
									activate
									set color of characters 1 through -2 of paragraph AdCounter of story 1 of text box "AdListBox" of page 1 of document FileName to "Blue"
									set tool mode of document FileName to contents mode
									set selection to (text 1 of paragraph AdCounter of story 1 of text box "AdListBox" of page 1 of document FileName where it is AdNumber2 & "	" & Advertiser2)
									delay 1
									tell application "System Events"
										click menu item "New..." of menu "Hyperlink" of menu item "Hyperlink" of menu "Style" of menu bar item "Style" of menu bar 1 of application process "QuarkXPress"
										keystroke ((ShowCode & " AD" & AdNumber2Fixed & " " & Advertiser2 & ".pdf") as text) & tab & ((ShowCode & " AD" & AdNumber2Fixed & " " & Advertiser2 & ".pdf") as text) & return
									end tell
									delay 1
								end try
								
							end if
							
						end if
						
					end repeat
					
					save document FileName
					
				else --regular ads
					
					try --Check for blank documents
						set BoxType to box type of every generic box of document FileName
					on error
						set SkipNotice to "true"
						tell application "Finder" to set label index of Filepath to 2
					end try
					
					--Check for missing/modified graphics
					if SkipNotice is "false" and (((BoxType as text) contains "picture") or ((BoxType as text) contains "PICx")) then
						if ((missing of every image of document FileName) contains true) or ((modified of every image of document FileName) contains true) then
							set SkipNotice to "true"
							tell application "Finder" to set label index of Filepath to 2
						end if
					end if
					
					--Check for "no picture file" graphics
					if SkipNotice is "false" and (((BoxType as text) contains "picture") or ((BoxType as text) contains "PICx")) then
						if ((file path of every image of document FileName) contains no disk file) then
							set NoDiskFile to "true"
							tell application "Finder" to set label index of Filepath to 4
						end if
					end if
					
					--Check for text overflow
					if SkipNotice is "false" and (((BoxType as text) contains "text") or ((BoxType as text) contains "TXTx")) then
						if (box overflows of every generic box of document FileName contains true) then
							set SkipNotice to "true"
							tell application "Finder" to set label index of Filepath to 2
						end if
					end if
					
				end if
				
				if SkipNotice is "false" then
					
					--Save the file as a PDF
					if last character of AdName is "*" or character -2 of AdName is "*" or AdName contains "Ad Listing Sheet" then
						export every page of document FileName as "PDF" in ((WebPath & ShowCode & " AD" & AdNumber & " " & AdName & ".pdf") as text) --PDF output style "Onofrio PDF PL 1up Output Style"
					else --black/white ad
						export every page of document FileName as "PDF" in ((WebPath & ShowCode & " AD" & AdNumber & " " & AdName & ".pdf") as text) --PDF output style "Onofrio PDF Ad Output Style"
					end if
					
					if SkipNotice is "true" then set BadFile to "true"
					
				end if
				
				--Close the ad file
				close document FileName saving no
				
			end tell
			
		end timeout
		
	end repeat
	
	tell application "QuarkXPress 2017"
		activate
		
		--Open the existing Cover Ad document
		open file ("MAC_SERVER:SHOW FILES:" & ClosingDate & " close:COVER INFO:Cover Ad Placement.qxp")
		
		set CoverAdDoc to name of document 1 as text
		
		--Work with Ad Placement, page 1
		repeat with AdBoxCounter from 47 to 7 by -4
			
			if ((story 1 of text box AdBoxCounter of page 1 of document CoverAdDoc) as text) is ShowCode then
				
				if AdOB is not "" and AdOB is not "	" and AdOB is not null then
					--set story 1 of text box (AdBoxCounter + 3) of page 1 of document CoverAdDoc to AdOB
					if (exists file ((WebPath & ShowCode & " ADOB " & AdOB & ".pdf") as text)) of application "System Events" then
						try --Delete hyperlink
							activate
							set tool mode of document CoverAdDoc to contents mode
							set selection to (story 1 of text box (AdBoxCounter + 3) of page 1 of document CoverAdDoc)
							delay 1
							tell application "System Events"
								click menu item "Remove" of menu "Hyperlink" of menu item "Hyperlink" of menu "Style" of menu bar item "Style" of menu bar 1 of application process "QuarkXPress"
							end tell
							delay 1
						end try
						try --Create hyperlink
							activate
							set color of (story 1 of text box (AdBoxCounter + 3) of page 1 of document CoverAdDoc) to "Blue"
							set tool mode of document CoverAdDoc to contents mode
							set selection to (story 1 of text box (AdBoxCounter + 3) of page 1 of document CoverAdDoc)
							delay 1
							tell application "System Events"
								click menu item "New..." of menu "Hyperlink" of menu item "Hyperlink" of menu "Style" of menu bar item "Style" of menu bar 1 of application process "QuarkXPress"
								keystroke ((ShowCode & " ADOB " & AdOB & ".pdf") as text) & tab & ((ShowCode & " ADOB " & AdOB & ".pdf") as text) & return
							end tell
							delay 1
						end try
					else
						try --Delete hyperlink
							activate
							set color of (story 1 of text box (AdBoxCounter + 3) of page 1 of document CoverAdDoc) to "Red"
							set tool mode of document CoverAdDoc to contents mode
							set selection to (story 1 of text box (AdBoxCounter + 3) of page 1 of document CoverAdDoc)
							delay 1
							tell application "System Events"
								click menu item "Remove" of menu "Hyperlink" of menu item "Hyperlink" of menu "Style" of menu bar item "Style" of menu bar 1 of application process "QuarkXPress"
							end tell
							delay 1
						end try
					end if
				end if
				
				if AdIF is not "" and AdIF is not "	" and AdIF is not null then
					--set story 1 of text box (AdBoxCounter + 2) of page 1 of document CoverAdDoc to AdIF
					if (exists file ((WebPath & ShowCode & " ADIF " & AdIF & ".pdf") as text)) of application "System Events" then
						try --Delete hyperlink
							activate
							set tool mode of document CoverAdDoc to contents mode
							set selection to (story 1 of text box (AdBoxCounter + 2) of page 1 of document CoverAdDoc)
							delay 1
							tell application "System Events"
								click menu item "Remove" of menu "Hyperlink" of menu item "Hyperlink" of menu "Style" of menu bar item "Style" of menu bar 1 of application process "QuarkXPress"
							end tell
							delay 1
						end try
						try --Create hyperlink
							activate
							set color of (story 1 of text box (AdBoxCounter + 2) of page 1 of document CoverAdDoc) to "Blue"
							set tool mode of document CoverAdDoc to contents mode
							set selection to (story 1 of text box (AdBoxCounter + 2) of page 1 of document CoverAdDoc)
							delay 1
							tell application "System Events"
								click menu item "New..." of menu "Hyperlink" of menu item "Hyperlink" of menu "Style" of menu bar item "Style" of menu bar 1 of application process "QuarkXPress"
								keystroke ((ShowCode & " ADIF " & AdIF & ".pdf") as text) & tab & ((ShowCode & " ADIF " & AdIF & ".pdf") as text) & return
							end tell
							delay 1
						end try
					else
						try --Delete hyperlink
							activate
							set color of (story 1 of text box (AdBoxCounter + 2) of page 1 of document CoverAdDoc) to "Red"
							set tool mode of document CoverAdDoc to contents mode
							set selection to (story 1 of text box (AdBoxCounter + 2) of page 1 of document CoverAdDoc)
							delay 1
							tell application "System Events"
								click menu item "Remove" of menu "Hyperlink" of menu item "Hyperlink" of menu "Style" of menu bar item "Style" of menu bar 1 of application process "QuarkXPress"
							end tell
							delay 1
						end try
					end if
				end if
				
				if AdIB is not "" and AdIB is not "	" and AdIB is not null then
					--set story 1 of text box (AdBoxCounter + 1) of page 1 of document CoverAdDoc to AdIB
					if (exists file ((WebPath & ShowCode & " ADIB " & AdIB & ".pdf") as text)) of application "System Events" then
						try --Delete hyperlink
							activate
							set tool mode of document CoverAdDoc to contents mode
							set selection to (story 1 of text box (AdBoxCounter + 1) of page 1 of document CoverAdDoc)
							delay 1
							tell application "System Events"
								click menu item "Remove" of menu "Hyperlink" of menu item "Hyperlink" of menu "Style" of menu bar item "Style" of menu bar 1 of application process "QuarkXPress"
							end tell
							delay 1
						end try
						try --Create hyperlink
							activate
							set color of (story 1 of text box (AdBoxCounter + 1) of page 1 of document CoverAdDoc) to "Blue"
							set tool mode of document CoverAdDoc to contents mode
							set selection to (story 1 of text box (AdBoxCounter + 1) of page 1 of document CoverAdDoc)
							delay 1
							tell application "System Events"
								click menu item "New..." of menu "Hyperlink" of menu item "Hyperlink" of menu "Style" of menu bar item "Style" of menu bar 1 of application process "QuarkXPress"
								keystroke ((ShowCode & " ADIB " & AdIB & ".pdf") as text) & tab & ((ShowCode & " ADIB " & AdIB & ".pdf") as text) & return
							end tell
							delay 1
						end try
					else
						try --Delete hyperlink
							activate
							set color of (story 1 of text box (AdBoxCounter + 1) of page 1 of document CoverAdDoc) to "Red"
							set tool mode of document CoverAdDoc to contents mode
							set selection to (story 1 of text box (AdBoxCounter + 1) of page 1 of document CoverAdDoc)
							delay 1
							tell application "System Events"
								click menu item "Remove" of menu "Hyperlink" of menu item "Hyperlink" of menu "Style" of menu bar item "Style" of menu bar 1 of application process "QuarkXPress"
							end tell
							delay 1
						end try
					end if
				end if
				
			end if
			
		end repeat
		
		--Work with Ad Counts, page 2
		repeat with ShowBoxCounter from 59 to 9 by -5
			
			--Fill in Ad Counts if Show Code already exists, skip if other club
			if story 1 of text box ShowBoxCounter of page 2 of document CoverAdDoc is ShowCode then
				try --Delete hyperlink
					activate
					set tool mode of document CoverAdDoc to contents mode
					set selection to (story 1 of text box ShowBoxCounter of page 2 of document CoverAdDoc)
					delay 1
					tell application "System Events"
						click menu item "Remove" of menu "Hyperlink" of menu item "Hyperlink" of menu "Style" of menu bar item "Style" of menu bar 1 of application process "QuarkXPress"
					end tell
					delay 1
				end try
				try --Create hyperlink
					activate
					set color of (story 1 of text box ShowBoxCounter of page 2 of document CoverAdDoc) to "Blue"
					set tool mode of document CoverAdDoc to contents mode
					set selection to (story 1 of text box ShowBoxCounter of page 2 of document CoverAdDoc)
					delay 1
					tell application "System Events"
						click menu item "New..." of menu "Hyperlink" of menu item "Hyperlink" of menu "Style" of menu bar item "Style" of menu bar 1 of application process "QuarkXPress"
						keystroke ((ShowCode & " AD00 Ad Listing Sheet.pdf") as text) & tab & ((ShowCode & " AD00 Ad Listing Sheet.pdf") as text) & return
					end tell
					delay 1
				end try
				set story 1 of text box (ShowBoxCounter - 1) of page 2 of document CoverAdDoc to AdTotal
				set story 1 of text box (ShowBoxCounter + 3) of page 2 of document CoverAdDoc to PhotoTotal
				set story 1 of text box (ShowBoxCounter + 2) of page 2 of document CoverAdDoc to LateAdtotal
				set story 1 of text box (ShowBoxCounter + 1) of page 2 of document CoverAdDoc to LatePhotoTotal
				exit repeat
				--Otherwise fill in Ad Counts in first blank row
			else if story 1 of text box ShowBoxCounter of page 2 of document CoverAdDoc is "" then
				--if AdTotal is not "" or PhotoTotal is not "" or LateAdtotal is not "" or LatePhotoTotal is not "" then
				set story 1 of text box ShowBoxCounter of page 2 of document CoverAdDoc to ShowCode
				try --Delete hyperlink
					activate
					set tool mode of document CoverAdDoc to contents mode
					set selection to (story 1 of text box ShowBoxCounter of page 2 of document CoverAdDoc)
					delay 1
					tell application "System Events"
						click menu item "Remove" of menu "Hyperlink" of menu item "Hyperlink" of menu "Style" of menu bar item "Style" of menu bar 1 of application process "QuarkXPress"
					end tell
					delay 1
				end try
				try --Create hyperlink
					activate
					set color of (story 1 of text box ShowBoxCounter of page 2 of document CoverAdDoc) to "Blue"
					set tool mode of document CoverAdDoc to contents mode
					set selection to (story 1 of text box ShowBoxCounter of page 2 of document CoverAdDoc)
					delay 1
					tell application "System Events"
						click menu item "New..." of menu "Hyperlink" of menu item "Hyperlink" of menu "Style" of menu bar item "Style" of menu bar 1 of application process "QuarkXPress"
						keystroke ((ShowCode & " AD00 Ad Listing Sheet.pdf") as text) & tab & ((ShowCode & " AD00 Ad Listing Sheet.pdf") as text) & return
					end tell
					delay 1
				end try
				set story 1 of text box (ShowBoxCounter - 1) of page 2 of document CoverAdDoc to AdTotal
				set story 1 of text box (ShowBoxCounter + 3) of page 2 of document CoverAdDoc to PhotoTotal
				set story 1 of text box (ShowBoxCounter + 2) of page 2 of document CoverAdDoc to LateAdtotal
				set story 1 of text box (ShowBoxCounter + 1) of page 2 of document CoverAdDoc to LatePhotoTotal
				exit repeat
				--end if
			end if
			
		end repeat
		
		export every page of document CoverAdDoc as "PDF" in ((WebPath & ClosingDate & " Cover Ad Placement.pdf") as text) --PDF output style "Onofrio PDF PL 2up Output Style"
		
		--Save the updated document
		save document CoverAdDoc
		close document CoverAdDoc without saving
		
	end tell
	
	if NoDiskFile is "true" then tell application "QuarkXPress 2017" to display dialog "One or more documents contained a picture box with a 'no picture file' image which may not print correctly and needs to be fixed." & return & return & "(Boxes with a shadow applied show incorrectly as a false positive.  Shadows will print OK and can be safely ignored)." & return & return & "These files are marked with a blue label in the Finder; please compare the EPS to the printed file to make sure the images print OK."
	
	if BadFile is "true" then tell application "QuarkXPress 2017" to display dialog "Some documents were blank, had missing or modified graphics, or text overflow and were NOT EPSed.  These files are marked with a red label in the Finder."
	
	--Mirror the local WebPath to the MacServer
	tell application "Fetch" to mirror alias ((text 1 through -10 of WebPath) as text) to url (("ftp://" & UserNme & ":" & Passwrd & "@192.168.0.20/Web/") as text) format Automatic with delete strays
	
end Setup


to split(someText, delimiter) --This subroutine divides text into separate chunks
	set AppleScript's text item delimiters to delimiter
	set someText to someText's text items
	set AppleScript's text item delimiters to {""} --> restore delimiters to default value
	return someText
end split


on open DroppedFile --Do this when a file is dropped onto script
	
	with timeout of 900 seconds
		
		--change from list to just 1 file
		set NewFile to item 1 of DroppedFile
		
		tell application "System Events"
			activate
			
			if (count of items of DroppedFile) > 1 then display dialog "Several files were dropped onto this script, but only one at a time is supported.  The file " & name of NewFile & " will be used." buttons {"Cancel", "OK"} default button 2 with icon note
			--Make sure file dropped was a QXP file
			set FileType to kind of NewFile
			set FileName to name of NewFile
		end tell
		
		if FileType contains "Quark" and FileName contains "Ad Listing Sheet" then
			tell me to Setup() --Do the Setup subroutine
		else
			--If not, then notify user and skip this file
			display dialog "Please select the Ad Listing Sheet." buttons {"Cancel"} default button 1 with icon stop
		end if
		
	end timeout
	
	beep 2 --Let the user know it's finished
	
end open


on run --Do this when script is double-clicked
	
	with timeout of 900 seconds
		
		tell application "QuarkXPress 2017"
			if (exists document 1) and (name of document 1 contains "Ad Listing Sheet") then
				set NewFile to file path of document 1
				close document 1
				tell me to Setup() --Do the Setup subroutine
			else
				--Choose a file to PDF
				tell application "System Events"
					set NewFile to (choose file of type {"XDOC", "XPRJ", ""} with prompt "Select the Ad Listing Sheet from the folder of Ads to PDF:" without multiple selections allowed)
					if kind of NewFile contains "Quark" or name of NewFile contains "Ad Listing Sheet" then
						tell me to Setup() --Do the Setup subroutine
					else
						--If not, then notify user and skip this file
						display dialog "Please select the Ad Listing Sheet." buttons {"Cancel"} default button 1 with icon stop
					end if
				end tell
			end if
			
		end tell
		
	end timeout
	
	beep 2 --Let the user know it's finished
	
end run