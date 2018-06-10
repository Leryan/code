#!/bin/sh
# to be replaced with phpunit tests
cd $(dirname $0)

test_oc() {
    version=$1
    extra_opts="${2}"

    test_res=0

    echo "======= OC${version} ======="

    ff="decrypted/admin/${TEST_FILE}"

    php ../decrypt.php -u admin -p admin -f ${TEST_FILE} -D data/oc${version}/data/ $extra_opts

    ref_check=$(md5sum refs/${TEST_FILE}|cut -d' ' -f1)
    dec_check=$(md5sum ${ff}|cut -d' ' -f1)

    if [ "${ref_check}" = "${dec_check}" ]; then
        echo "OK: ${version}"
    else
        echo "NOK: ${version}"
        test_res=1
    fi

    rm -rf decrypted

    return $test_res
}

rm -rf decrypted

export TEST_FILE="test.txt"

test_oc 81 $1
test_oc 82 "-m 2 -i oc2au91egkpg -I jwXMk1y0DL+YDk+xq1AR6lb1OldTtUF3UzbR/au8bqXnpfFT $1"
test_oc 90 "-m 3 -i oco1wl66ea55 -I 8y4DE6KkfEG3LUkgPkcLn8lSueXrDLWmWv5r/Jrcnwiaeym7 $1"
test_oc 91 "-m 3 -i oc4tesydbwqs -I dg3GE1YgzdcAMVmWHOY2nKn5qUQA+8urXD4jjEKku0Eptcth $1"

export TEST_FILE="test.big.txt"
test_oc 82b "-m 2 -i ocjyqevpt1tt -I BK+53qYBw7x33+ZqN8NFfAnxjm3741xpyhR9kZWGny+VtaHj $1"
test_oc 91 "-m 3 -i oc4tesydbwqs -I dg3GE1YgzdcAMVmWHOY2nKn5qUQA+8urXD4jjEKku0Eptcth $1"
