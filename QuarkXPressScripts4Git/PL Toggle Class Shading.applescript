tell application "QuarkXPress 2017"
	
	--Make sure a Quark document is open
	if exists document 1 then
		
		--Make sure the ClassShaded style sheet exists
		if exists style spec "PL-ClassShaded" of document 1 then
			
			if rule on of rule above of paragraph attributes of style spec "PL-ClassShaded" of document 1 is true then
				set rule on of rule above of paragraph attributes of style spec "PL-ClassShaded" of document 1 to false
			else
				set rule on of rule above of paragraph attributes of style spec "PL-ClassShaded" of document 1 to true
			end if
			
		else --Let user know that ClassShaded style sheet does not exist
			display dialog "there are no paragraphs with a paragraph style of PL-ClassShaded in this document." buttons {"Cancel"} default button 1 with icon stop
		end if
		
	else --Let user know Quark document wasn't open
		display dialog "You must have a Quark document open before running this script." buttons {"Cancel"} default button 1 with icon stop
	end if
	
	tell me to beep 2 --Let user know it's finished
	
end tell