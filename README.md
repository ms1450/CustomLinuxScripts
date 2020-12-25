# CustomLinuxScripts
Linux Scripts created by me that I use in Red vs Blue team competitions, mostly defensive however I plan on adding some offensive scripts in the future as well.

--------------------------------- REQUIRE ROOT ACCESS ---------------------------------

backUpEverything.sh : 
Creates a /backup folder in the root folder and copies most of the important files into that folder.

fireTheWall.sh : 
Sets up firewall rules with optional parameters to allow SSH and HTTP/HTTPS connections through.

passwdCHANGER.sh : 
Changes passwords for the usernames provided as parameters for the argument, default passowrd is "d3f4ult_p4ssw0rd", however a custom password can be provided in the arguments.

resetPAMSSH.sh : 
Contains general configurations for PAM and SSH config files, which it uses to overwrite the preexisting config files.

tellMeEverything.sh : 
Shows a comprehensive and detailed list of information regarding the system, its users and the files present on the system.
