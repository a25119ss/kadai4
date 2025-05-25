#!/bin/bash
# gcd.sh - 最大公約数 (GCD) を計算するスクリプト
# 使用例: ./gcd.sh 8 12
#
# エラーケース:
# ・引数が2つでなければエラー終了
# ・引数が自然数（1以上の整数）でない場合、エラー終了

if [ "$#" -ne 2 ]; then
    echo "Error: Two natural numbers must be provided." >&2
    exit 1
fi

num1="$1"
num2="$2"

# 入力チェック: 自然数（0・負数・小数・非数値は不可）
if ! [[ $num1 =~ ^[1-9][0-9]*$ ]]; then
    echo "Error: '$num1' is not a valid natural number." >&2
    exit 1
fi

if ! [[ $num2 =~ ^[1-9][0-9]*$ ]]; then
    echo "Error: '$num2' is not a valid natural number." >&2
    exit 1
fi

# ユークリッドの互除法による最大公約数の計算
while [ "$num2" -ne 0 ]; do
    temp="$num2"
    num2=$(( num1 % num2 ))
    num1="$temp"
done

echo "$num1"
exit 0

