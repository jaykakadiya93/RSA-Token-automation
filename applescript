set the clipboard to ""
set appname to "SecurID"
set thePin to RsaTokenPin()
set inputfile to "/Users/serverscript/apple_cedential"
set filetext to read inputfile


activate application appname

tell application appname
	activate
	tell application "System Events"
		keystroke "enter pin here" -- type the pin number
		key code 36 -- return key
		delay 0.75 -- wait for token appear
		key code 48 -- press tab
		key code 49 -- space (to hit the copy button)
	end tell
end tell

delay 0.5 -- wait
quit application appname

tell application "Terminal"
	set currentTab to do script ("bash /Users/serverscript/dr/stg1.sh;")
	delay 15
	do script ("sudo -S -u keb_athena_cicd -s bash;") in currentTab
	tell application "System Events"
		keystroke filetext
		key code 36 -- return key
	end tell
	delay 1
	do script ("clear;") in currentTab
end tell

on RsaTokenPin()
	return (do shell script "security -q find-generic-password -gl rsatoken 2>&1  | egrep '^password' | awk -F\\\" '{print $2}'")
end RsaTokenPin
