#!/bin/bash
# Program:
#     This program shows the comfirm
# History
# 2019/06/23   First release by LQQ


function confirm() {
read -p "Please input (Y/N): " yn

[ "$yn" == "Y" -o "$yn" == "y" ] && echo "OK, continue" && exit 0
[ "$yn" == "N" -o "$yn" == "n" ] && echo "interrupt!" && exit 0

echo "Please input (Y/N): " 

}

confirm 

