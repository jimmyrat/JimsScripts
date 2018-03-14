tell application "QuarkXPress 2017"
	tell document 1
		set ColorList to name of color specs as list
		set NewColor to ((choose from list ColorList) as text)
		set color of every line box to NewColor
		set color of frame of every generic box to NewColor
		set color of (every paragraph of every text box whose color is not "White" and color is not null and color is not "None") to NewColor
		set properties of every paragraph of every text box to {rule below:{color:NewColor}, rule above:{color:NewColor}}
		set color of (every generic box whose color is not "White" and color is not null and color is not "None") to NewColor
		repeat with x from 1 to count of picture boxes
			try
				set color of image 1 of picture box x to NewColor
			end try
		end repeat
	end tell
end tell


beep 2 --Let user know script is finished