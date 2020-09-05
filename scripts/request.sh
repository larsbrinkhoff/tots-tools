tape=""
end=""
cat "$1" | while read i; do
    t=`echo $i | cut -d/ -f1`
    if test \! "$t" = "$tape"; then
        tape="$t"
        echo "$end"
        echo -n "TAPE: "
        echo -n `grep "$t" all.sh | cut -d' ' -f3 | tr -d v`
        echo -n " "
        (cd tapes; find . -name "$tape.tap*" | cut -c3- | sed -e s/.tap//g -e s/.bz2//g)
        end="END."
    fi
    echo FILE: `echo $i | cut -d/ -f2-3`
done
echo "END."
