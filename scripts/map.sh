DATA=../tots-tools/data/tapes.txt

process() {
    tape="$1"
    format="$2"
    echo -n "$tape "

    file="tapes/$tape"
    if test -L "$file.tap"; then
        file=`readlink -f "$file.tap"`.bz2
    else
        file="$file.tap.bz2"
    fi

    bzcat $file > TMP
    itstar "tv${format}f" TMP | head -1
}

cat $DATA | while read i; do
    set -- $i
    test -n "$1" && process "$1" "$2"
done
