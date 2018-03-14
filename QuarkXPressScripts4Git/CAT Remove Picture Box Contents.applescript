tell application "QuarkXPress 2017"
	tell document 1
		repeat with x from 1 to count of pages
			try
				delete image 1 of every picture box of page x
			end try
		end repeat
	end tell
end tell


beep 2 --Let user know it's finished