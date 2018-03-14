tell application "QuarkXPress 2017"
	tell document 1
		tell story 1 of text box "StartBox" of page 1
			try
				delete (every paragraph where it contains "@Ring/Time:")
			end try
			try
				delete (every paragraph whose name of paragraph style is "Ring/Time")
			end try
		end tell
		try
			set properties of style spec "Judge" to {paragraph attributes:{space after:"p3"}}
		end try
	end tell
end tell