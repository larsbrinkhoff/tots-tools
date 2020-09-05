ti=''
zgrep -a -A1 '^TI=' ../listoffiles.txt.gz | while read i; do
    case "$i" in
        TI=*)
            test -n "$ti" && echo "$ti"
            ti="$i" ;;
        *) ti='';;
    esac
done
