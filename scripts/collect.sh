# Usage: collect.sh request.txt
# Output: request.zip
# Envronment variable TOTS points to base address of ToTS.
#
# Format of request.txt: repeats of
# TAPE: <itstar options> <tap file>
# FILE: <file1 to include in zip>
# FILE: <file2 to include in zip>
# ...
# END.


ITSTAR=itstar
TOTS=${TOTS:-.}
request="$1"
dir=$PWD

process_tape() {
    options="$1"
    file="$2"

    cd "$dir"
    echo "TAPE: options=$options, file=$file"

    if test -f "$TOTS/$file.tap"; then
        file="$TOTS/$file.tap"
    fi

    if test -f "$TOTS/$file.tap.bz2"; then
        bzcat "$TOTS/$file.tap.bz2" > TMP
        file=$PWD/TMP
    fi

    mkdir tmp
    cd tmp
    "$ITSTAR" "$options" "$file"
}

process_file() {
    file="$1"
    echo "FILE: file=$file"
    zip -r "$dir/request.zip" "$file"
}

process_end() {
    echo END
    cd "$dir"
    rm -rf tmp TMP
}

cat "$request" | while read i; do
    set $i
    case "$1" in
        TAPE:*) process_tape "$2" "$3";;
        FILE:*) process_file "$2";;
        END.*) process_end;;
    esac
done
