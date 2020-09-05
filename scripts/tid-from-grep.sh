rx=''
for i in "$@"; do
    rx="$rx -e $i"
done
L=$HOME/src/listoffiles.txt.gz
U=$HOME/src/unlistoffiles.txt.gz
zgrep -a $rx $L $U | grep -o 'TID="[^"]*"' |
    sort -u | cut -c6- | tr -d '"'
