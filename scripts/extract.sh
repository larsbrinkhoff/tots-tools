switches="$1"
tape="$2"
tid=`basename $2`

rm -rf extract/"$tid"
mkdir extract/"$tid"

if test -L "$tape.tap"; then
    tape=`readlink -f "$tape.tap"`.bz2
else
    tape="$tape.tap.bz2"
fi

echo TAPE: $tape

bzcat $tape > TMP
cd extract/"$tid"
itstar "$switches" ../../TMP

