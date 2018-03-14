--Copyright 2013 by James Lake

--Create Show Closing folder for Cover Ad/Ad Count Sheet if it doesn't exist --DONE 20160915
--Account for late ads on Ad Writeup Sheet and Ad Count Sheet DONE 20160915
--Don't overwrite color or bleed ad files --DONE 20160915
--Account for 3/4 page ads --DONE 20160915
--Make hyperlinks --DONE 20170505
--Make sure the closing folder exists in Macintosh SSD:Library:WebServer:Documents: --DONE 20160523
--Remove lines for ads (usually cover ads) not used
--Label the file with red/blue/green status
--Need to make sure CurrentDay is not larger than number of days in that month DONE 1/11/2018
--Only change text 1 through -2 to (red, blue, green), so that adding a line will default to black --DONE 1/15/18


tell application "QuarkXPress 2017"
	activate
	
	if (not (exists document 1)) or (not (exists text box "AdListBox" of document 1)) then display dialog "You must have an Ad Listing Sheet document open to run this script." buttons {"Cancel"} default button 1 with icon stop
	set DocName to name of document 1 as text
	set ShowCode to uppercase ((story 1 of text box "ShowCodeBox" of document DocName) as text)
	set ClosingDate to story 1 of text box "ClosingDateBox" of page 1 of document DocName
	set AdList to story 1 of text box "AdListBox" of document DocName
	set AdPath to file path of document DocName
	set LargeFormat to false
	if DocName contains "!" then set LargeFormat to true
	set WebPath to (("Macintosh SSD:Library:WebServer:Documents:" & ClosingDate & ":") as text)
	set UserNme to "USER"
	set Passwrd to "PWORD"
	set AdTotal to 0.0
	set LateAdtotal to 0.0
	set PhotoTotal to 0
	set LatePhotoTotal to 0
	set AdOB to ""
	set AdIF to ""
	set AdIB to ""
end tell

if character 1 of DocName is " " then set DocName to text 2 through -1 of DocName

tell application "Finder" to set AdFolder to container of AdPath as alias

if LargeFormat is false then
	set Adtemplate to alias "MAC_SERVER:SHARED FILES:TEMPLATES:AD Template.qpt"
else
	set Adtemplate to alias "MAC_SERVER:SHARED FILES:TEMPLATES:AD Template (8.5x11).qpt"
end if

repeat with ParaCounter from 1 to (count of paragraphs in AdList)
	
	if (count of characters of paragraph ParaCounter of AdList) > 5 then
		
		--Split the Ad line into separate items
		set AdText to split(paragraph ParaCounter of AdList, "	")
		set AdNumber to item 2 of AdText as text
		set Advertiser to item 3 of AdText as text
		set AdSize to item 4 of AdText as text
		
		--Skip lines with no page size/count listed, usually OB, IF, or IB
		if AdSize is not "" and AdSize is not "	" and AdSize is not null then
			
			--Add a leading zero to ads 1 through 9
			if (count of characters of AdNumber) is 1 then set AdNumber to "0" & AdNumber as text
			
			set AdName to ClosingDate & " " & AdNumber & " " & Advertiser
			set AdCount to item 4 of AdText
			set SkipDoc to false
			
			try
				set LateAdText to item 10 of AdText
				set LateAd to false
				if LateAdText is "X" or LateAdText is "x" then set LateAd to true
			end try
			
			--Change AdCount to PageSize for deleting guides
			if AdCount is "F" or AdCount is "f" or AdCount is "1" then
				set PageSize to "F"
				set PageCount to 1
				if LateAd is false then
					set AdTotal to AdTotal + 1
				else
					set LateAdtotal to LateAdtotal + 1
				end if
			else if AdCount is "H" or AdCount is "h" or AdCount is "1/2" or AdCount is ".5" then
				set PageSize to "H"
				set PageCount to 1
				if LateAd is false then
					set AdTotal to AdTotal + 0.5
				else
					set LateAdtotal to LateAdtotal + 0.5
				end if
			else if AdCount is "Q" or AdCount is "q" or AdCount is "1/4" or AdCount is ".25" then
				set PageSize to "Q"
				set PageCount to 1
				if LateAd is false then
					set AdTotal to AdTotal + 0.25
				else
					set LateAdtotal to LateAdtotal + 0.25
				end if
			else if AdCount is "3/4" or AdCount is ".75" then
				set PageSize to "F"
				set PageCount to 1
				if LateAd is false then
					set AdTotal to AdTotal + 0.75
				else
					set LateAdtotal to LateAdtotal + 0.75
				end if
			else if AdCount as real > 0 then
				set PageSize to "F"
				set PageCount to (AdCount as real)
				if LateAd is false then
					set AdTotal to (AdTotal + (AdCount as real))
				else
					set LateAdtotal to (LateAdtotal + (AdCount as real))
				end if
			else
				set SkipDoc to true
			end if
			
			if item 5 of AdText is "X" or item 5 of AdText is "x" or item 5 of AdText is "1" then
				if LateAd is false then
					set PhotoTotal to PhotoTotal + 1
				else
					set LatePhotoTotal to LatePhotoTotal + 1
				end if
			else if item 5 of AdText as real > 1 then
				if LateAd is false then
					set PhotoTotal to PhotoTotal + (item 5 of AdText as real)
				else
					set LatePhotoTotal to LatePhotoTotal + (item 5 of AdText as real)
				end if
			end if
			
			set AdColor to item 7 of AdText
			
			if SkipDoc is false then
				
				--Add marker to file name for AD Save All as EPS script
				if AdColor is "Color" or AdColor is "color" or AdColor is "COLOR" or AdColor is "C" or AdColor is "c" or AdColor is "X" or AdColor is "x" then
					set AdName to AdName & "*.qxp"
				else if AdColor is "Bleed" or AdColor is "bleed" or AdColor is "BLEED" or AdColor is "B" or AdColor is "b" then
					set AdName to AdName & "^.qxp"
				else if AdColor is "C/B" or AdColor is "c/b" or AdColor is "CB" or AdColor is "cb" or AdColor is "Both" then
					set AdName to AdName & "*^.qxp"
				else
					set AdName to AdName & ".qxp"
				end if
				
				set AdPlacement to item 9 of AdText
				
				--Get cover ads
				if AdNumber is "OB" then
					if AdName ends with "*^.qxp" then
						set AdOB to text 13 through -7 of AdName & " (COLOR)" as text
					else if AdName ends with "*.qxp" then
						set AdOB to text 13 through -6 of AdName & " (COLOR)" as text
					else if AdName ends with "^.qxp" then
						set AdOB to text 13 through -6 of AdName as text
					else
						set AdOB to text 13 through -5 of AdName as text
					end if
				else if AdNumber is "IF" then
					if AdName ends with "*^.qxp" then
						set AdIF to text 13 through -7 of AdName & " (COLOR)" as text
					else if AdName ends with "*.qxp" then
						set AdIF to text 13 through -6 of AdName & " (COLOR)" as text
					else if AdName ends with "^.qxp" then
						set AdIF to text 13 through -6 of AdName as text
					else
						set AdIF to text 13 through -5 of AdName as text
					end if
				else if AdNumber is "IB" then
					if AdName ends with "*^.qxp" then
						set AdIB to text 13 through -7 of AdName & " (COLOR)" as text
					else if AdName ends with "*.qxp" then
						set AdIB to text 13 through -6 of AdName & " (COLOR)" as text
					else if AdName ends with "^.qxp" then
						set AdIB to text 13 through -6 of AdName as text
					else
						set AdIB to text 13 through -5 of AdName as text
					end if
				end if
				
				if not (exists file ((AdFolder & AdName) as text)) of application "System Events" then
					
					--Open the Ad Template
					tell application "QuarkXPress 2017"
						activate
						
						try --Delete hyperlink
							activate
							set color of characters 1 through -2 of paragraph ParaCounter of story 1 of text box "AdListBox" of document DocName to "Red"
							set tool mode of document 1 to contents mode
							set selection to (paragraph ParaCounter of story 1 of text box "AdListBox" of document DocName)
							delay 1
							tell application "System Events"
								click menu item "Remove" of menu "Hyperlink" of menu item "Hyperlink" of menu "Style" of menu bar item "Style" of menu bar 1 of application process "QuarkXPress"
							end tell
						end try
						delay 1
						
						open Adtemplate
						
						set AdDocName to name of document 1 as text
						
						--Delete guides to match ad size
						if PageSize is "F" then
							delete horizontal guides 1 through 2 of page 1 of master document 1
						else if PageSize is "H" then
							delete horizontal guide 1 of page 1 of master document 1
						else --if PageSize is "Q" then 
							delete horizontal guide 2 of page 1 of master document 1
						end if
						
						--Add pages to equal page count
						repeat ((PageCount as real) - 1) times
							tell document AdDocName to make new page at end
						end repeat
						
						--Save and close the document
						set view scale of document AdDocName to 100
						save document AdDocName in ((AdFolder & AdName) as text) as document without template
						close document 1 saving no
						
					end tell
					
					try --Put Ad Placement in Finder's Get Info box for AD Save All as EPS script
						if AdPlacement is not "" or AdPlacement is not "	" then tell application "Finder" to set comment of file AdName of folder (AdFolder as text) to AdPlacement
					end try
					
				end if
				
			else
				
				--Open the Ad Template
				tell application "QuarkXPress 2017"
					activate
					try --Delete hyperlink
						set color of characters 1 through -2 of paragraph ParaCounter of story 1 of text box "AdListBox" of document DocName to "Red"
						set tool mode of document 1 to contents mode
						set selection to (paragraph ParaCounter of story 1 of text box "AdListBox" of document DocName)
						delay 1
						tell application "System Events"
							click menu item "Remove" of menu "Hyperlink" of menu item "Hyperlink" of menu "Style" of menu bar item "Style" of menu bar 1 of application process "QuarkXPress"
						end tell
					end try
					delay 1
				end tell
				
			end if
			
		end if
		
	end if
	
end repeat

if AdTotal is 0.0 then set AdTotal to ""
if PhotoTotal is 0 then set PhotoTotal to ""
if LateAdtotal is 0.0 then set LateAdtotal to ""
if LatePhotoTotal is 0 then set LatePhotoTotal to ""

set LongDate to ((date string of date ((text 5 through 6 of ClosingDate & "/" & text 7 through 8 of ClosingDate & "/" & text 1 through 4 of ClosingDate) as text)) as text)

try --Create Closing folder
	tell application "Finder" to make new folder at "Macintosh SSD:Library:WebServer:Documents:" with properties {name:ClosingDate}
	
	--Create Closing HTML file
	set ReportHTML to "<html xmlns=\"http://www.w3.org/1999/xhtml\">
<head>
<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\" />
<meta http-equiv=\"Expires\" content=\"-1\"> 
<meta http-equiv=\"cache-control\" content=\"no-store\">
<meta http-equiv=\"Pragma\" content=\"no-cache\"> 
<?php Header(\"Cache-Control: max-age=3000, must-revalidate\"); ?>
<title>" & ClosingDate & " WEB REPORTS</title>
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
	
	--Write HTML code to Closing HTML file
	set myFile to open for access ((WebPath & ClosingDate & " report.html") as text) with write permission
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
<iframe src=\"" & FirstShortDate & "/" & FirstShortDate & " report.html?t=<?php time(); ?\" width=\"100%\" height=\"1250px\" name=\"reportdoc\" id=\"reportdoc\">
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
	
end try

tell application "QuarkXPress 2017"
	activate
	
	delay 1 --Enter the Ad Count and Photo Count into appropriate boxes
	set story 1 of text box 6 of page 1 of document DocName to AdTotal
	set story 1 of text box 7 of page 1 of document DocName to PhotoTotal
	set story 1 of text box 8 of page 1 of document DocName to LateAdtotal
	set story 1 of text box 9 of page 1 of document DocName to LatePhotoTotal
	
	--Mark the Marked on Cover Listing Sheet check box
	set story 1 of text box 17 of page 1 of document DocName to "X"
	
	--Change the Bill/Pd line to Late
	if word -1 of story 1 of text box 1 of document DocName is not "LATE" then
		set word 19 of story 1 of text box 1 of document DocName to ""
		set word -1 of story 1 of text box 1 of document DocName to "LATE"
	end if
	
	try --Delete existing PDF
		tell application "Finder" to delete file ((WebPath & ShowCode & " AD00 Ad Listing Sheet.pdf") as text)
	end try --Export as PDF
	export every page of document DocName as "PDF" in ((WebPath & ShowCode & " AD00 Ad Listing Sheet.pdf") as text) --PDF output style "Onofrio PDF PL 1up Output Style"
	
	--Make a Closing folder if it does not already exist
	tell application "System Events"
		
		--See if a Closing Date folder in SHOW FILES already exists
		if not (exists folder ("MAC_SERVER:SHOW FILES:" & ClosingDate & " close:")) then
			
			set ServerShowPath to "MAC_SERVER:SHOW FILES:"
			make folder in folder ServerShowPath with properties {name:((ClosingDate & " close") as text)}
			make folder in folder ((ClosingDate & " close") as text) of folder ServerShowPath with properties {name:"COVER INFO"}
			
		end if
		
	end tell
	
	--See if a Cover Ad document for the closing date already exists
	if exists file ("MAC_SERVER:SHOW FILES:" & ClosingDate & " close:COVER INFO:Cover Ad Placement.qxp") of application "System Events" then
		
		--Open the existing Cover Ad document
		open file ("MAC_SERVER:SHOW FILES:" & ClosingDate & " close:COVER INFO:Cover Ad Placement.qxp")
		
		set CoverAdDoc to name of document 1 as text
		
		--Work with Ad Placement, page 1
		repeat with AdBoxCounter from 47 to 7 by -4
			
			--Fill in Ad Placements if Show Code already exists, skip if other club
			if story 1 of text box AdBoxCounter of page 1 of document CoverAdDoc is ShowCode then
				if AdOB is "" and AdIF is "" and AdIB is "" then set story 1 of text box AdBoxCounter of page 1 of document CoverAdDoc to ""
				if AdOB is not "" then
					set story 1 of text box (AdBoxCounter + 3) of page 1 of document CoverAdDoc to AdOB
					try --Delete hyperlink
						activate
						set tool mode of document 1 to contents mode
						set selection to (story 1 of text box (AdBoxCounter + 3) of page 1 of document CoverAdDoc)
						delay 1
						tell application "System Events"
							click menu item "Remove" of menu "Hyperlink" of menu item "Hyperlink" of menu "Style" of menu bar item "Style" of menu bar 1 of application process "QuarkXPress"
						end tell
					end try
					try --Create hyperlink
						activate
						set color of (story 1 of text box (AdBoxCounter + 3) of page 1 of document CoverAdDoc) to "Red"
						set tool mode of document 1 to contents mode
						set selection to (story 1 of text box (AdBoxCounter + 3) of page 1 of document CoverAdDoc)
						delay 1
						tell application "System Events"
							click menu item "New..." of menu "Hyperlink" of menu item "Hyperlink" of menu "Style" of menu bar item "Style" of menu bar 1 of application process "QuarkXPress"
							keystroke ((ShowCode & " ADOB " & AdOB & ".pdf") as text) & tab & ((ShowCode & " ADOB " & AdOB & ".pdf") as text) & return
						end tell
					end try
					delay 1
				end if
				if AdIF is not "" then
					set story 1 of text box (AdBoxCounter + 2) of page 1 of document CoverAdDoc to AdIF
					try --Delete hyperlink
						activate
						set tool mode of document 1 to contents mode
						set selection to (story 1 of text box (AdBoxCounter + 2) of page 1 of document CoverAdDoc)
						delay 1
						tell application "System Events"
							click menu item "Remove" of menu "Hyperlink" of menu item "Hyperlink" of menu "Style" of menu bar item "Style" of menu bar 1 of application process "QuarkXPress"
						end tell
					end try
					try --Create hyperlink
						activate
						set color of (story 1 of text box (AdBoxCounter + 2) of page 1 of document CoverAdDoc) to "Red"
						set tool mode of document 1 to contents mode
						set selection to (story 1 of text box (AdBoxCounter + 2) of page 1 of document CoverAdDoc)
						delay 1
						tell application "System Events"
							click menu item "New..." of menu "Hyperlink" of menu item "Hyperlink" of menu "Style" of menu bar item "Style" of menu bar 1 of application process "QuarkXPress"
							keystroke ((ShowCode & " ADIF " & AdIF & ".pdf") as text) & tab & ((ShowCode & " ADIF " & AdIF & ".pdf") as text) & return
						end tell
					end try
					delay 1
				end if
				if AdIB is not "" then
					set story 1 of text box (AdBoxCounter + 1) of page 1 of document CoverAdDoc to AdIB
					try --Delete hyperlink
						activate
						set tool mode of document 1 to contents mode
						set selection to (story 1 of text box (AdBoxCounter + 1) of page 1 of document CoverAdDoc)
						delay 1
						tell application "System Events"
							click menu item "Remove" of menu "Hyperlink" of menu item "Hyperlink" of menu "Style" of menu bar item "Style" of menu bar 1 of application process "QuarkXPress"
						end tell
					end try
					try --Create hyperlink
						activate
						set color of (story 1 of text box (AdBoxCounter + 1) of page 1 of document CoverAdDoc) to "Red"
						set tool mode of document 1 to contents mode
						set selection to (story 1 of text box (AdBoxCounter + 1) of page 1 of document CoverAdDoc)
						delay 1
						tell application "System Events"
							click menu item "New..." of menu "Hyperlink" of menu item "Hyperlink" of menu "Style" of menu bar item "Style" of menu bar 1 of application process "QuarkXPress"
							keystroke ((ShowCode & " ADIB " & AdIB & ".pdf") as text) & tab & ((ShowCode & " ADIB " & AdIB & ".pdf") as text) & return
						end tell
					end try
					delay 1
				end if
				exit repeat
				
				--Otherwise fill in Ad Placements in first blank row
			else if story 1 of text box AdBoxCounter of page 1 of document CoverAdDoc is "" then
				if AdOB is not "" or AdIF is not "" or AdIB is not "" then set story 1 of text box AdBoxCounter of page 1 of document CoverAdDoc to ShowCode
				if AdOB is not "" then
					set story 1 of text box (AdBoxCounter + 3) of page 1 of document CoverAdDoc to AdOB
					try --Delete hyperlink
						activate
						set tool mode of document 1 to contents mode
						set selection to (story 1 of text box (AdBoxCounter + 3) of page 1 of document CoverAdDoc)
						delay 1
						tell application "System Events"
							click menu item "Remove" of menu "Hyperlink" of menu item "Hyperlink" of menu "Style" of menu bar item "Style" of menu bar 1 of application process "QuarkXPress"
						end tell
					end try
					try --Create hyperlink
						activate
						set color of (story 1 of text box (AdBoxCounter + 3) of page 1 of document CoverAdDoc) to "Red"
						set tool mode of document 1 to contents mode
						set selection to (story 1 of text box (AdBoxCounter + 3) of page 1 of document CoverAdDoc)
						delay 1
						tell application "System Events"
							click menu item "New..." of menu "Hyperlink" of menu item "Hyperlink" of menu "Style" of menu bar item "Style" of menu bar 1 of application process "QuarkXPress"
							keystroke ((ShowCode & " ADOB " & AdOB & ".pdf") as text) & tab & ((ShowCode & " ADOB " & AdOB & ".pdf") as text) & return
						end tell
					end try
					delay 1
				end if
				if AdIF is not "" then
					set story 1 of text box (AdBoxCounter + 2) of page 1 of document CoverAdDoc to AdIF
					try --Delete hyperlink
						activate
						set tool mode of document 1 to contents mode
						set selection to (story 1 of text box (AdBoxCounter + 2) of page 1 of document CoverAdDoc)
						delay 1
						tell application "System Events"
							click menu item "Remove" of menu "Hyperlink" of menu item "Hyperlink" of menu "Style" of menu bar item "Style" of menu bar 1 of application process "QuarkXPress"
						end tell
					end try
					try --Create hyperlink
						activate
						set color of (story 1 of text box (AdBoxCounter + 2) of page 1 of document CoverAdDoc) to "Red"
						set tool mode of document 1 to contents mode
						set selection to (story 1 of text box (AdBoxCounter + 2) of page 1 of document CoverAdDoc)
						delay 1
						tell application "System Events"
							click menu item "New..." of menu "Hyperlink" of menu item "Hyperlink" of menu "Style" of menu bar item "Style" of menu bar 1 of application process "QuarkXPress"
							keystroke ((ShowCode & " ADIF " & AdIF & ".pdf") as text) & tab & ((ShowCode & " ADIF " & AdIF & ".pdf") as text) & return
						end tell
					end try
					delay 1
				end if
				if AdIB is not "" then
					set story 1 of text box (AdBoxCounter + 1) of page 1 of document CoverAdDoc to AdIB
					try --Delete hyperlink
						activate
						set tool mode of document 1 to contents mode
						set selection to (story 1 of text box (AdBoxCounter + 1) of page 1 of document CoverAdDoc)
						delay 1
						tell application "System Events"
							click menu item "Remove" of menu "Hyperlink" of menu item "Hyperlink" of menu "Style" of menu bar item "Style" of menu bar 1 of application process "QuarkXPress"
						end tell
					end try
					try --Create hyperlink
						activate
						set color of (story 1 of text box (AdBoxCounter + 1) of page 1 of document CoverAdDoc) to "Red"
						set tool mode of document 1 to contents mode
						set selection to (story 1 of text box (AdBoxCounter + 1) of page 1 of document CoverAdDoc)
						delay 1
						tell application "System Events"
							click menu item "New..." of menu "Hyperlink" of menu item "Hyperlink" of menu "Style" of menu bar item "Style" of menu bar 1 of application process "QuarkXPress"
							keystroke ((ShowCode & " ADIB " & AdIB & ".pdf") as text) & tab & ((ShowCode & " ADIB " & AdIB & ".pdf") as text) & return
						end tell
					end try
					delay 1
				end if
				exit repeat
			end if
			
		end repeat
		
		--Work with Ad Counts, page 2
		repeat with ShowBoxCounter from 59 to 9 by -5
			
			--Fill in Ad Counts if Show Code already exists, skip if other club
			if story 1 of text box ShowBoxCounter of page 2 of document CoverAdDoc is ShowCode and color of (story 1 of text box ShowBoxCounter of page 2 of document CoverAdDoc) is not "Blue" and color of (story 1 of text box ShowBoxCounter of page 2 of document CoverAdDoc) is not "Green" then
				try --Delete hyperlink
					activate
					set tool mode of document 1 to contents mode
					set selection to (story 1 of text box ShowBoxCounter of page 2 of document CoverAdDoc)
					delay 1
					tell application "System Events"
						click menu item "Remove" of menu "Hyperlink" of menu item "Hyperlink" of menu "Style" of menu bar item "Style" of menu bar 1 of application process "QuarkXPress"
					end tell
				end try
				try --Create hyperlink
					activate
					set color of (story 1 of text box ShowBoxCounter of page 2 of document CoverAdDoc) to "Red"
					set tool mode of document 1 to contents mode
					set selection to (story 1 of text box ShowBoxCounter of page 2 of document CoverAdDoc)
					delay 1
					tell application "System Events"
						click menu item "New..." of menu "Hyperlink" of menu item "Hyperlink" of menu "Style" of menu bar item "Style" of menu bar 1 of application process "QuarkXPress"
						keystroke ((ShowCode & " AD00 Ad Listing Sheet.pdf") as text) & tab & ((ShowCode & " AD00 Ad Listing Sheet.pdf") as text) & return
					end tell
				end try
				delay 1
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
					set tool mode of document 1 to contents mode
					set selection to (story 1 of text box ShowBoxCounter of page 2 of document CoverAdDoc)
					delay 1
					tell application "System Events"
						click menu item "Remove" of menu "Hyperlink" of menu item "Hyperlink" of menu "Style" of menu bar item "Style" of menu bar 1 of application process "QuarkXPress"
					end tell
				end try
				try --Create hyperlink
					activate
					set color of (story 1 of text box ShowBoxCounter of page 2 of document CoverAdDoc) to "Red"
					set tool mode of document 1 to contents mode
					set selection to (story 1 of text box ShowBoxCounter of page 2 of document CoverAdDoc)
					delay 1
					tell application "System Events"
						click menu item "New..." of menu "Hyperlink" of menu item "Hyperlink" of menu "Style" of menu bar item "Style" of menu bar 1 of application process "QuarkXPress"
						keystroke ((ShowCode & " AD00 Ad Listing Sheet.pdf") as text) & tab & ((ShowCode & " AD00 Ad Listing Sheet.pdf") as text) & return
					end tell
				end try
				delay 1
				set story 1 of text box (ShowBoxCounter - 1) of page 2 of document CoverAdDoc to AdTotal
				set story 1 of text box (ShowBoxCounter + 3) of page 2 of document CoverAdDoc to PhotoTotal
				set story 1 of text box (ShowBoxCounter + 2) of page 2 of document CoverAdDoc to LateAdtotal
				set story 1 of text box (ShowBoxCounter + 1) of page 2 of document CoverAdDoc to LatePhotoTotal
				exit repeat
				--end if
			end if
			
		end repeat
		
		try --Delete existing PDF
			tell application "Finder" to delete file ((WebPath & ClosingDate & " Cover Ad Placement.pdf") as text)
		end try --Export as PDF
		export every page of document CoverAdDoc as "PDF" in ((WebPath & ClosingDate & " Cover Ad Placement.pdf") as text) --PDF output style "Onofrio PDF PL 2up Output Style"
		
		--Save the updated document
		save document CoverAdDoc
		
		--Replace text in html
		tell application "TextEdit"
			activate
			open file ((WebPath & ClosingDate & " report.html") as text)
			try
				set paragraph 1 of document 1 where it contains "No ads for closing date" to "<embed src=\"" & ClosingDate & " Cover Ad Placement.pdf\" type='application/pdf' width=\"500px\" height=\"450px\" scrolling=\"no\" /><br><br>" & return & return
			end try
			save document 1
			close document 1
		end tell
		
	else --Open a new Cover Ad document template
		open file ("MAC_SERVER:SHARED FILES:TEMPLATES:Cover Ads-Ad Count Template.qpt")
		
		set CoverAdDoc to name of document 1 as text
		
		--Fill in appropriate information
		set story 1 of text box 2 of page 1 of document CoverAdDoc to ClosingDate
		set story 1 of text box 2 of page 2 of document CoverAdDoc to ClosingDate
		--work with page 1
		if AdOB is not "" or AdIF is not "" or AdIB is not "" then set story 1 of text box 47 of page 1 of document CoverAdDoc to ShowCode
		set story 1 of text box 50 of page 1 of document CoverAdDoc to AdOB
		if not (exists file ((WebPath & ShowCode & " ADOB " & AdOB & ".pdf") as text)) of application "System Events" then
			try --Delete hyperlink
				activate
				set color of (story 1 of text box 50 of page 1 of document CoverAdDoc) to "Red"
				set tool mode of document 1 to contents mode
				set selection to (story 1 of text box (AdBoxCounter + 2) of page 1 of document CoverAdDoc)
				delay 1
				tell application "System Events"
					click menu item "Remove" of menu "Hyperlink" of menu item "Hyperlink" of menu "Style" of menu bar item "Style" of menu bar 1 of application process "QuarkXPress"
				end tell
			end try
		else
			try --Create hyperlink
				activate
				set color of (story 1 of text box 50 of page 1 of document CoverAdDoc) to "Red"
				set tool mode of document 1 to contents mode
				set selection to (story 1 of text box 50 of page 1 of document CoverAdDoc)
				delay 1
				tell application "System Events"
					click menu item "New..." of menu "Hyperlink" of menu item "Hyperlink" of menu "Style" of menu bar item "Style" of menu bar 1 of application process "QuarkXPress"
					keystroke ((ShowCode & " ADOB " & AdOB & ".pdf") as text) & tab & ((ShowCode & " ADOB " & AdOB & ".pdf") as text) & return
				end tell
			end try
			delay 1
		end if
		set story 1 of text box 49 of page 1 of document CoverAdDoc to AdIF
		if not (exists file ((WebPath & ShowCode & " ADIF " & AdIF & ".pdf") as text)) of application "System Events" then
			try --Delete hyperlink
				activate
				set color of (story 1 of text box 49 of page 1 of document CoverAdDoc) to "Red"
				set tool mode of document 1 to contents mode
				set selection to (story 1 of text box (AdBoxCounter + 2) of page 1 of document CoverAdDoc)
				delay 1
				tell application "System Events"
					click menu item "Remove" of menu "Hyperlink" of menu item "Hyperlink" of menu "Style" of menu bar item "Style" of menu bar 1 of application process "QuarkXPress"
				end tell
			end try
			delay 1
		else
			try --Create hyperlink
				activate
				set color of (story 1 of text box 49 of page 1 of document CoverAdDoc) to "Red"
				set tool mode of document 1 to contents mode
				set selection to (story 1 of text box 49 of page 1 of document CoverAdDoc)
				delay 1
				tell application "System Events"
					click menu item "New..." of menu "Hyperlink" of menu item "Hyperlink" of menu "Style" of menu bar item "Style" of menu bar 1 of application process "QuarkXPress"
					keystroke ((ShowCode & " ADIF " & AdIF & ".pdf") as text) & tab & ((ShowCode & " ADIF " & AdIF & ".pdf") as text) & return
				end tell
			end try
			delay 1
		end if
		set story 1 of text box 48 of page 1 of document CoverAdDoc to AdIB
		if not (exists file ((WebPath & ShowCode & " ADIB " & AdIB & ".pdf") as text)) of application "System Events" then
			try --Delete hyperlink
				activate
				set color of (story 1 of text box 48 of page 1 of document CoverAdDoc) to "Red"
				set tool mode of document 1 to contents mode
				set selection to (story 1 of text box (AdBoxCounter + 2) of page 1 of document CoverAdDoc)
				delay 1
				tell application "System Events"
					click menu item "Remove" of menu "Hyperlink" of menu item "Hyperlink" of menu "Style" of menu bar item "Style" of menu bar 1 of application process "QuarkXPress"
				end tell
			end try
			delay 1
		else
			try --Create hyperlink
				activate
				set color of (story 1 of text box 48 of page 1 of document CoverAdDoc) to "Red"
				set tool mode of document 1 to contents mode
				set selection to (story 1 of text box 48 of page 1 of document CoverAdDoc)
				delay 1
				tell application "System Events"
					click menu item "New..." of menu "Hyperlink" of menu item "Hyperlink" of menu "Style" of menu bar item "Style" of menu bar 1 of application process "QuarkXPress"
					keystroke ((ShowCode & " ADIB " & AdIB & ".pdf") as text) & tab & ((ShowCode & " ADIB " & AdIB & ".pdf") as text) & return
				end tell
			end try
			delay 1
		end if
		--Work with page 2
		set story 1 of text box 59 of page 2 of document CoverAdDoc to ShowCode
		try --Create hyperlink
			activate
			set color of (story 1 of text box 59 of page 2 of document CoverAdDoc) to "Red"
			set tool mode of document 1 to contents mode
			set selection to (story 1 of text box 59 of page 2 of document CoverAdDoc)
			delay 1
			tell application "System Events"
				click menu item "New..." of menu "Hyperlink" of menu item "Hyperlink" of menu "Style" of menu bar item "Style" of menu bar 1 of application process "QuarkXPress"
				keystroke ((ShowCode & " AD00 Ad Listing Sheet.pdf") as text) & tab & ((ShowCode & " AD00 Ad Listing Sheet.pdf") as text) & return
			end tell
		end try
		delay 1
		set story 1 of text box 58 of page 2 of document CoverAdDoc to AdTotal
		set story 1 of text box 62 of page 2 of document CoverAdDoc to PhotoTotal
		set story 1 of text box 61 of page 2 of document CoverAdDoc to LateAdtotal
		set story 1 of text box 60 of page 2 of document CoverAdDoc to LatePhotoTotal
		
		try --Delete existing PDF
			tell application "Finder" to delete file ((WebPath & ClosingDate & " Cover Ad Placement.pdf") as text)
		end try --Export as PDF
		export every page of document CoverAdDoc as "PDF" in ((WebPath & ClosingDate & " Cover Ad Placement.pdf") as text) --PDF output style "Onofrio PDF PL 2up Output Style"
		
		--Save in closing date folder in Show Files
		save document CoverAdDoc in ("MAC_SERVER:SHOW FILES:" & ClosingDate & " close:COVER INFO:Cover Ad Placement.qxp") as document without template
		
		--Replace text in html
		tell application "TextEdit"
			activate
			open file ((WebPath & ClosingDate & " report.html") as text)
			try
				set paragraph 1 of document 1 where it contains "No ads for closing date" to "<embed src=\"" & ClosingDate & " Cover Ad Placement.pdf\" type='application/pdf' width=\"500px\" height=\"450px\" scrolling=\"no\" /><br><br>" & return & return
			end try
			save document 1
			close document 1
		end tell
		
	end if
	
end tell

--Switch to Finder so Quark doesn't crash
tell application "Finder"
	activate
end tell
tell application "QuarkXPress 2017"
	activate
end tell

--Mirror the local WebPath to the MacServer
tell application "Fetch" to mirror alias ((text 1 through -10 of WebPath) as text) to url (("ftp://" & UserNme & ":" & Passwrd & "@192.168.0.20/Web/") as text) format Automatic with delete strays

beep 2 --Let user know script is finished


to split(someText, delimiter) --This subroutine divides text into separate chunks
	set AppleScript's text item delimiters to delimiter
	set someText to someText's text items
	set AppleScript's text item delimiters to {""} --> restore delimiters to default value
	return someText
end split