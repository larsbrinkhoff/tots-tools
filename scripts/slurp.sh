retry() {
    test -L `dirname $i` || rmdir `dirname $i`
    link=`dirname ~/TOTSdata3/afs/csail.mit.edu/group/tots/$i`
    echo link: $link
    target=`cat -v $link | sed 's/\^@//g' | cut -c10-`
    echo target: $target
    (d=`dirname $i`
     cd `dirname $d`
     test -L `basename $link` || ln -s $target `basename $link`
     mkdir -p $target
     cp -v `dirname $link`/$target/`basename $i` $target)
}

set -xe
cat files | while read i; do
    test -L `dirname $i` || mkdir -p `dirname $i`
    if test \! -f $i.bz2; then
        cp -v ~/TOTSdata3/afs/csail.mit.edu/group/tots/$i $i || retry "$i"
    fi
done
