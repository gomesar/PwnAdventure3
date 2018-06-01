#!/bin/bash

function _patch() {
	echo "sed -i -e $2s/\\($3\\)$4\\(.*$\\)/\\1$5\\2/" "$1"
	sed -i -e "$2s/\\($3\\)$4\\(.*$\\)/\\1$5\\2/" "$1"
}

TMP_FILE="/tmp/.libsotmp"
xxd ../originals/libGameLogic.so > "$TMP_FILE"

# GreatBallsOfFire ManaCost to 0
Line="81960"
Begin="^00140270: 5548 89e5 b8"
Tag="04"
Replace="00"
_patch "$TMP_FILE" "$Line" "$Begin" "$Tag" "$Replace"

# GreatBallsOfFire Damage to XX
Line="81958"
Begin="^00140250: 5548 89e5 b8"
Tag="19 00"
Replace="ff 00"	# No EFFECT
_patch "$TMP_FILE" "$Line" "$Begin" "$Tag" "$Replace"

# GetNumberOfProjectilesEv
Line="81965"
Begin="^001402c0: 5548 89e5 b8"
Tag="01 00"
Replace="05 00"	# No EFFECT
_patch "$TMP_FILE" "$Line" "$Begin" "$Tag" "$Replace"

# WalkingSpeed to XX
# 48C7 C0FF FF00 00F3 0F10 00
#Line="89765"
#Begin="^0015ea40: 5548 89e5 4889 7df8 "
#Tag="488b 7df8 f30f 1087"
#Replace="48c7 c0ff ff00 00f3"
#_patch "$TMP_FILE" "$Line" "$Begin" "$Tag" "$Replace"
#Line="89766"
#Begin="^0015ea50: "
#Tag="e002 0000"
#Replace="0f10 0090"
#_patch "$TMP_FILE" "$Line" "$Begin" "$Tag" "$Replace"


xxd -r "$TMP_FILE" > ../out/libGameLogic.so_patched
