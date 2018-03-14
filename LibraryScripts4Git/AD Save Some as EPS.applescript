--Copyright 2004 by James Lake.

global FileList


on Setup() --This defines a subroutine
	
	tell application "Finder"
		activate
		
		--Set some variables
		set FileList to FileList as list
		set FirstFile to item 1 of FileList
		set ShowFolder to container of container of FirstFile
		set ShowCode to text 1 through 4 of (name of ShowFolder as text)
		set TryXCode to ("X" & text 1 through 3 of ShowCode) as text
		set TryYCode to ("Y" & text 1 through 3 of ShowCode) as text
		set TryZCode to ("Z" & text 1 through 3 of ShowCode) as text
		set ServerShowPath to "MAC_SERVER:SHOW FILES:"
		set OnePgAdCounter to 0
		set BadFile to "false"
		
		--Find the folder on the server to save EPSs into
		if exists folder ShowCode of folder ServerShowPath then
			if exists folder "EPS Inserts" of folder ShowCode of folder ServerShowPath then
				set SaveEPSPath to (ServerShowPath & ShowCode & ":EPS Inserts:") as text
			else if exists (folder 1 of folder ShowCode of folder ServerShowPath whose name starts with "On ") then
				set SaveEPSPath to (ServerShowPath & ShowCode & ":" & (name of (folder 1 of folder ShowCode of folder ServerShowPath whose name starts with "On ")) & ":") as text
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
		else --Or save the EPSs in the SHOW FILES folder
			set SaveEPSPath to ServerShowPath
		end if
		
	end tell
	
	--Repeat once for each file to be EPSed
	repeat with FileCounter from 1 to count of items in FileList
		
		with timeout of 1800 seconds
			
			tell application "Finder"
				--Get the name and path of the file
				set FileName to name of (item FileCounter of FileList) as text
				set Filepath to (item FileCounter of FileList) as alias
				set AdPlacement to comment of file Filepath
				set FileType to kind of file Filepath
			end tell
			
			if FileType contains "Quark" then
				
				tell application "QuarkXPress 2017"
					activate
					
					--Open the ad file
					open Filepath do auto picture import no without reflow
					
					tell document FileName
						
						--Set some view options
						set properties to {page rule origin:{"3p6", "3p"}}
						set view scale to 100
						set CountPages to count of pages
						set NoDiskFile to "false"
						set SkipNotice to "false"
						set AdNumber to text 10 through 12 of FileName
						if last character of AdNumber is " " then set AdNumber to text 1 through -2 of AdNumber
						
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
						
						if SkipNotice is "false" then
							
							--Repeat once for each page in the ad file
							repeat with PageCounter from 1 to CountPages
								
								show page PageCounter
								
								if AdPlacement is not "" then set AdPlacement to (" " & AdPlacement) as text
								--Set the name of the EPS file
								if CountPages < 10 then
									set EPSName to ShowCode & " #" & AdNumber & " " & PageCounter & "of" & CountPages & AdPlacement & ".eps"
								else if PageCounter < 10 then
									set EPSName to ShowCode & " #" & AdNumber & " 0" & PageCounter & "of" & CountPages & AdPlacement & ".eps"
								else
									set EPSName to ShowCode & " #" & AdNumber & " " & PageCounter & "of" & CountPages & AdPlacement & ".eps"
								end if
								
								--Save the page as an EPS
								if FileName contains "*^" or FileName contains "^*" then
									save page PageCounter in (SaveEPSPath & (EPSName & " COLOR BLEED") as text) as file type EPS format Standard EPS Output Setup "Composite CMYK and Spot" EPS data ASCII EPS OPI include images bleed {"1p", "1p6", "1p", "1p6"} with include preview and transparent page
								else if FileName contains "*" then
									save page PageCounter in (SaveEPSPath & (EPSName & " COLOR") as text) as file type EPS format Standard EPS Output Setup "Composite CMYK and Spot" EPS data ASCII EPS OPI include images bleed "0p" with include preview and transparent page
								else if FileName contains "^" then
									save page PageCounter in (SaveEPSPath & (EPSName & " BLEED") as text) as file type EPS format Standard EPS Output Setup "Grayscale" EPS data ASCII EPS OPI include images bleed {"1p", "1p6", "1p", "1p6"} with include preview and transparent page
								else
									save page PageCounter in ((SaveEPSPath & EPSName) as text) as file type EPS format Standard EPS Output Setup "Grayscale" EPS data ASCII EPS OPI include images bleed "0p" with include preview and transparent page
								end if
								
							end repeat
							
						end if
						
						--Close the ad file
						close saving no
						
						if SkipNotice is "true" then set BadFile to "true"
						
					end tell
					
				end tell
				
			else
				
				--If not, then notify user and skip this file
				display dialog "The file " & FileName & " is not a QuarkXPress document and will be skipped." buttons {"OK"} default button 1 with icon caution
				
			end if
			
		end timeout
		
	end repeat
	
	if NoDiskFile is "true" then tell application "QuarkXPress 2017" to display dialog "One or more documents contained a picture box with a 'no picture file' image which may not print correctly and needs to be fixed." & return & return & "(Boxes with a shadow applied show incorrectly as a false positive.  Shadows will print OK and can be safely ignored)." & return & return & "These files are marked with a blue label in the Finder; please compare the EPS to the printed file to make sure the images print OK."
	
	
	if BadFile is "true" then tell application "QuarkXPress 2017" to display dialog "Some documents were blank, had missing or modified graphics, or text overflow and were NOT EPSed.  These files are marked with a red label in the Finder."
	
end Setup


on open DroppedFileList --Do this when a file is dropped onto script
	
	with timeout of 900 seconds
		
		set FileList to DroppedFileList
		Setup() --Do the Setup subroutine
		
	end timeout
	
	beep 2 --Let the user know it's finished
	
end open


on run --Do this when script is double-clicked
	
	with timeout of 900 seconds
		
		--Choose a file to EPS
		set FileList to (choose file of type {"XDOC", "XPRJ", ""} with prompt "Select the QuarkXPress files to EPS:" with multiple selections allowed)
		
		Setup() --Do the Setup subroutine
		
	end timeout
	
	beep 2 --Let the user know it's finished
	
end run