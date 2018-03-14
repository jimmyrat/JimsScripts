tell application "QuarkXPress 2017"
	activate
	
	with timeout of 600 seconds
		
		set MoveAmount to "1p6" --text returned of (display dialog "Enter the amount in picas:" default answer "1p6" with icon note)
		set MoveLeft to (("- " & MoveAmount) as text)
		set MoveRight to (("+ " & MoveAmount) as text)
		
		set MasterDoc1 to object reference of spread 2 of master document 1
		
		tell MasterDoc1
			tell picture box 1
				set T to top of bounds
				set T to (coerce T to string)
				set L to left of bounds
				set L to (coerce L to string)
				set origin of bounds to {T, ((L & MoveRight) as text)}
			end tell
			tell picture box 3
				set T to top of bounds
				set T to (coerce T to string)
				set L to left of bounds
				set L to (coerce L to string)
				set origin of bounds to {T, ((L & MoveRight) as text)}
			end tell
			tell picture box 2
				set T to top of bounds
				set T to (coerce T to string)
				set L to left of bounds
				set L to (coerce L to string)
				set origin of bounds to {T, ((L & MoveLeft) as text)}
			end tell
			tell picture box 4
				set T to top of bounds
				set T to (coerce T to string)
				set L to left of bounds
				set L to (coerce L to string)
				set origin of bounds to {T, ((L & MoveLeft) as text)}
			end tell
		end tell
		
	end timeout
	
end tell