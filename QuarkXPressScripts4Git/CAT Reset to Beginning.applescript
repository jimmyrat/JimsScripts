tell application "QuarkXPress 2017"
	tell document 1
		delete every picture box
		set name of every text box of story 1 of text box "StartBox" of page 1 to "StartBox"
		delete (every text box whose name is not "StartBox" and name does not end with "Header" and story 1 does not start with "Page ")
	end tell
end tell


beep 2 --Let user know it's finished