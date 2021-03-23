#Nicholas Mangerian

#get username
username=$(whoami)

#get hostname
hostname=$(hostname)

#add username and hostname to report filename
filename=$(echo $username)_on_$(echo $hostname)_commands_report.txt

#header
echo "commands report:"> $filename

#add date
echo -n "time = " >>$filename
date >>$filename

#add username
echo -n "user = " >> $filename
whoami >> $filename

#add hostname
echo -n "hostname = " >> $filename
hostname >> $filename


echo " ">> $filename
#check commands
echo "commands:">> $filename
#go through these commands to check that they are installed and current user has permissions to run them
for command in "ls" "ssh 127.0.0.1" "ping -c 1 8.8.8.8" "pwd" "useradd hacker" "sudo" "nano -h" "vim -h" "curl www.google.com" "wget google.come" "ps" "df" "net time" "cp /bin/ls fakels" "chmod 777 fakels" "chown hacker fakels" "find fakels" "grep" "locate fakels" "touch fakels" "lsof" "history" "userdel hacker"
do
	
	commandArray=($command)	
	#add the base command and equal sign to report
	echo -n ${commandArray[0]} >> $filename
	echo -n " = " >> $filename
	output=$($command 2>&1)
	#if the output contains the statement that the command was not found then it must not be installed
	if [[ "$output" == *"command not found"* ]]; then
		echo -e "\e[31mnot installed\e[0m" >> $filename
	else
		# the output contains permissions then there must have been insufficient permissions
		if [[ "$output" == *"permission"* ]]; then
			echo -e "\e[31minsufficient permissions\e[0m" >> $filename
		else	
			#if the command ran without any of the problems being caught then it must be runable
			echo -e "\e[32mrunable\e[0m" >> $filename
		fi
		
		
	fi
done
