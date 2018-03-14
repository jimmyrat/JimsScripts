--Copyright 2002 by James Lake.


tell application "Finder"
	activate
	
	set PicPath to ((choose file with prompt "Locate the first image to place:") as text)
	set FileType to text -3 through -1 of PicPath
	set PicPrefix to text 1 through -8 of PicPath
	
end tell

tell application "QuarkXPress 2017"
	activate
	
	tell document 1
		
		with timeout of 600 seconds
			
			repeat with PageCounter from 1 to count of pages
				
				if PageCounter < 10 then
					set FileName to PicPrefix & "00" & PageCounter
				else if PageCounter < 100 then
					set FileName to PicPrefix & "0" & PageCounter
				else
					set FileName to PicPrefix & "" & PageCounter
				end if
				
				--set FileName to PicPrefix & " " & PageCounter
				
				tell page PageCounter
					
					if exists alias ((FileName & "." & FileType) as text) of application "Finder" then
						set image 1 of picture box 1 to alias ((FileName & "." & FileType) as text)
					else
						display dialog "There are more pages, but no more images." buttons {"Cancel"} default button 1 with icon stop
					end if
					
				end tell
				
			end repeat
			
		end timeout
		
	end tell
	
end tell

beep 2