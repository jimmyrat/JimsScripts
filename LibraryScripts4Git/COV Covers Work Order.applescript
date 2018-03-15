--Copyright 2017 by James Lake.


--Add Group Divider creation DONE 6/15/17
--Inside covers are not being processed FIXED 8/14/17
--Only works if all codes are the same color FIXED
--Does not place GD and Notes in the proper folder FIXED
--Just copy the entire closing folder from local web folder to server web folder at end so it refreshes online FIXED
--Set one color to ignore that cover USE REGISTRATION
--Need to create a closing folder AND html file on webserver if it doesn't exist DONE 1/11/18
--Only create closing folder on Printshop computer when WorkStage = Print DONE 1/11/18
--Need to make sure CurrentDay is not larger than number of days in that month DONE 1/11/18
--Don't ask to EPS group dividers for black or red codes DONE 3/13/18


global ServerShowPath, ClosingDate, UserNme, Passwrd


tell application "QuarkXPress 2017"
	activate
	
	if (not (exists document 1)) or (not (exists text box "ShowCodes" of document 1)) or ((count of characters of story 1 of text box "ShowCodes" of document 1) < 2) then display dialog "You must have a Covers Work Order document open and filled out to run this script." buttons {"Cancel"} default button 1 with icon stop
	
	set CWODocName to name of document 1 as text
	set ClosingDate to text 1 through -5 of CWODocName --story 1 of text box "	" of document CWODocName
	set ShowCodeList to ((paragraphs of text box "ShowCodes" of document CWODocName whose name of paragraph style is "ClusterCode" and (length) > 3))
	set ServerShowPath to "MAC_SERVER:SHOW FILES:"
	set UserNme to "USER"
	set Passwrd to "PWORD"
	set WebPath to (("Macintosh SSD:Library:WebServer:Documents:" & ClosingDate & ":") as text)
	tell application "System Events"
		if not (exists folder WebPath) then run DoStuff
	end tell
	set PrintShopFolder to "Macintosh SSD:Volumes:Desktop:"
	set PrintShopPath to ((PrintShopFolder & ClosingDate & " Covers:") as text)
	set CoverPath to "GRAPHICS 4:COVERS:COVERS by code:"
	
	try
		set BlueCodes to every word of story 1 of text box "ShowCodes" of page 1 of document CWODocName whose name of color is "Blue" and paragraph style is "ClusterCode"
		if BlueCodes is not {} then set WorkStage to "Print"
	end try
	
	try
		set RedCodes to every word of story 1 of text box "ShowCodes" of page 1 of document CWODocName whose name of color is "Red" and paragraph style is "ClusterCode"
		if RedCodes is not {} then set WorkStage to "Proof"
	end try
	
	try
		set BlackCodes to every word of story 1 of text box "ShowCodes" of page 1 of document CWODocName whose name of color is "Black" and paragraph style is "ClusterCode"
		if BlackCodes is not {} then set WorkStage to "Setup"
	end try
	
	if WorkStage is "Print" then
		if button returned of (display dialog "EPS the Group Dividers?" buttons {"No", "Yes"} default button 2 with icon note) is "Yes" then
			set IncludeDividers to true
		else
			set IncludeDividers to false
		end if
	end if
	
end tell

if WorkStage is "Print" then
	tell application "System Events"
		try
			if not (exists folder PrintShopFolder) then tell me to mount volume "smb://user:pword@192.168.0.160/Desktop/"
		end try
		try
			make folder in folder PrintShopFolder with properties {name:((ClosingDate & " Covers") as text)}
		end try
	end tell
end if

--Repeat once for each Show/Cluster Code in the list
repeat with CodeCounter from (count of items of ShowCodeList) to 1 by -1
	
	with timeout of 1800 seconds
		
		tell me to set ShowCode to Çevent SATIUPPEÈ (text 1 through 4 of item CodeCounter of ShowCodeList)
		tell application "System Events"
			try
				set NewFilePath to (folder 1 of folder CoverPath whose name of it contains ShowCode)
				set NewFilePathName to name of NewFilePath
			end try
			try
				set NewFile to ((file 1 of NewFilePath whose name of it is ((ClosingDate & " " & ShowCode & " COV.qxp") as text)) as alias) as text
			on error
				try
					set NewFile to ((file 1 of NewFilePath whose name of it is ((ClosingDate & " " & ShowCode & ".qxp") as text)) as alias) as text
				end try
			end try
			set InsideCounter to 1 --false
			try
				set NewFileInside to ((file 1 of NewFilePath whose name of it is ((ClosingDate & " " & ShowCode & " Inside" & ".qxp") as text)) as alias) as text
				set InsideCounter to 2 --true
			end try
		end tell
		
		try
			set GDFilePath to "Macintosh SSD:GRAPHICS 4:COVERS:COVERS by code:" & NewFilePathName & ":" & ClosingDate & " " & ShowCode & " GD.qxp"
		end try
		try
			set NotesFilePath to "Macintosh SSD:GRAPHICS 4:COVERS:COVERS by code:" & NewFilePathName & ":" & ClosingDate & " " & ShowCode & " Notes.qxp"
		end try
		set TryXCode to ("X" & text 1 through 3 of ShowCode) as text
		set TryZCode to ("Z" & text 1 through 3 of ShowCode) as text
		
		tell application "QuarkXPress 2017"
			activate
			
			-------------------------------------------------------------------------
			if WorkStage is "Setup" and name of color of (word 1 of story 1 of text box "ShowCodes" of document CWODocName where it is ShowCode) is "Black" then
				
				set color of (word 1 of story 1 of text box "ShowCodes" of document CWODocName where it is ShowCode) to "Red"
				try --Not set up yet
					activate
					set tool mode of document CWODocName to contents mode
					set selection to (word 1 of story 1 of text box "ShowCodes" of document CWODocName where it is ShowCode)
					delay 1
					tell application "System Events"
						click menu item "Remove" of menu "Hyperlink" of menu item "Hyperlink" of menu "Style" of menu bar item "Style" of menu bar 1 of application process "QuarkXPress"
					end tell
					delay 1
				end try
				
				-------------------------------------------------------------------------
			else if WorkStage is "proof" and name of color of (word 1 of story 1 of text box "ShowCodes" of document CWODocName where it is ShowCode) is "Red" then
				
				set color of (word 1 of story 1 of text box "ShowCodes" of document CWODocName where it is ShowCode) to "Blue"
				try --Delete any old HTML links
					activate
					set tool mode of document CWODocName to contents mode
					set selection to (word 1 of story 1 of text box "ShowCodes" of document CWODocName where it is ShowCode)
					delay 1
					tell application "System Events"
						click menu item "Remove" of menu "Hyperlink" of menu item "Hyperlink" of menu "Style" of menu bar item "Style" of menu bar 1 of application process "QuarkXPress"
					end tell
					delay 1
				end try
				try
					activate
					set tool mode of document CWODocName to contents mode
					set selection to (word 1 of story 1 of text box "ShowCodes" of document CWODocName where it is ShowCode)
					delay 1
					tell application "System Events"
						click menu item "New..." of menu "Hyperlink" of menu item "Hyperlink" of menu "Style" of menu bar item "Style" of menu bar 1 of application process "QuarkXPress"
						keystroke ((ShowCode & " Cover.pdf") as text) & tab & ((ShowCode & " Cover.pdf") as text) & return
					end tell
					delay 1
				end try
				
				repeat with ProofCounter from 1 to InsideCounter
					
					try
						
						if ProofCounter = 2 then
							set NewFile to NewFileInside
							set SaveProofName to ((ShowCode & " Cover Inside.pdf") as text)
						else
							set SaveProofName to ((ShowCode & " Cover.pdf") as text)
						end if
						
						with timeout of 1800 seconds
							
							--Open the original document
							tell application "System Events" to open file NewFile
							delay 1
							
							--Get the name of the original document
							set CoverDocName to name of document 1
							
							try --Delete the PDF if it already exists
								tell application "System Events" to delete file ((WebPath & SaveProofName) as text)
							end try
							
							--Export OKI document as a PDF to the closing date folder in the website folder
							export document CoverDocName as "PDF" in ((WebPath & SaveProofName) as text) PDF output style "Onofrio PDF MACH5 Output Style"
							
							close document CoverDocName without saving
							
						end timeout
						
						set ProofCounter to 1
						
					end try
					
				end repeat
				
				-------------------------------------------------------------------------
			else if WorkStage is "Print" and name of color of (word 1 of story 1 of text box "ShowCodes" of document CWODocName where it is ShowCode) is "Blue" then
				
				repeat with PrintCounter from 1 to InsideCounter
					
					if PrintCounter = 2 then
						set NewFile to NewFileInside
						set SavePrintName to ((ShowCode & " Cover Inside.pdf") as text)
					else
						set SavePrintName to ((ShowCode & " Cover.pdf") as text)
					end if
					
					tell application "System Events" to open file NewFile --Open the original document
					delay 1
					
					--Get the name of the original document
					set PDFDocName to name of document 1
					
					try --Delete existing PDF in Website folder
						tell application "System Events" to delete file ((WebPath & SavePrintName) as text)
					end try
					
					--Export OKI document as a PDF to the closing date folder in website computer
					export document PDFDocName as "PDF" in ((WebPath & SavePrintName) as text) PDF output style "Onofrio PDF PL 1up Output Style"
					
					--Delete the items that are foil stamps
					delete (every picture box of document PDFDocName whose color of image 1 contains "foil")
					delete (every text box of document PDFDocName whose color of story 1 contains "foil")
					delete (every generic box of document PDFDocName whose color of it contains "foil")
					
					try --Delete existing PDF in PrintShop folder
						tell application "System Events" to delete file ((PrintShopPath & SavePrintName) as text)
					end try
					
					--Export OKI document as a PDF to the closing date folder on printshop desktop
					export document PDFDocName as "PDF" in ((PrintShopPath & SavePrintName) as text) PDF output style "Onofrio PDF MACH5 Output Style"
					
					--Close document
					close document PDFDocName without saving
					
					--Change color of Show Code in Covers Work Order to green
					set color of (word 1 of story 1 of text box "ShowCodes" of document CWODocName where it is ShowCode) to "Green"
					
				end repeat
				
				if IncludeDividers is true then
					
					with timeout of 1800 seconds
						
						tell application "System Events"
							
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
							
						end tell
						
						try --Open the GD document
							tell application "System Events" to open file GDFilePath
							delay 1
							
							--Get the name of the GD document
							set GDDocName to name of document 1
							
							tell document GDDocName
								
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
										set GDEPSName to ClosingDate & " " & ShowCode & " GD 0" & PageCounter & ".eps"
									else
										set GDEPSName to ClosingDate & " " & ShowCode & " GD " & PageCounter & ".eps"
									end if
									
									--Save the page as an EPS in the Show Folder on the server
									save page PageCounter in ((SaveEPSPath & GDEPSName) as text) EPS format Standard EPS Output Setup "Grayscale" EPS data ASCII EPS OPI include images bleed "0p" with include preview without transparent page
								end repeat
								
								--Close the GD document
								close saving no
								
							end tell
							
						end try
						
						try --Open the Notes document
							tell application "System Events" to open file NotesFilePath
							delay 1
							
							--Get the name of the Notes document
							set NotesDocName to name of document 1
							
							tell document NotesDocName
								
								--Set some view options
								set properties to {page rule origin:{"3p6", "3p"}}
								set view scale to 100
								
								set NotesEPSName to ClosingDate & " " & ShowCode & " Notes.eps"
								
								--Save the page as an EPS in the Show Folder on the server
								save page 1 in ((SaveEPSPath & NotesEPSName) as text) EPS format Standard EPS Output Setup "Grayscale" EPS data ASCII EPS OPI include images bleed "0p" with include preview without transparent page
								
								--Close the Notes file
								close saving no
								
							end tell
							
						end try
						
					end timeout
					
				end if
				
			end if
			-------------------------------------------------------------------------
			
		end tell
		
	end timeout
	
end repeat

tell application "QuarkXPress 2017"
	activate
	
	try --Delete existing PDF
		tell application "System Events" to delete file ((WebPath & ClosingDate & " Covers Work Order.pdf") as text)
	end try --Export as PDF
	export document CWODocName as "PDF" in ((WebPath & ClosingDate & " Covers Work Order.pdf") as text) PDF output style "Onofrio PDF PL 1up Output Style"
	
	--Replace text in html
	tell application "TextEdit"
		activate
		open file ((WebPath & ClosingDate & " report.html") as text)
		delay 1
		try
			set (paragraph 1 of document 1 where it contains "No covers for closing date") to "<embed src=\"" & ClosingDate & " Covers Work Order.pdf?t=<?php time(); ?\" type='application/pdf' width=\"450px\" height=\"640px\" scrolling=\"no\" /><br><br>" & return & return
			save document 1
		end try
		close document 1
	end tell
	
	--Mirror the local WebPath to the MacServer
	tell application "Fetch" to mirror alias ((text 1 through -10 of WebPath) as text) to url (("ftp://" & UserNme & ":" & Passwrd & "@192.168.0.20/Web/") as text) format Automatic with delete strays
	
	--Save the updated document
	close document CWODocName with saving
	
end tell


beep 2 --Let user know it's finished


script DoStuff
	
	set InputDate to date ((text 5 through 6 of ClosingDate & "/" & text 7 through 8 of ClosingDate & "/" & text 1 through 4 of ClosingDate) as text)
	
	if ((weekday of InputDate) as text) is "Wednesday" then
		
		set CurrentUser to Çevent SATIUPPEÈ (characters 1 through -2 of (last word of (path to home folder as text) & ".") as text)
		set ServerShowPath to "MAC_SERVER:SHOW FILES:"
		set CDDay to day of InputDate as text
		if CDDay as integer < 10 then set CDDay to "0" & CDDay as text
		set CDMonth to (month of InputDate as integer) as text
		if CDMonth as integer < 10 then set CDMonth to "0" & CDMonth as text
		set CDYear to year of InputDate as text
		set ShortDate to (CDYear & CDMonth & CDDay) as text
		set LongDate to (date string of InputDate) as text
		set WebPath to (("Macintosh SSD:Library:WebServer:Documents:" & ShortDate & ":") as text)
		
		tell application "Finder"
			activate
			
			try --Make the Closing Folder in Show Files
				make folder in folder ServerShowPath with properties {name:((ShortDate & " close") as text), owner:CurrentUser, group:"Mac"}
				make folder in folder ((ShortDate & " close") as text) of folder ServerShowPath with properties {name:"COVER INFO", owner:CurrentUser, group:"Mac"}
			end try
			
			--Create Closing folder in Website
			if not (exists (folder ("Macintosh SSD:Library:WebServer:Documents:" & ShortDate as text))) then make new folder at "Macintosh SSD:Library:WebServer:Documents:" with properties {name:ShortDate}
		end tell
		
		--Create Closing HTML file in Website
		set ReportHTML to "<html xmlns=\"http://www.w3.org/1999/xhtml\">
<head>
<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\" />
<meta http-equiv=\"Expires\" content=\"-1\"> 
<meta http-equiv=\"cache-control\" content=\"no-store\">
<meta http-equiv=\"Pragma\" content=\"no-cache\"> 
<?php Header(\"Cache-Control: max-age=3000, must-revalidate\"); ?>
<title>" & ShortDate & " WEB REPORTS</title>
</head>
<body>
<center>

<b>Cover Ads/Ad Counts</b><br>
No ads for closing date " & LongDate & " have been recorded<br><br>

<b>Catalog Covers</b><br>
No covers for closing date " & LongDate & " in production<br><br>

<b><font color=\"red\">RED</font> = not yet typed / <font color=\"blue\">BLUE</font> = typed but not proofed / <font color=\"green\">GREEN</font> = Ready for Catalog</b><br>
<b>Most items shown in red, blue, or green are clickable and will open a PDF document.</br><br>
</center>
</body>
</html>"
		
		--Write HTML code to Closing HTML file in Website
		set myFile to open for access (("Macintosh SSD:Library:WebServer:Documents:" & ShortDate & ":" & ShortDate & " report.html") as text) with write permission
		write ReportHTML to myFile
		close access myFile
		
		tell application "Finder"
			set ClosingList to name of every folder of folder "Macintosh SSD:Library:WebServer:Documents:" whose name starts with "20"
		end tell
		
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
		
		set ClosingListText to ""
		
		repeat with FolderCounter from 1 to count of items in ClosingList
			set LongDate to date string of (date ((text 5 through 6 of item FolderCounter of ClosingList & "/" & text 7 through 8 of item FolderCounter of ClosingList & "/" & text 1 through 4 of item FolderCounter of ClosingList) as text))
			set ClosingListText to ClosingListText & "<a href=\"" & item FolderCounter of ClosingList & "/" & item FolderCounter of ClosingList & " report.html?t=<?php time(); ?\" target=\"reportdoc\">" & LongDate & "</a><br>
"
		end repeat
		
		set IndexHTML to "<html xmlns=\"http://www.w3.org/1999/xhtml\">
<head>
<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\" />
<meta http-equiv=\"Expires\" content=\"-1\"> 
<meta http-equiv=\"cache-control\" content=\"no-store\">
<meta http-equiv=\"Pragma\" content=\"no-cache\"> 
<?php Header(\"Cache-Control: max-age=3000, must-revalidate\"); ?>
<title>WEB REPORTS</title>
</head>
<body><center>
<img src=\"http://www.onofrio.com/graphics/miniono.jpg\">
<h4>COMPOSITION DEPARTMENT REPORTS & PROOFS</h4>
<table style=\"width:900px\" align=\"left\" scrolling \"no\">
<tr>
<td width=\"220px\" valign=\"top\">
<h3>CLOSING DATE:</h3>
" & ClosingListText & "</td>
<td width=\"660px\" valign=\"top\">
<iframe src=\"" & FirstShortDate & "/" & FirstShortDate & " report.html\" width=\"100%\" height=\"1250px\" name=\"reportdoc\" id=\"reportdoc\">
<p>iframes are not supported by your browser.</p>
</iframe>
</td>
</tr>
</table>
</center></body>
</html>"
		
		tell application "Finder"
			if exists file (("Macintosh SSD:Library:WebServer:Documents:index.html") as text) then delete file (("Macintosh SSD:Library:WebServer:Documents:index.html") as text)
		end tell
		set myFile to open for access (("Macintosh SSD:Library:WebServer:Documents:index.html") as text) with write permission
		write IndexHTML to myFile
		close access myFile
		
		--Mirror the local WebPath to the MacServer
		tell application "Fetch" to mirror alias ((text 1 through -10 of WebPath) as text) to url (("ftp://" & UserNme & ":" & Passwrd & "@192.168.0.20/Web/") as text) format Automatic with delete strays
		
	else --Notify user that date was wrong
		activate
		display dialog "The date entered was not a Wednesday." & return & "Please try again." buttons "Cancel" default button 1 with icon stop
	end if
end script
