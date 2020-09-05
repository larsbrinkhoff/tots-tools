rm -rf uniq-tmp
mkdir uniq-tmp

cat "$1" | (cd extract; while read i; do
    if test -L "$i"; then
        l=`readlink "$i"`
        x=`echo "$i" | cut -d/ -f2-3`
        y=`echo ${x}:${l}________________________________________ | cut -c1-40 | tr / %`
        echo "$y  $i"
    else
        sha1sum $i
    fi
done) | (cd uniq-tmp; while read i; do
    set $i
    echo $2 >> $1
done)

ls -1 uniq-tmp | while read i; do tail -1 uniq-tmp/$i; done | sort
