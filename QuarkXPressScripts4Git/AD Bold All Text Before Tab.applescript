script DoStuff
	
	tell application "QuarkXPress 2017"
		tell story 1 of current box of document 1
			
			--Remember the old value
			set ASTID to AppleScript's AppleScript's text item delimiters
			--Define the character we want to divide by
			set AppleScript's text item delimiters to tab
			
			repeat with ParaCounter from 1 to (count of paragraphs)
				set TestText to item 1 of text items of (paragraph ParaCounter as string)
				set (style of text of paragraph ParaCounter where it is TestText) to bold
			end repeat
			
		end tell
	end tell
	
	--Always set it back
	set AppleScript's text item delimiters to ASTID
	
end script


tell application "QuarkXPress 2017"
	
	do script {DoStuff}
	
	beep 2
	
end tell