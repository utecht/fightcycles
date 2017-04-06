#!/bin/sh
MXML_PREFIX="main"
HTML_FILENAME="index.html"
MXMLC="mxmlc"
MXMLC_OPTS="-incremental -optimize=true -strict=true -o ${MXML_PREFIX}.swf"

rm -f main-*.swf
${MXMLC} ${MXMLC_OPTS} ${MXML_PREFIX}.mxml

if [ ! -d tempfiles ]; then
    mkdir tempfiles
fi

TMPFILE=`mktemp -p tempfiles ${MXML_PREFIX}-XXXX | sed "s/.*${MXML_PREFIX}-/${MXML_PREFIX}-/"` || exit 1
mv -f ${MXML_PREFIX}.swf ${TMPFILE}.swf
cat > ${HTML_FILENAME} << EOF
<html>
<head>
<title>FIGHT CYCLES</title>
</head>

<body style="background-color:#66CC33" style="margin: 0px">
<p align=center>
<h1 align=center> FIGHT CYCLES</h1>

<?php
	\$ran=rand(1, 10);
	if (\$ran==1){
		echo "Kind of like Warcraft, but not really";
	}else if(\$ran==2){
		echo "I bet you wish you had one";
	}else if(\$ran==3){
		echo "An experiment in minimalist programming";
	}else if(\$ran==4){
		echo "Coming soon to a theater near you";
	}else if(\$ran==5){
		echo "No budget, no problem";
	}else if(\$ran==6){
		echo "For further information, see: Dementia";
	}else if(\$ran==7){
		echo "Scientifically proven to be a video game";
	}else if(\$ran==8){
		echo "Bugs? What bugs?  You must mean the features";
	}else if(\$ran==9){
		echo "The melting means your hard drive likes it";
	}else{
		echo "Please direct all complaints to the President";
	}
?>

<p align=center>
<object id="FlexProgram" height="570" width="520"
        codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=9,0,0,0"
        classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000">
    <param name="src" value="${TMPFILE}.swf"/>
    <embed name="FlexProgram" src="${TMPFILE}.swf" align=center
        pluginspage="http://www.macromedia.com/shockwave/download/index.cgi?P1_Prod_Version=ShockwaveFlash"
        height="570" width="520"/>
</object>

<p align=center>
<em>Instructions:</em>
<br>
You are a Fight Cycle Rider.  Your Fight Cycle will leave a colored trail behind it.
<br>
By intersecting your own trail, you will remove chunks from the board. These chunks
<br>
turn black, showing that there is no board there.  If you run into a missing chunk of
<br>
board, the boundaries of the board, or are caught in a shape your opponent makes, you
<br>
die.  Likewise, your opponent(s) will suffer a similar fate if they do likewise.
<br>
Yellow event markers cover the board.  Some will cause deadly scorpions to crawl on
<br>
the board.  DO NOT GET HIT BY SCORPIONS. Some will cause an Awesome Possum to leave
<br>
additional holes on the board. Some will cause Wallace the Walrus to spit bees at you.
<br>
DO NOT GET HIT BY BEES. Some will cause patches of ice to form, making maneuvers tricky.
<br>
APPROACH ICE WITH CAUTION.  You now know how to play Fight Cycles.

</body>
</html>
EOF

