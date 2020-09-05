switches="$1"
#tape="$2"
#tid=`basename $2`
tid="$2"

tape=`find tapes -name "$tid.tap*" | sed s/.bz2// | sed s/.tap//`

if test -L "$tape.tap"; then
    tape=`readlink -f "$tape.tap"`.bz2
else
    tape="$tape.tap.bz2"
fi

echo TAPE: $tape

bzcat $tape > TMP
itstar "tv${switches}f" TMP | grep '^Tape'

