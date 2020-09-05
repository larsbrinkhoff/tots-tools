switches="$1"
tape="$2"
tid=`basename $2`

READ20=/home/lars/src/its/tools/tapeutils/read20

dir=extract20/"$tid"

rm -rf $dir
mkdir $dir

if test -L "$tape.tap"; then
    tape=`readlink -f "$tape.tap"`.bz2
else
    tape="$tape.tap.bz2"
fi

echo TAPE: $tape

bzcat $tape > TMP
cd $dir
$READ20 $switches ../../TMP

