--Copyright 1999 by James Lake.


global FileList


on Setup() --This defines a subroutine
	
	tell application "Finder"
		activate
		
		--Set some variables
		set FileList to FileList as list
		
		--Repeat once for each cover file to be converted
		repeat with FileCounter from 1 to count of items in FileList
			
			set FirstFile to item FileCounter of FileList
			
			set OnePgAdCounter to 0
			set FileName to name of file FirstFile as text
			set ShowCode to (text 5 through 8 of FileName) as text
			set TryXCode to ("X" & text 1 through 3 of ShowCode) as text
			set TryZCode to ("Z" & text 1 through 3 of ShowCode) as text
			set ServerShowPath to "MAC_SERVER:SHOW FILES:"
			set SaveEPSPath to ((path to desktop) & "Group Dividers:") as text
			
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
			
			with timeout of 1800 seconds
				
				set FileCount to 2
				if (name of file FirstFile as text) contains " Notes" then set FileCount to 1
				
				--Repeat once for GD, once for Notes
				repeat with FileCounter from 1 to FileCount
					
					--Get file name
					set FileName to name of file FirstFile as text
					set ShortFileName to FileName
					if FileName ends with "_1.qxp" then set ShortFileName to text 1 through -7 of FileName
					if FileName ends with ".qxp" then set ShortFileName to text 1 through -5 of FileName
					
					if FileCounter is 2 then
						try --Check to see if there is a Notes file
							set FirstFile to (((container of file FirstFile) as text) & ((text 1 through -4 of ShortFileName) & " Notes.qxp"))
							--Get file name
							set FileName to name of file FirstFile as text
							set ShortFileName to FileName
							if FileName ends with "_1.qxp" then set ShortFileName to text 1 through -7 of FileName
							if FileName ends with ".qxp" then set ShortFileName to text 1 through -5 of FileName
							
						on error
							exit repeat
						end try
					end if
					
					try --Open the document
						open file FirstFile
						
						tell application "QuarkXPress 2017"
							activate
							
							tell document 1
								
								tell application "Finder" to delay 1
								
								--Get the count of pages in document
								set PageCount to (count of every page)
								
								--Set some view options
								set properties to {page rule origin:{"3p6", "3p"}}
								set view scale to 100
								
								--Repeat once for each page in the document
								repeat with PageCounter from 1 to PageCount
									show page PageCounter
									--Set the name of the EPS file
									if PageCounter < 10 then
										set EPSName to ShortFileName & "_" & PageCounter & ".eps"
									else if PageCounter < 10 then
										set EPSName to ShortFileName & "_0" & PageCounter & ".eps"
									else
										set EPSName to ShortFileName & "_" & PageCounter & ".eps"
									end if
									--Save the page as an EPS in the Show Folder on the server
									--save page PageCounter in ((SaveEPSPath & EPSName) as text) EPS data ASCII EPS OPI include images include preview TIFF with transparent page
									save page PageCounter in ((SaveEPSPath & EPSName) as text) EPS format Standard EPS Output Setup "Grayscale" EPS data ASCII EPS OPI include images bleed "0p" with include preview without transparent page
								end repeat
								
								--Close the ad file
								close saving no
								
							end tell
							
						end tell
						
					end try
					
				end repeat
				
			end timeout
			
		end repeat
		
	end tell
	
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
		set FileList to (choose file with prompt "Select the QuarkXPress files to EPS:")
		
		Setup() --Do the Setup subroutine
		
	end timeout
	
	beep 2 --Let the user know it's finished
	
end run