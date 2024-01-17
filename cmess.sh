#!/bin/bash
export TMPDIR=<TEMP_DIRECTORY>

filename=$1
shares=$2
if [ -z $filename ] || [ -z $shares ]
then
        echo "Usage: $0 <search filename> <shares filename>"
        echo "Eg. $0 passwords.xlsx shares.txt"
        exit
fi

for share in $(cat ${shares})
do
        share_ip=$(echo ${share} | cut -d, -f2)
        share_name=$(echo ${share} | cut -d, -f5)
        echo "[+] Searching //${share_ip}/${share_name}..."
        smbclient //${share_ip}/${share_name} -U <DOMAIN>/<USERNAME>%<PASSWORD> -c "recurse;ls" > out.txt
        line_no=$(grep -in ${filename} out.txt | cut -f1 -d:)
        for line in $(echo "$line_no"); do
                if [ ! -z $line ]
                then
                        dir=$(head -n +"${line}" out.txt | tac | awk '/\\/{print; exit}')
                        found_file=$(sed -n ${line}p out.txt | grep -i ${filename} | sed 's/     /***/g' | cut -f1 -d\* | sed 's/^[ \t]*//g')
                        echo "    [-] //${share_ip}/${share_name}$(echo ${dir} | sed 's/\\/\//g')/${found_file}"
                fi
        done
done
