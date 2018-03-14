global FileList


on Setup() --This defines a subroutine
	
	tell application "Finder"
		
		set FileList to FileList as list
		
		--Repeat once for each cover file to be converted
		repeat with FileCounter from 1 to count of items in FileList
			try
				set FilePath to ((item FileCounter of FileList) as text)
				set ExpandedFolder to text 1 through -6 of FilePath as text
				set FileContainer to (container of alias FilePath as text)
				set OrigName to (name of file FilePath as text)
				set ShortName to text 1 through -6 of OrigName
				set ZipName to ((ShortName & ".zip") as text)
				set name of file FilePath to ZipName
				do shell script "/usr/bin/ditto -xk " & quoted form of POSIX path of ((FileContainer & ZipName) as text) & space & quoted form of POSIX path of ((FileContainer & ShortName) as text)
				set name of file ZipName of folder FileContainer to OrigName
				move folder ((ExpandedFolder & ":word:media:") as text) to FileContainer
				set name of folder ((FileContainer & "media:") as text) to ((ShortName & " Images") as text)
				delete folder ExpandedFolder
			end try
		end repeat
		
	end tell
	
end Setup


on open DroppedFileList --Do this when a file is dropped onto script
	
	with timeout of 900 seconds
		
		set FileList to DroppedFileList
		Setup() --Do the Setup subroutine
		
	end timeout
	
	beep 2 --Let the user know it's finished
	
end open


on run --Do this when script is double-clicked
	
	with timeout of 900 seconds
		
		--Choose a file to EPS
		set FileList to (choose file with prompt "Select the MS Word files to extract images from:")
		
		Setup() --Do the Setup subroutine
		
	end timeout
	
	beep 2 --Let the user know it's finished
	
end run