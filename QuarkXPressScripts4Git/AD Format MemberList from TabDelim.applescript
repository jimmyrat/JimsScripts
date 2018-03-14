script DoStuff
	
	tell application "QuarkXPress 2017"
		tell story 1 of current box of document 1
			
			repeat with x from (count of paragraphs) to 1 by -1
				set xtext to paragraph x
				set xtext to («event WaynRPLC» tab without «class ALLO» given «class in  »:xtext, «class with»:" ")
				set xtext to («event WaynRPLC» tab without «class ALLO» given «class in  »:xtext, «class with»:return)
				set xtext to («event WaynRPLC» tab without «class ALLO» given «class in  »:xtext, «class with»:return)
				set xtext to («event WaynRPLC» tab without «class ALLO» given «class in  »:xtext, «class with»:" ")
				set xtext to («event WaynRPLC» tab without «class ALLO» given «class in  »:xtext, «class with»:" ")
				set xtext to («event WaynRPLC» tab without «class ALLO» given «class in  »:xtext, «class with»:return)
				set xtext to («event WaynRPLC» tab without «class ALLO» given «class in  »:xtext, «class with»:(return & "cell: "))
				set xtext to («event WaynRPLC» tab without «class ALLO» given «class in  »:xtext, «class with»:return)
				set xtext to («event WaynRPLC» tab without «class ALLO» given «class in  »:xtext, «class with»:return)
				set paragraph x to xtext
			end repeat
			
			set y to 0
			
			repeat with x from 1 to (count of paragraphs)
				set y to y + 1
				if y = 1 then
					set paragraph style of paragraph x to "Name"
				else if y = 7 then
					set paragraph style of paragraph x to "Breed"
					set y to 0
				else
					set paragraph style of paragraph x to "Address"
				end if
			end repeat
			
			delete (every paragraph where it is return)
			delete (every paragraph where it is ("cell: " & return))
			
		end tell
	end tell
	
end script


tell application "QuarkXPress 2017"
	
	do script {DoStuff}
	
	beep 2
	
end tell