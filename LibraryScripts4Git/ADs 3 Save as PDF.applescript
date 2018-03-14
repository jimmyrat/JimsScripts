--Copyright 1999 by James Lake.


--Account for ClosingDate in file name DONE 5/9/17
--Run from Ad Listing Sheet, not files in folder DONE 5/10/17
--Mark ad name in Ad Listing Sheet as green, create hyperlink DONE 5/10/17
--Update the Cover Ads/Ad Listing Sheet document DONE 5/10/17
--Skip last ad line if last paragraph ends with /p --Added try DONE 5/26/17
--Leading zero is not being added? FIXED
--Temporarily EPS the ad as well as PDF DONE 6/15/17
--Only run on ads listed on ad listing sheet, not on ads found in folder
--PDF and EPS only do the first page of ad FIXED?
--Doesn't update ad counts set from ADs 1 script
--Remove asterisks from PDF names of color ads
--remove ! from PDF name of ad listing sheet for large format catalogs
--Rename PDF from (page 1) to front and (page 2) to back


global NewFile


on Setup() --This defines a subroutine
	
	tell application "Finder"
		activate
		
		--Set some variables
		set FirstFile to NewFile
		set YearFolder to container of FirstFile
		set ShowFolder to container of container of FirstFile
		set ShowCode to text 1 through 4 of (name of ShowFolder as text)
		set TryXCode to ("X" & text 1 through 3 of ShowCode) as text
		set TryYCode to ("Y" & text 1 through 3 of ShowCode) as text
		set TryZCode to ("Z" & text 1 through 3 of ShowCode) as text
		set ClosingDate to text 1 through 8 of (name of FirstFile as text)
		set WebPath to (("Macintosh SSD:Library:WebServer:Documents:" & ClosingDate & ":") as text)
		set UserNme to "USER"
		set Passwrd to "PWORD"
		set AdOB to ""
		set AdIF to ""
		set AdIB to ""
		set ServerShowPath to "MAC_SERVER:SHOW FILES:"
		set OnePgAdCounter to 0
		set BadFile to "false"
		set FileList to (every file of YearFolder whose kind contains "Quark" and name of it starts with ClosingDate)
		
		--Find the folder on the server to save PDFs into
		if exists folder ShowCode of folder ServerShowPath then
			if exists folder "EPS Inserts" of folder ShowCode of folder ServerShowPath then
				set SaveEPSPath to (ServerShowPath & ShowCode & ":EPS Inserts:") as text
				--else if exists (folder 1 of folder ShowCode of folder ServerShowPath whose name starts with "On ") then
				--set SaveEPSPath to (ServerShowPath & ShowCode & ":" & (name of (folder 1 of folder ShowCode of folder ServerShowPath whose name starts with "On ")) & ":") as text
			else
				set SaveEPSPath to (ServerShowPath & ShowCode & ":") as text
			end if
		else if exists folder TryXCode of folder ServerShowPath then
			if exists folder "EPS Inserts" of folder TryXCode of folder ServerShowPath then
				set SaveEPSPath to (ServerShowPath & TryXCode & ":EPS Inserts:") as text
			else if exists (folder 1 of folder TryXCode of folder ServerShowPath whose name starts with "On ") then
				set SaveEPSPath to (ServerShowPath & TryXCode & ":" & (name of (folder 1 of folder TryXCode of folder ServerShowPath whose name starts with "On ")) & ":") as text
			else
				set SaveEPSPath to (ServerShowPath & TryXCode & ":") as text
			end if
		else if exists folder TryYCode of folder ServerShowPath then
			if exists folder "EPS Inserts" of folder TryYCode of folder ServerShowPath then
				set SaveEPSPath to (ServerShowPath & TryYCode & ":EPS Inserts:") as text
			else if exists (folder 1 of folder TryYCode of folder ServerShowPath whose name starts with "On ") then
				set SaveEPSPath to (ServerShowPath & TryYCode & ":" & (name of (folder 1 of folder TryYCode of folder ServerShowPath whose name starts with "On ")) & ":") as text
			else
				set SaveEPSPath to (ServerShowPath & TryYCode & ":") as text
			end if
		else if exists folder TryZCode of folder ServerShowPath then
			if exists folder "EPS Inserts" of folder TryZCode of folder ServerShowPath then
				set SaveEPSPath to (ServerShowPath & TryZCode & ":EPS Inserts:") as text
			else if exists (folder 1 of folder TryZCode of folder ServerShowPath whose name starts with "On ") then
				set SaveEPSPath to (ServerShowPath & TryZCode & ":" & (name of (folder 1 of folder TryZCode of folder ServerShowPath whose name starts with "On ")) & ":") as text
			else
				set SaveEPSPath to (ServerShowPath & TryZCode & ":") as text
			end if
		else --Or save the PDFs in the SHOW FILES folder
			set SaveEPSPath to ServerShowPath
		end if
		
		try --Delete existing PDF
			tell application "Finder" to delete file ((WebPath & ClosingDate & " Cover Ad Placement.pdf") as text)
		end try --Export as PDF
		try --Delete any existing PDFs
			delete (every file of folder SaveEPSPath whose name starts with ((ShowCode & " AD") as text))
		end try
		try --Delete any existing PDFs
			delete (every file of folder WebPath whose name starts with ((ShowCode & " AD") as text))
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
				
			end tell
			
			tell application "QuarkXPress 2017"
				activate
				
				--Open the ad file
				open file (Filepath as text) do auto picture import no without reflow
				
				tell document FileName
					
					--Set some view options
					set properties to {page rule origin:{"3p6", "3p"}}
					set view scale to 100
					set NoDiskFile to "false"
					set SkipNotice to "false"
					
					if FileName contains "00 Ad Listing Sheet" then
						
						repeat with AdCounter from (count of paragraphs of text box "AdListBox") to 1 by -1
							try
								
								set AdNumber2 to word 2 of paragraph AdCounter of text box "AdListBox"
								
								tell application "Finder"
									try
										set AdName2 to (name of file 1 of AdFolder whose name starts with ClosingDate & " " & AdNumber2 & " ")
										set AdName2 to text 13 through -5 of AdName2
									on error
										set AdName2 to ""
									end try
								end tell
								
								if AdNumber2 is "OB" then
									try
										set AdOB to AdName2
									on error
										set AdOB to ""
									end try
								else if AdNumber2 is "IF" then
									try
										set AdIF to AdName2
									on error
										set AdIF to ""
									end try
								else if AdNumber2 is "IB" then
									try
										set AdIB to AdName2
									on error
										set AdIB to ""
									end try
								end if
								set AdTotal to story 1 of text box 6 of page 1
								set PhotoTotal to story 1 of text box 7 of page 1
								set LateAdtotal to story 1 of text box 8 of page 1
								set LatePhotoTotal to story 1 of text box 9 of page 1
								set ClosingDate to story 1 of text box "ClosingDateBox"
								try
									tell application "Finder" to set FileLabel to label index of file (((AdFolder as text) & ClosingDate & " " & AdNumber2 & " " & AdName2 & ".qxp") as text)
								on error
									set FileLabel to 0
								end try
								if name of color of characters 1 through -2 of paragraph AdCounter of story 1 of text box "AdListBox" of page 1 is "Blue" then
									set color of characters 1 through -2 of paragraph AdCounter of story 1 of text box "AdListBox" of page 1 to "Green"
								end if
								
							end try
						end repeat
						
						save
						
					else --regular ads
						
						try --Check for blank documents
							set BoxType to box type of every generic box
						on error
							set SkipNotice to "true"
							tell application "Finder" to set label index of Filepath to 2
						end try
						
						--Check for missing/modified graphics
						if SkipNotice is "false" and (((BoxType as text) contains "picture") or ((BoxType as text) contains "PICx")) then
							if ((missing of every image) contains true) or ((modified of every image) contains true) then
								set SkipNotice to "true"
								tell application "Finder" to set label index of Filepath to 2
							end if
						end if
						
						--Check for "no picture file" graphics
						if SkipNotice is "false" and (((BoxType as text) contains "picture") or ((BoxType as text) contains "PICx")) then
							if ((file path of every image) contains no disk file) then
								set NoDiskFile to "true"
								tell application "Finder" to set label index of Filepath to 4
							end if
						end if
						
						--Check for text overflow
						if SkipNotice is "false" and (((BoxType as text) contains "text") or ((BoxType as text) contains "TXTx")) then
							if (box overflows of every generic box contains true) then
								set SkipNotice to "true"
								tell application "Finder" to set label index of Filepath to 2
							end if
						end if
						
					end if
					
					if SkipNotice is "false" then
						
						--Save the file as a PDF
						if AdName contains "^*" or AdName contains "*^" then
							export every page as "PDF" in ((SaveEPSPath & ShowCode & " AD" & AdNumber & " " & AdName & ".pdf") as text) --PDF output style "Onofrio PDF PL 1up Output Style"
							repeat with x from 1 to count of pages
								if AdNumber is not "ADOB" and AdNumber is not "ADIF" and AdNumber is not "ADIB" then save page x in ((SaveEPSPath & ShowCode & " AD" & AdNumber & " " & AdName & " " & x & "of" & ((count of pages) as text) & " COLOR.eps") as text) as file type EPS format Standard EPS Output Setup "Composite CMYK and Spot" EPS data ASCII EPS OPI include images bleed {"1p", "1p6", "1p", "1p6"} with include preview and transparent page
							end repeat
						else if AdName contains "^" then
							export every page as "PDF" in ((SaveEPSPath & ShowCode & " AD" & AdNumber & " " & AdName & ".pdf") as text) --PDF output style "Onofrio PDF PL 1up Output Style"
							repeat with x from 1 to count of pages
								if AdNumber is not "ADOB" and AdNumber is not "ADIF" and AdNumber is not "ADIB" then save page x in ((SaveEPSPath & ShowCode & " AD" & AdNumber & " " & AdName & " " & x & "of" & ((count of pages) as text) & " COLOR.eps") as text) as file type EPS format Standard EPS Output Setup "Composite CMYK and Spot" EPS data ASCII EPS OPI include images bleed {"1p", "1p6", "1p", "1p6"} with include preview and transparent page
							end repeat
						else if AdName contains "*" or AdName contains "Ad Listing Sheet" then
							export every page as "PDF" in ((SaveEPSPath & ShowCode & " AD" & AdNumber & " " & AdName & ".pdf") as text) --PDF output style "Onofrio PDF PL 1up Output Style"
							repeat with x from 1 to count of pages
								if AdName does not contain "Ad Listing Sheet" and AdNumber is not "ADOB" and AdNumber is not "ADIF" and AdNumber is not "ADIB" then save page x in ((SaveEPSPath & ShowCode & " AD" & AdNumber & " " & AdName & " " & x & "of" & ((count of pages) as text) & " COLOR.eps") as text) as file type EPS format Standard EPS Output Setup "Composite CMYK and Spot" EPS data ASCII EPS OPI include images bleed "0p" with include preview and transparent page
							end repeat
						else --black/white ad
							export every page as "PDF" in ((SaveEPSPath & ShowCode & " AD" & AdNumber & " " & AdName & ".pdf") as text) --PDF output style "Onofrio PDF Ad Output Style"
							repeat with x from 1 to count of pages
								if AdNumber is not "ADOB" and AdNumber is not "ADIF" and AdNumber is not "ADIB" then save page x in ((SaveEPSPath & ShowCode & " AD" & AdNumber & " " & AdName & " " & x & "of" & ((count of pages) as text) & ".eps") as text) as file type EPS format Standard EPS Output Setup "Grayscale" EPS data ASCII EPS OPI include images bleed "0p" with include preview and transparent page
							end repeat
						end if
						
						if SkipNotice is "true" then set BadFile to "true"
						
					end if
					
					--Close the ad file
					close saving no
					
				end tell
				
			end tell
			
		end timeout
		
	end repeat
	
	--Copy PDFs to web server
	tell application "Finder"
		try
			duplicate (every file of folder SaveEPSPath whose name starts with ((ShowCode & " AD") as text) and name does not end with ".eps") to WebPath with replacing
			delete (every file of folder SaveEPSPath whose name contains ((ShowCode & " ADOB") as text) or name contains ((ShowCode & " ADIF") as text) or name contains ((ShowCode & " ADIB") as text))
		end try
	end tell
	
	tell application "QuarkXPress 2017"
		activate
		
		--Open the existing Cover Ad document
		open file ("MAC_SERVER:SHOW FILES:" & ClosingDate & " close:COVER INFO:Cover Ad Placement.qxp")
		
		set CoverAdDoc to name of document 1 as text
		
		--Work with Ad Placement, page 1
		repeat with AdBoxCounter from 47 to 7 by -4
			
			if ((story 1 of text box AdBoxCounter of page 1 of document CoverAdDoc) as text) is ShowCode then
				
				if AdOB is not "" and AdOB is not "	" then
					--set story 1 of text box (AdBoxCounter + 3) of page 1 of document CoverAdDoc to AdOB
					if (exists file ((WebPath & ShowCode & " ADOB " & AdOB & ".pdf") as text)) of application "System Events" then
						set color of (story 1 of text box (AdBoxCounter + 3) of page 1 of document CoverAdDoc) to "Green"
					end if
				end if
				
				if AdIF is not "" and AdIF is not "	" then
					--set story 1 of text box (AdBoxCounter + 2) of page 1 of document CoverAdDoc to AdIF
					if (exists file ((WebPath & ShowCode & " ADIF " & AdIF & ".pdf") as text)) of application "System Events" then
						set color of (story 1 of text box (AdBoxCounter + 2) of page 1 of document CoverAdDoc) to "Green"
					end if
				end if
				
				if AdIB is not "" and AdIB is not "	" then
					--set story 1 of text box (AdBoxCounter + 1) of page 1 of document CoverAdDoc to AdIB
					if (exists file ((WebPath & ShowCode & " ADIB " & AdIB & ".pdf") as text)) of application "System Events" then
						set color of (story 1 of text box (AdBoxCounter + 1) of page 1 of document CoverAdDoc) to "Green"
					end if
				end if
				
			end if
			
		end repeat
		
		--Work with Ad Counts, page 2
		repeat with ShowBoxCounter from 59 to 9 by -5
			
			--Fill in Ad Counts if Show Code already exists, skip if other club
			if story 1 of text box ShowBoxCounter of page 2 of document CoverAdDoc is ShowCode then
				set color of story 1 of text box ShowBoxCounter of page 2 of document CoverAdDoc to "Green"
				set story 1 of text box (ShowBoxCounter - 1) of page 2 of document CoverAdDoc to AdTotal
				set story 1 of text box (ShowBoxCounter + 3) of page 2 of document CoverAdDoc to PhotoTotal
				set story 1 of text box (ShowBoxCounter + 2) of page 2 of document CoverAdDoc to LateAdtotal
				set story 1 of text box (ShowBoxCounter + 1) of page 2 of document CoverAdDoc to LatePhotoTotal
				exit repeat
			end if
			
		end repeat
		
		export every page of document CoverAdDoc as "PDF" in ((WebPath & ClosingDate & " Cover Ad Placement.pdf") as text) --PDF output style "Onofrio PDF PL 2up Output Style"
		
		--Save the updated document
		save document CoverAdDoc
		close document CoverAdDoc
		
	end tell
	
	if NoDiskFile is "true" then tell application "QuarkXPress 2017" to display dialog "One or more documents contained a picture box with a 'no picture file' image which may not print correctly and needs to be fixed." & return & return & "(Boxes with a shadow applied show incorrectly as a false positive.  Shadows will print OK and can be safely ignored)." & return & return & "These files are marked with a blue label in the Finder; please compare the EPS to the printed file to make sure the images print OK."
	
	if BadFile is "true" then tell application "QuarkXPress 2017" to display dialog "Some documents were blank, had missing or modified graphics, or text overflow and were NOT EPSed.  These files are marked with a red label in the Finder."
	
	--Mirror the local WebPath to the MacServer
	tell application "Fetch" to mirror alias ((text 1 through -10 of WebPath) as text) to url (("ftp://" & UserNme & ":" & Passwrd & "@192.168.0.20/Web/") as text) format Automatic with delete strays
	
	beep 2 --Let the user know it's finished
	
end Setup


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
	
end run