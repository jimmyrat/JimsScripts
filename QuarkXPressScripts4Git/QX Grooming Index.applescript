tell application "QuarkXPress 2017"
	tell current box of document 1
		
		try --Delete unneeded paragraphs
			delete (every paragraph of story 1 whose paragraph style does not contain "Index")
		end try
		
		tell (every paragraph of story 1 whose paragraph style is "IndexEntry")
			--Bold the grooming number
			set style of word -2 to bold
			--Also bold the return at end of paragraph
			set style of character -1 to bold
			--Delete the address
			delete (every character whose style is not bold)
			try --Add a tab between name and grooming number
				set every text where it is " RESERVED GRMNG" to tab
			end try
			try --Add a tab between name and grooming number
				set every text where it is " ASSIGNED GRMNG" to tab
			end try
		end tell
		
		--Delete the dashes so they will sort alphabetically
		tell (every paragraph of story 1 whose paragraph style is "IndexLetter") to delete (every character where it is "-")
		
		--Copy story 1 to a variable
		set UnsortedText to story 1
		
		--Temporarily replace hyphens in names with placeholder
		set UnsortedText to (change "-" in UnsortedText into "flargaldy")
		
		--Sort the list
		set SortedText to sortlist UnsortedText
		
		--Change the list back into a story
		set FixedText to ""
		repeat with X from 1 to count of items in SortedText
			set FixedText to FixedText & ((item X of SortedText as text) & return) as text
		end repeat
		
		--Put the sorted text back into text box
		set story 1 to FixedText
		
		--Reapply the style sheets
		set paragraph style of every paragraph of story 1 to null
		set paragraph style of every paragraph of story 1 to "IndexEntry"
		set paragraph style of (every paragraph of story 1 whose length = 2) to "IndexLetter"
		
		try --Change commas to tabs
			set (text 2 of every paragraph of story 1 where it is ",") to tab
			set (text 1 of every paragraph of story 1 where it is ",") to ", "
		end try
		
		--Repeat once for each paragraph
		repeat with ParaCounter from 1 to count of paragraphs of story 1
			try --Delete duplicate surnames
				delete (word 1 of words 2 through -1 of paragraph ParaCounter of story 1 where it is (word 1 of paragraph ParaCounter of story 1 as text))
			end try
		end repeat
		
		--Change the placeholders in names back to hyphens
		set (every text of story 1 where it is "flargaldy") to "-"
		
	end tell
end tell

beep 2


on sortlist (the_list)
	set old_delims to AppleScript's text item delimiters
	set AppleScript's text item delimiters to {ASCII character 10} -- always a linefeed
	set list_string to (the_list as string)
	set new_string to do shell script "echo " & quoted form of list_string & " | sort -f"
	set new_list to (paragraphs of new_string)
	set AppleScript's text item delimiters to old_delims
	return new_list
end sortlist