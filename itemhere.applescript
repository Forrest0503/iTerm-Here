on alfred_script(q)

  set finderPath to ""

  tell application "Finder"
    try
      set finderFolder to (folder of the front window as alias)
    on error
      set finderFolder to (path to home folder as alias)
    end try
    set finderPath to quoted form of POSIX path of finderFolder
  end tell


	if application "iTerm2" is running or application "iTerm" is running then
		run script "
			on run {finderPath}
				tell application \":Applications:iTerm.app\"
					activate
					try
						select first window
						set onlywindow to false
					on error
						create window with default profile
						select first window
						set onlywindow to true
					end try
					tell the first window
						if onlywindow is false then
							create tab with default profile
						end if
						tell current session to write text finderPath
					end tell
				end tell
			end run
		" with parameters {finderPath}
	else
		run script "
			on run {finderPath}
				tell application \":Applications:iTerm.app\"
					activate
					try
						select first window
					on error
						create window with default profile
						select first window
					end try
					tell the first window
						tell current session to write text finderPath
					end tell
				end tell
			end run
		" with parameters {finderPath}
	end if
end alfred_script