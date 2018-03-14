tell application "QuarkXPress 2017"
	tell master document 1
		delete (every picture box whose shade is "80%")
	end tell
	tell document 1
		try
			set properties of style spec "Group" to {character attributes:{color:"black"}}
		end try
	end tell
	tell document 1
		set view scale to "100%"
	end tell
end tell