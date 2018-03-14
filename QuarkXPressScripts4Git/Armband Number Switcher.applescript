tell application "QuarkXPress 2017"
	activate
	
	tell document 1
		
		set ParaList to index of (every paragraph of story 1 of text box "StartBox" whose paragraph style is "Number")
		
		repeat with ParaCounter from (count of items of ParaList) to 1 by -1
			
			set DigitCount to (count of characters of paragraph (item ParaCounter of ParaList) of story 1 of text box "StartBox") - 1
			
			repeat with DigitCounter from 1 to DigitCount
				
				set NumberText to character DigitCounter of paragraph (item ParaCounter of ParaList) of story 1 of text box "StartBox"
				
				--Change to item tool
				set tool mode to drag mode
				--Make sure nothing is selected
				set selection to null
				--Select the picture box
				select (first picture box of spread 1 whose name is NumberText)
				--Cut the picture box
				copy
				--Change to content tool
				set tool mode to contents mode
				--Make sure nothing is selected
				set selection to null
				--Indicate where to paste the picture box
				set selection to (character DigitCounter of paragraph (item ParaCounter of ParaList) of story 1 of text box "StartBox")
				--Paste the picture box into the text box
				paste
				
			end repeat
			
		end repeat
		
		--Change color of text back to black
		set paragraph style of every paragraph of story 1 of text box "StartBox" whose paragraph style is "Number" to "Number2"
		
	end tell
	
end tell

beep 2 --Let user know it's finished