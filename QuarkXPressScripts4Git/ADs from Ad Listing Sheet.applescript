--Copyright 2013 by James Lake

--Create Show Closing folder for Cover Ad/Ad Count Sheet if it doesn't exist
--Account for late ads on Ad Writeup Sheet and Ad Count Sheet


tell application "QuarkXPress 2017"
	if (not (exists document 1)) or (not (exists text box "AdListBox" of document 1)) then display dialog "You must have an Ad Listing Sheet document open to run this script." buttons {"Cancel"} default button 1 with icon stop
	set ShowCode to story 1 of text box "ShowCodeBox" of document 1
	set AdList to story 1 of text box "AdListBox" of document 1
	set AdPath to file path of document 1
	set DocName to name of document 1 as text
	set LargeFormat to false
	if DocName contains "!" then set LargeFormat to true
	set AdTotal to 0.0
	set PhotoTotal to 0
	set AdOB to ""
	set AdIF to ""
	set AdIB to ""
end tell

if character 1 of DocName is " " then set DocName to text 2 through -1 of DocName
set ShowCode to uppercase (ShowCode as text)

set ShowLetter to character 1 of DocName
--If Ad Listing Sheet was named wrong, script will figure out correct Show Letter
if ShowLetter is not "A" and ShowLetter is not "B" and ShowLetter is not "C" then set ShowLetter to "A"

set ShowYear to text 2 through 3 of DocName
try --If Ad Listing Sheet was named wrong, script will figure out correct year
	if ShowYear as integer is not greater than 12 and ShowYear as integer is not less than 30 then set ShowYear to text 3 through 4 of (year of (get current date) as text)
on error
	set ShowYear to text 3 through 4 of (year of (get current date) as text)
end try

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
		
		--Skip lines with no advertiser listed, usually OB, IF, or IB --and skip Same as Last Year
		if item 3 of AdText is not "" then -- and item 6 of AdText is ""
			
			set AdNumber to item 2 of AdText as text
			
			--Add a leading zero to ads 1 through 9
			if (count of characters of AdNumber) is 1 then set AdNumber to "0" & AdNumber as text
			
			set Advertiser to item 3 of AdText
			
			--Get cover ads
			if AdNumber is "OB" then
				set AdOB to Advertiser
			else if AdNumber is "IF" then
				set AdIF to Advertiser
			else if AdNumber is "IB" then
				set AdIB to Advertiser
			end if
			
			set AdName to ShowLetter & ShowYear & " " & AdNumber & " " & Advertiser
			set AdCount to item 4 of AdText
			set SkipDoc to false
			
			--Change AdCount to PageSize for deleting guides
			if AdCount is "H" or AdCount is "1/2" or AdCount is "h" then
				set PageSize to "H"
				set AdTotal to AdTotal + 0.5
			else if AdCount is "Q" or AdCount is "1/4" or AdCount is "q" then
				set PageSize to "Q"
				set AdTotal to AdTotal + 0.25
			else if AdCount is "F" or AdCount is "1" or AdCount is "f" then
				set PageSize to "F"
				set AdTotal to AdTotal + 1
			else if AdCount as integer > 0 then
				set PageSize to "F"
				set AdTotal to (AdTotal + (AdCount as real))
			else
				set SkipDoc to true
			end if
			
			set FileExists to false
			if (exists file ((AdFolder & AdName & ".qxp") as text)) of application "System Events" then set FileExists to true
			
			if SkipDoc is false then
				
				--Open the Ad Template
				if FileExists is false then tell application "QuarkXPress 2017" to open Adtemplate
				
				--Translate ad sizes to actual numbers for page count
				if AdCount is "F" or AdCount is "H" or AdCount is "Q" or AdCount is "1/2" or AdCount is "1/4" or AdCount is "f" or AdCount is "h" or AdCount is "q" or AdCount is "Full" then
					set AdCount to 1
				else if (count of characters of AdCount) > 1 then
					set AdCount to (character 1 of AdCount as integer) as text
				end if
				
				if item 5 of AdText is "1" or item 5 of AdText is "X" or item 5 of AdText is "x" then set PhotoTotal to PhotoTotal + 1
				
				set AdColor to item 7 of AdText
				
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
				
				if FileExists is false then
					
					tell application "QuarkXPress 2017"
						activate
						
						--Delete guides to match ad size
						if PageSize is "F" then
							delete horizontal guides 1 through 2 of page 1 of master document 1
						else if PageSize is "H" then
							delete horizontal guide 1 of page 1 of master document 1
						else --if PageSize is "Q" then 
							delete horizontal guide 2 of page 1 of master document 1
						end if
						
						--Add pages to equal page count
						repeat ((AdCount as integer) - 1) times
							tell document 1 to make new page at end
						end repeat
						
						--Save and close the document
						set view scale of document 1 to 100
						save document 1 in ((AdFolder & AdName) as text) as document without template
						close document 1 saving no
						
					end tell
					
					try --Put Ad Placement in Finder's Get Info box for AD Save All as EPS script
						if AdPlacement is not "" then tell application "Finder" to set comment of file AdName of folder (AdFolder as text) to AdPlacement
					end try
					
				end if
				
			end if
			
		end if
		
	end if
	
end repeat

if AdTotal is 0.0 then set AdTotal to ""
if PhotoTotal is 0 then set PhotoTotal to ""

tell application "QuarkXPress 2017"
	
	--Enter the Ad Count and Photo Count into appropriate boxes
	set story 1 of text box 6 of page 1 of document 1 to AdTotal
	set story 1 of text box 7 of page 1 of document 1 to PhotoTotal
	
	--Open the Cover Ad Placement template for the closing date
	if DocName does not start with "Project" then
		
		--Get the closing date
		set CDText to story 1 of text box 19 of page 1 of document 1
		
		if CDText is not "" then
			
			if character 2 of CDText is "/" then
				set ClosingFolder to "20" & text 2 through 3 of DocName & "0" & character 1 of CDText & text 3 through 4 of CDText
			else if character 3 of CDText is "/" then
				set ClosingFolder to "20" & text 2 through 3 of DocName & text 1 through 2 of CDText & text 4 through 5 of CDText
			end if
			
			--Mark the Marked on Cover Listing Sheet check box
			set story 1 of text box 17 of page 1 of document DocName to "X"
			
			--See if a Cover Ad document for the closing date already exists
			if exists file ("MAC_SERVER:SHOW FILES:" & ClosingFolder & " close:COVER INFO:Cover Ad Placement.qxp") of application "System Events" then
				
				--Open the existing Cover Ad document
				open file ("MAC_SERVER:SHOW FILES:" & ClosingFolder & " close:COVER INFO:Cover Ad Placement.qxp")
				
				--Work with Ad Placement, page 1
				repeat with AdBoxCounter from 47 to 7 by -4
					
					--Fill in Ad Placements if Show Code already exists, skip if other club
					if story 1 of text box AdBoxCounter of page 1 of document 1 is ShowCode then
						if AdOB is "" and AdIF is "" and AdIB is "" then set story 1 of text box AdBoxCounter of page 1 of document 1 to ""
						set story 1 of text box (AdBoxCounter + 3) of page 1 of document 1 to AdOB
						set story 1 of text box (AdBoxCounter + 2) of page 1 of document 1 to AdIF
						set story 1 of text box (AdBoxCounter + 1) of page 1 of document 1 to AdIB
						exit repeat
						
						--Otherwise fill in Ad Placements in first blank row
					else if story 1 of text box AdBoxCounter of page 1 of document 1 is "" then
						if AdOB is not "" or AdIF is not "" or AdIB is not "" then set story 1 of text box AdBoxCounter of page 1 of document 1 to ShowCode
						set story 1 of text box (AdBoxCounter + 3) of page 1 of document 1 to AdOB
						set story 1 of text box (AdBoxCounter + 2) of page 1 of document 1 to AdIF
						set story 1 of text box (AdBoxCounter + 1) of page 1 of document 1 to AdIB
						exit repeat
					end if
					
				end repeat
				
				--Work with Ad Counts, page 2
				repeat with ShowBoxCounter from 59 to 9 by -5
					
					--Fill in Ad Counts if Show Code already exists, skip if other club
					if story 1 of text box ShowBoxCounter of page 2 of document 1 is ShowCode then
						set story 1 of text box (ShowBoxCounter - 1) of page 2 of document 1 to AdTotal
						set story 1 of text box (ShowBoxCounter + 3) of page 2 of document 1 to PhotoTotal
						exit repeat
						
						--Otherwise fill in Ad Counts in first blank row
					else if story 1 of text box ShowBoxCounter of page 2 of document 1 is "" then
						if AdTotal is not "" or PhotoTotal is not "" then set story 1 of text box ShowBoxCounter of page 2 of document 1 to ShowCode
						set story 1 of text box (ShowBoxCounter - 1) of page 2 of document 1 to AdTotal
						set story 1 of text box (ShowBoxCounter + 3) of page 2 of document 1 to PhotoTotal
						exit repeat
					end if
					
				end repeat
				
				--Save the updated document
				save document 1
				
			else --Open a new Cover Ad document template
				open file ("MAC_SERVER:SHARED FILES:TEMPLATES:Cover Ads-Ad Count Template.qpt")
				
				--Fill in appropriate information
				set story 1 of text box 2 of page 1 of document 1 to CDText
				set story 1 of text box 2 of page 2 of document 1 to CDText
				if AdOB is not "" and AdIF is not "" and AdIB is not "" then set story 1 of text box 47 of page 1 of document 1 to ShowCode
				set story 1 of text box 50 of page 1 of document 1 to AdOB
				set story 1 of text box 49 of page 1 of document 1 to AdIF
				set story 1 of text box 48 of page 1 of document 1 to AdIB
				set story 1 of text box 59 of page 2 of document 1 to ShowCode
				set story 1 of text box 58 of page 2 of document 1 to AdTotal
				set story 1 of text box 62 of page 2 of document 1 to PhotoTotal
				
				--Save in closing date folder in Show Files
				save document 1 in ("MAC_SERVER:SHOW FILES:" & ClosingFolder & " close:COVER INFO:Cover Ad Placement.qxp") as document without template
				
			end if
			
		end if
		
	end if
	
end tell

--Switch to Finder so Quark doesn't crash
tell application "Finder"
	activate
end tell
tell application "QuarkXPress 2017"
	activate
end tell

beep 2


to split(someText, delimiter) --This subroutine divides text into separate chunks
	set AppleScript's text item delimiters to delimiter
	set someText to someText's text items
	set AppleScript's text item delimiters to {""} --> restore delimiters to default value
	return someText
end split