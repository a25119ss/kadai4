#!/bin/bash
# gcd_test.sh - gcd.sh の動作確認用テストスクリプト
#
# 正常なケースとエラーケースの両方をチェックし、いずれかのテストで期待外れがあれば
# スクリプト全体でエラー終了します。

GCD_SCRIPT="./gcd.sh"
FAILED=0

# 正常系テストケース: 引数2つ & 期待される出力
function test_success() {
    input1="$1"
    input2="$2"
    expected="$3"
    result=$("$GCD_SCRIPT" "$input1" "$input2" 2>/dev/null)
    if [ "$result" != "$expected" ]; then
        echo "Test FAILED for inputs ($input1, $input2): expected '$expected', got '$result'"
        FAILED=1
    else
        echo "Test passed for inputs ($input1, $input2): output '$result'"
    fi
}

# エラー系テストケース: 正常終了してはいけないパターン
function test_error() {
    "$GCD_SCRIPT" "$@" > /dev/null 2>&1
    if [ "$?" -eq 0 ]; then
        echo "Test FAILED for inputs ($*): Expected error, but got exit code 0."
        FAILED=1
    else
        echo "Test passed for error case inputs ($*)."
    fi
}

echo "Running tests for gcd.sh..."

# 正常ケース
test_success 2 4 2
test_success 8 12 4
test_success 81 153 9
test_success 17 13 1

# エラーケース：引数不足
test_error 5
# エラーケース：引数過多
test_error 2 4 6
# エラーケース：引数1に非数値
test_error a 3
# エラーケース：引数1に0
test_error 0 1
# エラーケース：引数1に負の数
test_error -5 10
# エラーケース：引数1に小数
test_error 3.5 7
# エラーケース：引数2に非数値
test_error 3 B
# エラーケース：引数2に0
test_error 1 0
# エラーケース：引数2に負の数
test_error 5 -2
# エラーケース：引数2に小数
test_error 3 7.2

if [ "$FAILED" -ne 0 ]; then
    echo "Some tests failed."
    exit 1
else
    echo "All tests passed."
    exit 0
fi

