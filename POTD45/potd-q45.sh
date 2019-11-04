#!/bin/sh
# This script was generated using Makeself 2.3.0

ORIG_UMASK=`umask`
if test "n" = n; then
    umask 077
fi

CRCsum="4003739961"
MD5="f9fed018d6c31b36d95a90620c4760b5"
TMPROOT=${TMPDIR:=/tmp}
USER_PWD="$PWD"; export USER_PWD

label="Extracting potd-q45"
script="echo"
scriptargs="The initial files can be found in the newly created directory: potd-q45"
licensetxt=""
helpheader=''
targetdir="potd-q45"
filesizes="7856"
keep="y"
nooverwrite="n"
quiet="n"
nodiskspace="n"

print_cmd_arg=""
if type printf > /dev/null; then
    print_cmd="printf"
elif test -x /usr/ucb/echo; then
    print_cmd="/usr/ucb/echo"
else
    print_cmd="echo"
fi

unset CDPATH

MS_Printf()
{
    $print_cmd $print_cmd_arg "$1"
}

MS_PrintLicense()
{
  if test x"$licensetxt" != x; then
    echo "$licensetxt"
    while true
    do
      MS_Printf "Please type y to accept, n otherwise: "
      read yn
      if test x"$yn" = xn; then
        keep=n
	eval $finish; exit 1
        break;
      elif test x"$yn" = xy; then
        break;
      fi
    done
  fi
}

MS_diskspace()
{
	(
	if test -d /usr/xpg4/bin; then
		PATH=/usr/xpg4/bin:$PATH
	fi
	df -kP "$1" | tail -1 | awk '{ if ($4 ~ /%/) {print $3} else {print $4} }'
	)
}

MS_dd()
{
    blocks=`expr $3 / 1024`
    bytes=`expr $3 % 1024`
    dd if="$1" ibs=$2 skip=1 obs=1024 conv=sync 2> /dev/null | \
    { test $blocks -gt 0 && dd ibs=1024 obs=1024 count=$blocks ; \
      test $bytes  -gt 0 && dd ibs=1 obs=1024 count=$bytes ; } 2> /dev/null
}

MS_dd_Progress()
{
    if test x"$noprogress" = xy; then
        MS_dd $@
        return $?
    fi
    file="$1"
    offset=$2
    length=$3
    pos=0
    bsize=4194304
    while test $bsize -gt $length; do
        bsize=`expr $bsize / 4`
    done
    blocks=`expr $length / $bsize`
    bytes=`expr $length % $bsize`
    (
        dd ibs=$offset skip=1 2>/dev/null
        pos=`expr $pos \+ $bsize`
        MS_Printf "     0%% " 1>&2
        if test $blocks -gt 0; then
            while test $pos -le $length; do
                dd bs=$bsize count=1 2>/dev/null
                pcent=`expr $length / 100`
                pcent=`expr $pos / $pcent`
                if test $pcent -lt 100; then
                    MS_Printf "\b\b\b\b\b\b\b" 1>&2
                    if test $pcent -lt 10; then
                        MS_Printf "    $pcent%% " 1>&2
                    else
                        MS_Printf "   $pcent%% " 1>&2
                    fi
                fi
                pos=`expr $pos \+ $bsize`
            done
        fi
        if test $bytes -gt 0; then
            dd bs=$bytes count=1 2>/dev/null
        fi
        MS_Printf "\b\b\b\b\b\b\b" 1>&2
        MS_Printf " 100%%  " 1>&2
    ) < "$file"
}

MS_Help()
{
    cat << EOH >&2
${helpheader}Makeself version 2.3.0
 1) Getting help or info about $0 :
  $0 --help   Print this message
  $0 --info   Print embedded info : title, default target directory, embedded script ...
  $0 --lsm    Print embedded lsm entry (or no LSM)
  $0 --list   Print the list of files in the archive
  $0 --check  Checks integrity of the archive

 2) Running $0 :
  $0 [options] [--] [additional arguments to embedded script]
  with following options (in that order)
  --confirm             Ask before running embedded script
  --quiet		Do not print anything except error messages
  --noexec              Do not run embedded script
  --keep                Do not erase target directory after running
			the embedded script
  --noprogress          Do not show the progress during the decompression
  --nox11               Do not spawn an xterm
  --nochown             Do not give the extracted files to the current user
  --nodiskspace         Do not check for available disk space
  --target dir          Extract directly to a target directory
                        directory path can be either absolute or relative
  --tar arg1 [arg2 ...] Access the contents of the archive through the tar command
  --                    Following arguments will be passed to the embedded script
EOH
}

MS_Check()
{
    OLD_PATH="$PATH"
    PATH=${GUESS_MD5_PATH:-"$OLD_PATH:/bin:/usr/bin:/sbin:/usr/local/ssl/bin:/usr/local/bin:/opt/openssl/bin"}
	MD5_ARG=""
    MD5_PATH=`exec <&- 2>&-; which md5sum || command -v md5sum || type md5sum`
    test -x "$MD5_PATH" || MD5_PATH=`exec <&- 2>&-; which md5 || command -v md5 || type md5`
	test -x "$MD5_PATH" || MD5_PATH=`exec <&- 2>&-; which digest || command -v digest || type digest`
    PATH="$OLD_PATH"

    if test x"$quiet" = xn; then
		MS_Printf "Verifying archive integrity..."
    fi
    offset=`head -n 532 "$1" | wc -c | tr -d " "`
    verb=$2
    i=1
    for s in $filesizes
    do
		crc=`echo $CRCsum | cut -d" " -f$i`
		if test -x "$MD5_PATH"; then
			if test x"`basename $MD5_PATH`" = xdigest; then
				MD5_ARG="-a md5"
			fi
			md5=`echo $MD5 | cut -d" " -f$i`
			if test x"$md5" = x00000000000000000000000000000000; then
				test x"$verb" = xy && echo " $1 does not contain an embedded MD5 checksum." >&2
			else
				md5sum=`MS_dd_Progress "$1" $offset $s | eval "$MD5_PATH $MD5_ARG" | cut -b-32`;
				if test x"$md5sum" != x"$md5"; then
					echo "Error in MD5 checksums: $md5sum is different from $md5" >&2
					exit 2
				else
					test x"$verb" = xy && MS_Printf " MD5 checksums are OK." >&2
				fi
				crc="0000000000"; verb=n
			fi
		fi
		if test x"$crc" = x0000000000; then
			test x"$verb" = xy && echo " $1 does not contain a CRC checksum." >&2
		else
			sum1=`MS_dd_Progress "$1" $offset $s | CMD_ENV=xpg4 cksum | awk '{print $1}'`
			if test x"$sum1" = x"$crc"; then
				test x"$verb" = xy && MS_Printf " CRC checksums are OK." >&2
			else
				echo "Error in checksums: $sum1 is different from $crc" >&2
				exit 2;
			fi
		fi
		i=`expr $i + 1`
		offset=`expr $offset + $s`
    done
    if test x"$quiet" = xn; then
		echo " All good."
    fi
}

UnTAR()
{
    if test x"$quiet" = xn; then
		tar $1vf - 2>&1 || { echo Extraction failed. > /dev/tty; kill -15 $$; }
    else

		tar $1f - 2>&1 || { echo Extraction failed. > /dev/tty; kill -15 $$; }
    fi
}

finish=true
xterm_loop=
noprogress=n
nox11=n
copy=none
ownership=y
verbose=n

initargs="$@"

while true
do
    case "$1" in
    -h | --help)
	MS_Help
	exit 0
	;;
    -q | --quiet)
	quiet=y
	noprogress=y
	shift
	;;
    --info)
	echo Identification: "$label"
	echo Target directory: "$targetdir"
	echo Uncompressed size: 40 KB
	echo Compression: gzip
	echo Date of packaging: Mon Nov  5 09:38:41 CST 2018
	echo Built with Makeself version 2.3.0 on darwin16
	echo Build command was: "./makeself/makeself.sh \\
    \"--notemp\" \\
    \"../../questions/potd3_045_double_hash/potd-q45\" \\
    \"../../questions/potd3_045_double_hash/clientFilesQuestion/potd-q45.sh\" \\
    \"Extracting potd-q45\" \\
    \"echo\" \\
    \"The initial files can be found in the newly created directory: potd-q45\""
	if test x"$script" != x; then
	    echo Script run after extraction:
	    echo "    " $script $scriptargs
	fi
	if test x"" = xcopy; then
		echo "Archive will copy itself to a temporary location"
	fi
	if test x"n" = xy; then
		echo "Root permissions required for extraction"
	fi
	if test x"y" = xy; then
	    echo "directory $targetdir is permanent"
	else
	    echo "$targetdir will be removed after extraction"
	fi
	exit 0
	;;
    --dumpconf)
	echo LABEL=\"$label\"
	echo SCRIPT=\"$script\"
	echo SCRIPTARGS=\"$scriptargs\"
	echo archdirname=\"potd-q45\"
	echo KEEP=y
	echo NOOVERWRITE=n
	echo COMPRESS=gzip
	echo filesizes=\"$filesizes\"
	echo CRCsum=\"$CRCsum\"
	echo MD5sum=\"$MD5\"
	echo OLDUSIZE=40
	echo OLDSKIP=533
	exit 0
	;;
    --lsm)
cat << EOLSM
No LSM.
EOLSM
	exit 0
	;;
    --list)
	echo Target directory: $targetdir
	offset=`head -n 532 "$0" | wc -c | tr -d " "`
	for s in $filesizes
	do
	    MS_dd "$0" $offset $s | eval "gzip -cd" | UnTAR t
	    offset=`expr $offset + $s`
	done
	exit 0
	;;
	--tar)
	offset=`head -n 532 "$0" | wc -c | tr -d " "`
	arg1="$2"
    if ! shift 2; then MS_Help; exit 1; fi
	for s in $filesizes
	do
	    MS_dd "$0" $offset $s | eval "gzip -cd" | tar "$arg1" - "$@"
	    offset=`expr $offset + $s`
	done
	exit 0
	;;
    --check)
	MS_Check "$0" y
	exit 0
	;;
    --confirm)
	verbose=y
	shift
	;;
	--noexec)
	script=""
	shift
	;;
    --keep)
	keep=y
	shift
	;;
    --target)
	keep=y
	targetdir=${2:-.}
    if ! shift 2; then MS_Help; exit 1; fi
	;;
    --noprogress)
	noprogress=y
	shift
	;;
    --nox11)
	nox11=y
	shift
	;;
    --nochown)
	ownership=n
	shift
	;;
    --nodiskspace)
	nodiskspace=y
	shift
	;;
    --xwin)
	if test "n" = n; then
		finish="echo Press Return to close this window...; read junk"
	fi
	xterm_loop=1
	shift
	;;
    --phase2)
	copy=phase2
	shift
	;;
    --)
	shift
	break ;;
    -*)
	echo Unrecognized flag : "$1" >&2
	MS_Help
	exit 1
	;;
    *)
	break ;;
    esac
done

if test x"$quiet" = xy -a x"$verbose" = xy; then
	echo Cannot be verbose and quiet at the same time. >&2
	exit 1
fi

if test x"n" = xy -a `id -u` -ne 0; then
	echo "Administrative privileges required for this archive (use su or sudo)" >&2
	exit 1	
fi

if test x"$copy" \!= xphase2; then
    MS_PrintLicense
fi

case "$copy" in
copy)
    tmpdir=$TMPROOT/makeself.$RANDOM.`date +"%y%m%d%H%M%S"`.$$
    mkdir "$tmpdir" || {
	echo "Could not create temporary directory $tmpdir" >&2
	exit 1
    }
    SCRIPT_COPY="$tmpdir/makeself"
    echo "Copying to a temporary location..." >&2
    cp "$0" "$SCRIPT_COPY"
    chmod +x "$SCRIPT_COPY"
    cd "$TMPROOT"
    exec "$SCRIPT_COPY" --phase2 -- $initargs
    ;;
phase2)
    finish="$finish ; rm -rf `dirname $0`"
    ;;
esac

if test x"$nox11" = xn; then
    if tty -s; then                 # Do we have a terminal?
	:
    else
        if test x"$DISPLAY" != x -a x"$xterm_loop" = x; then  # No, but do we have X?
            if xset q > /dev/null 2>&1; then # Check for valid DISPLAY variable
                GUESS_XTERMS="xterm gnome-terminal rxvt dtterm eterm Eterm xfce4-terminal lxterminal kvt konsole aterm terminology"
                for a in $GUESS_XTERMS; do
                    if type $a >/dev/null 2>&1; then
                        XTERM=$a
                        break
                    fi
                done
                chmod a+x $0 || echo Please add execution rights on $0
                if test `echo "$0" | cut -c1` = "/"; then # Spawn a terminal!
                    exec $XTERM -title "$label" -e "$0" --xwin "$initargs"
                else
                    exec $XTERM -title "$label" -e "./$0" --xwin "$initargs"
                fi
            fi
        fi
    fi
fi

if test x"$targetdir" = x.; then
    tmpdir="."
else
    if test x"$keep" = xy; then
	if test x"$nooverwrite" = xy && test -d "$targetdir"; then
            echo "Target directory $targetdir already exists, aborting." >&2
            exit 1
	fi
	if test x"$quiet" = xn; then
	    echo "Creating directory $targetdir" >&2
	fi
	tmpdir="$targetdir"
	dashp="-p"
    else
	tmpdir="$TMPROOT/selfgz$$$RANDOM"
	dashp=""
    fi
    mkdir $dashp $tmpdir || {
	echo 'Cannot create target directory' $tmpdir >&2
	echo 'You should try option --target dir' >&2
	eval $finish
	exit 1
    }
fi

location="`pwd`"
if test x"$SETUP_NOCHECK" != x1; then
    MS_Check "$0"
fi
offset=`head -n 532 "$0" | wc -c | tr -d " "`

if test x"$verbose" = xy; then
	MS_Printf "About to extract 40 KB in $tmpdir ... Proceed ? [Y/n] "
	read yn
	if test x"$yn" = xn; then
		eval $finish; exit 1
	fi
fi

if test x"$quiet" = xn; then
	MS_Printf "Uncompressing $label"
fi
res=3
if test x"$keep" = xn; then
    trap 'echo Signal caught, cleaning up >&2; cd $TMPROOT; /bin/rm -rf $tmpdir; eval $finish; exit 15' 1 2 3 15
fi

if test x"$nodiskspace" = xn; then
    leftspace=`MS_diskspace $tmpdir`
    if test -n "$leftspace"; then
        if test "$leftspace" -lt 40; then
            echo
            echo "Not enough space left in "`dirname $tmpdir`" ($leftspace KB) to decompress $0 (40 KB)" >&2
            echo "Use --nodiskspace option to skip this check and proceed anyway" >&2
            if test x"$keep" = xn; then
                echo "Consider setting TMPDIR to a directory with more free space."
            fi
            eval $finish; exit 1
        fi
    fi
fi

for s in $filesizes
do
    if MS_dd_Progress "$0" $offset $s | eval "gzip -cd" | ( cd "$tmpdir"; umask $ORIG_UMASK ; UnTAR xp ) 1>/dev/null; then
		if test x"$ownership" = xy; then
			(PATH=/usr/xpg4/bin:$PATH; cd "$tmpdir"; chown -R `id -u` .;  chgrp -R `id -g` .)
		fi
    else
		echo >&2
		echo "Unable to decompress $0" >&2
		eval $finish; exit 1
    fi
    offset=`expr $offset + $s`
done
if test x"$quiet" = xn; then
	echo
fi

cd "$tmpdir"
res=0
if test x"$script" != x; then
    if test x"$verbose" = x"y"; then
		MS_Printf "OK to execute: $script $scriptargs $* ? [Y/n] "
		read yn
		if test x"$yn" = x -o x"$yn" = xy -o x"$yn" = xY; then
			eval "\"$script\" $scriptargs \"\$@\""; res=$?;
		fi
    else
		eval "\"$script\" $scriptargs \"\$@\""; res=$?
    fi
    if test "$res" -ne 0; then
		test x"$verbose" = xy && echo "The program '$script' returned an error code ($res)" >&2
    fi
fi
if test x"$keep" = xn; then
    cd $TMPROOT
    /bin/rm -rf $tmpdir
fi
eval $finish; exit $res
‹ dà[í=X\Õ•o€$“‰vHª.­6yæ§‚‘døùQ‰aÌÌ
“P©iöA†!L…ÎO$U¾NJ¦/ÓQ¶-n¬±Ëvıºi·íÒV,uÅ"_ ©UlwmÚİ­ôwİØ²İ~köüÜ7óæA0F£í÷ÍûxïŞsÎ=÷ŞsÏ=çÜ7uë¥Ë~9%%2…¥:
‹9—\PT´Áá(-(-Ş ;

¥¥’\"½W8ª )í>ÿÁp³ï‚å XcãüÄ~$Â¿kİzW}°i§­í²Îiqñ…ç¿¨Ø<ÿEÅ%…’ìHÏÿe¿VùüæpƒWŞrÀë	µn±%RVg4­´Ù´úä†Öğ¾f/¦¹ımáPn0Ô°iWÚâó‡n‘?xà&"²·ÙÛ’w¿mñúõ[ÃÙÓ
¸š¼¯M–ìÁÌ½òÍr~Áfyıú€·¥õ€W5ù‚¶›mıú–ú{½r½Ü­Èa¿'äkõËúæfoƒÜèCØ~²\Ğëiõ7Ì*ÉÉTTJ_³ş›.³üŸı;ŠÌë¿  4½şß™õßèoğ6ÊŠkë.—â²­Àç÷&`ÛE	ˆK‘›mM,ê\=ƒ‹4{ıûCM¢Pr=çªÛVyı¾Æôkë¿¥Şç7õ¿’¢’ÂYúß†â’ôú'®şôÊùE’dÉ”¤HÀÙpGHR4r=å¿nÜŠR½u»óçÎ;gã°\D;ˆ'7ñìvÖî£¾y²´I@´P$+JÈÛJ3ãs,b|÷¯NÂYF¼YRÄ*J0Ş¼ ¾¯®e|Ï™`ı²
|Sğ)MŞæ6o`|í7‰ú–$œ1/}û=ÅÛîñ¶…”Pı¾YøòU­%	gÌ3Šâ	†>ÿşôw|ãû¨6^³ğ…ı÷ùüŠÏßØ:¾-ëßˆÎx>)³ Š­»·¦òu1;•?tù$SÜbÜZC)tÎÏa€3Ù8Ÿ+Sêû›•àÁ–}­ÍJ[(0ŸCàË6Àf|¹)øšëçÃW®ã³$a#>ìï¦qãuZéŞq‡³Â­ÏA¹79	ãUıWI<F~†>G¢œùÂ	5kaâÊ·IÒ4R¶×3ÎeÊ7Ì-„m; <T\‚m¦oL»îëç™ÿò*Iªœ#ı=¢WÀ½>¬oöí[ßp°¹Aä_+è_ô½Ÿ<ç¸òïÙºğ›Á¿»sµ>'WØè¾Ñ0GÏIëÕ-Jmï
Á9:Ï/(²àH%Ú†Û³víº‚u@„o•/3”ÏØòR–¹ü®ƒÁ·eİm¢
]ôÔ¹¹yºv§u“?Ç«Æ¥şÊ¥vhjø—®X‡æò8	à´KuN¹bÎiWL‚ä©Ñ¬¸ö>ÛMå)‡%ãŠGËÎÏÌ¸âq™‚ñs33£Ñ3ğDÌ.µg
¢®jÏ4CÓIç	¢@}É¥ö[16J¼é½ÍJaç‰l(šC9ÑìóqŒSbıÙT¹'—‚~™12w$‚ÅPªœÓË8¡Sî¢X´šÒE Ä[F£Ï‰tb,ËşĞöêõØ9ê5w¼ ucªcLÅ\V—zZicâ(à^µsJ;÷!Â›m€¥ğÚ;›-Ôb-c>Ê´÷ÑÆ»yXº °ğ°p~?eÄ»sÎq
{yªgÃ@N¼–Sj¹+uqĞCÆĞ•~¥ˆ`°‘–3TÎu5np‚óN3Í“6Á¤æ¼)†¦˜&+Uï—(œæzVnOâ¦¹^C9Üƒëår=™)Ïåz2ç•1„AEla…jÁ¢n³º:‡²\êmÖÉµ4ˆ<}jt€	æ`G@ A?‰azÄˆS:‡,*E&Ÿ#şDşP_Ä–0QäÃ¾99’…“JùÏ\…{Ñ}g¡±¶H]©õ‰ÔØÍùk0³ä·« İ}=.®èñs‰lŠCRv3~åâväQjãAh©éÕëé¸_\M¸¿ˆ¸_‘	÷Q½ÑH0Aûgv'—´­¢lLÒ¾ÁÙ]ººˆ.gˆ*b¢Ú‰šPÔ®S1St+S”ía¬í	Šf¸[˜ ]Å™mŠ~º’(Â$mg7(jbŠº¢@¦Vu9İ®XUÑRg¦å[«ía@«½°‚ğÕšiÁ­‹3«´ìdZ0Iû,g»´¸˜–^ åj¦å(ĞÒ´%ZÊÍ´ÜÀ´LhÛ_Y‚–å<S˜ ]N™-'¯§lLÒqİ\-¹LKĞ¢f-Ç–> å8Ñ"›iyt%¡mFZ¾ÍÍå˜Ç´6ÎÌ6Ğr3Ó‚IÚıœm5ĞbeZ†€–s¢e hZˆÉL‹iùL·¶–ñM'Åß8àûã|ã€oŒğM5âè;X<Š«Ñå‰0E§aK„»ÚŠ;DŞ	×ğŸ2\_´wf2º®'2>Œd<ş"CK®l.Øb«’[,D‡–á²ŒA‰³´`sÀ0!íFÆw:‰¯ä+h1I+áìqC¯Ç¹×ôúÛ´WMĞ«š ^¥ôZ²]adòõó	A¦-˜›»ëĞnÿ{Ÿ…ÆQ´iÅ×I’}Åá¤>ÑyFf%"=„0†!( g¸ÔQHĞ×!‘HNxvH­áÎyï³x­KÁwèL7õ ù îE®X9`zÍeÆnt¾l#<q˜c˜Ûp×¸Ûp§Q ¶J^1Óº1Öõùˆóe’^À3İå|Õ«r]±eög:^U;¹ÔUÄœ„»+Ô“ß=óƒ.çC“×Ò$tŒ£„w©U#Úg©¹1mõµœ¥â”¾#Î‡ìÏLi;@‰¨mO Q’‰ê4Œ+v“F`i<³i<a,µ%¤dï}Ö¾¢â"óÉ&¾äİ”ƒÎ[17VûaR3bQŞz£Ù¼cp°„6ï¢=¼í
(ÎtT$´y«Õ~øsbÑñ6škØYÑpp
ïÚqŞ™E «óÄY—
!èk¬{”µ§6E/ÊJçñ~ÇPŒ!”îjMdr7¥‰ş9Çpå35U(€iª`YãIÎ	æÉ0óLç(-òñ”>Æ®Ø­®X©+ïU×ğLÔæ©9
™İÄH1ˆÇÂİ$µÔ`Æ0HÒ*«†PŠiƒiS3útµva5kµvDtızˆç‹•¶ş^ÖEzÒû„VBÚ$8(ô”VX·á@<ÊXÆ8‘ƒíVìEŞ´kx:4 PˆúY‹²¦eRmRAÖöäœa5‹n&Èş);Ï{5×ÓÖä@ùXœ'@(uBá|ÖCPø9…õ»ÖèD°•ù¼S$zÕ¡\rĞCTÿÆ‚2ù“ïerX%nœb9LJoœ5R0Zxl	Åğ¯qÆYo.3h—:ƒö®u1eÌ¢éœmšƒa£Ì°’®`o¶Ø;¢Z!“ïzA2	!İ"á%dS¢_¬?1;mFæ¿Ëj¥Xç_û?Æ-Lˆ«Ü¬‰ ‡mƒĞÍàVQn
ÖFª³6²tÙ–²´Z™–°w²<,#¸Ñ€T«@J×ÀzrÒ¶ƒ2ÂéŠ˜¥BEbˆ
R¿9ïç¾b§´;¯Ñwxî³V¾VÎ­‘H
6šZj¼Ë\·6ELÑ]=Ç~¤Öhb+ûRÑ¦e.2n@)òw,ÈPŠ
†TØoHCKˆŒ¢~ÕKh‚P¤M]–¡lâÖ>Ñn­Œ‘A[“*Asâ„^¯Ú9„â¨ñ)†¦š&ˆŒh7,–J6¤+ÙÈÊ•P/«Š-®Ê;å6pÿ<£Ê2ãÃ ²å'L0mãÜÀ8eßcE$y?t¿~~ŒÒ…‹Q‘eĞè'Œ1†£=FúX/C½‘¡ã óYXë±mÉúØ C\[»¶2ï?\Ğ¸w[~Ø»Ù}ĞEøÈt€.´SĞÓFy¿gƒ›¤	Î/ÎyÎ5Ü·TÆn·B]4„ÃVâXµc¼8º’„t«‡yb)ƒ^Ch%hy/¢¦æ¶@ÙE®ÎX˜ı¨¨ÛdÔVRèÆ©Œ:	Ñçµï¾—„¯a–ñ°=¨2p±Sç({	†aXtx—B´‹·•0¬?¼K"(±„Õ‰÷2.pÊ"ÂvÂŠ¦:EOfë;¤Ú_gÜ!{Ä~Ù6£ó*‹¬`B î~®pYn,N¶¡c…B4–'÷}—AX¦: b=l	õ°²ÀAç‰HqÅnÂe†]øÍD‹jŠ¾óÈ†·
ÂU¡Èˆ@JT±è†Z¬Üêb®áDî(ï“°<ÏÏ¼`üSÂ¥; z8X¦;¦bºjÂè(iïöªÄçÛçÇXŠ`àîÙç
Àx`è4‹ØÿİyÓnØÿİÃ•–“€ı8ããàV“¢¡Ò®QÉbĞu1ÔÅP7Aä”‚UÓ¶SÉ»@½õRã‹¡ıª¼a÷ğkĞøÏ ñPc|m	©ØÎ	Äq±pIÂ×ÖÃÎ¡¢V3)Â£GşÀC#(¹÷ 6™SŸşŸÌ¹ôé2°%&ë”ÙûvôÍ|Â= b8BÂËÂkC8[8`Å¬]¸+(ıp«Gyñ¢±7Ø,@6¯¡~VjkxwEE5V3D
ªZ3.äÊé„ıHÒ]µ(r4Ò+²Y£Ê¨&—0|ZÀ¨“	ı‚!—`øÎ‘²¤·šı¸Ò*ã¼&„»N0¤ÊÚ–*t/æõ-[¡M©¼¸FIùc°PZzæòêõ_h,;©õUêfûøPòq¶:X+0}LxûÔAGŠZfê­
ŠQ”ÅJê° Cp»ˆŞ*\8öÃå8É9ÅYC¬â…•Ø\T´ñŞiM,YÔ¥ú™Pr”Ö£Î.6×u£¡¦×µñ¤ıS_%µgÁêl²T‡¾ƒ“ª¾ 5^‰ğ(³N1nUÎqÚ²Ğp!å‹˜ÓBĞîC¾NíŸ¯HxL¼‚ˆcW>OÁÕÿ-|í±~%×èvX¼ê)m4Kvî€Zõ„ÈÒÎ\Á¬VBg·Ä©±ãÚ“W¡€rj‰gİ‰Ä—î `Q&$ª%¡ÂÃ¦‰ªÊVX?[­œ¡3tû¯.¹Q4]pOƒ™>4RM:£}…n—³}Å²•İ-$::î£bSa>ZFŒXb§Ñ—ˆ07xQè†ôi¶³í‡rÏOÏeçÌo»a ª³…}œı6ÛÇbõe’ığSFëÉ‰†m7“ˆ.J¸Ñ2 ‹ ÉšËhÎy£YL{Ï˜q#‹r¢”­8g€İŠ&¯#`¬0ªa}•äÓ	£¯´0T¸ÂÀşÀò±ÓÚ	å4áº<‹ğ|³òÑ_nT'ø,#>ˆÓ }{qÂæàéI‘G¬]ñEFñyÜbâ«“óa˜Õ¨àiO±ÿÄé
kºƒ>jpĞ£»%¶SsY^4)Yjˆ¼İ¹.eK¹QœA‚[#ç!®>çñX»UÈZuğğŒEñ¹¦Ï²¦e{ôıÓ33Êâ’Œyİ-Ÿ1º´óI].S·„¹eô”AË¿O	İâŠ}ÎÃ|Ğ|	gØ(T¶·Ù¡­±bk4Õ±o ïKÕ–@Zbdÿ‹Éa^p¢£OfG_Ç¸öÒ¢ÄT¡$L¸øl y´¯-"ñ3¤‹òòÅ™‘ætô>My?ªˆE9Ö:yüèmæ]ÑAlxJ”ğù!."ù7Xö’-zŒäEøB‰#TİşÌ˜ŸêCİÉÎÅºè:ÕÕóèù„‡îH
ª¢oœI‡‡Ğë´#>•9Ÿô4¹Ó}>)¡ĞµƒWwtÂàg02O÷¨óÓX]èÕ|}¤jÍ1€zcÕr,|l1˜V£êKÚğÂ”3°¿CÅÍZ_‡ZÇ&=Í0ìb>Æ]è=ŸXuB/W£XSÛÄ<¦hpœ	µ3¡/¸XõÔJt*´=“ı94¡¥¯{hYÿz5ù“á.H’©]ŸÒ½YÏ&~TÆ–î>3wıñÜ‚¹ü­ã@CE×Xbûjëíñ>VTQÏîŠşI]*só^#ËÓOÎ¢$ÖÅ™‰óÆÇÁÑã){å9‚% ¥›½tXÚşàRÜ@”•7,“YU¥
©{t²Í.&¶‹ˆ}ğ~±¢T¬§K¨ß<³Â‰'¶I9ÁruÀÔ9ÏŸ::ó"PÙE×r&d,Iˆq<B™ú|uv3! {æø¶ŠzôváGÂÜŠ#<Âb?e½°¢+ºŞ¸»râNÖ)oPr»ÁVÕ%ºP9ëÄA8CcÀ­¾V©o½qòg}·‰ÄÑy-IƒÄ­åÑ"ˆf?íÜâŸO+»Ø? ·0$ìO.êœ°tN£†Í×¸‹Æq½Xèç~ïY>o7Zçh}Ò¢Mïç"èû;Î[1ÜÃ>C÷6Y(C¢:îBP³Êìëa’j¦>A:õL \p4ı*½Pb\ü†ÉfbIûa×|l1J'÷ø&ÄäI§¡Ù?8&·Yğ˜¯NG#Ü‹_¦.L©ÑbjqEòh:5[õöÃ¿Ãœ…–$¥by\ÔRHY*F5Sí]kÊRa”óŞÄRq†RÈ‰)~mDKV
oNÂû ^á€”lº‚vhdÜ"ÎÿÈÏZ,¥ÿ©gÕğt,|vsxÚş¹¡Õû“C ‹%ä£ş.ÑÌšA²Í¬é¦çgèù9z>LÏ£ôü<=Ñóôì¥çéù8=¿DÏãôü
=¿JÏ¯Ó³ß¤çô|’ô|ŠOÓózÑó=Gèy’cô<EÏçèù<=ÇáYÿÀw`oİ5³æËv7]ƒ#ÿkèhÓG0öŸS1öŒ}ccû>ÆĞµĞ´™é	Œİ‹±¯`yr²c“{cëAÖM~cŒ}c_ÇŠŠ¦ïaÌ±%(&0¶c÷`ìvŒ¡ kÚ±Û1vc[0öÆ
1ö$Æpë¤ÒL.ÇØ)L»
c?Æ˜c‰bœÏGI™ïÿ4şC\|µs´»ô÷ÌfÍË¼#‰—!1‚ìù=øªç¬²gõ7k1‚#
JÉã<«ìwõ·>1‚ƒÿ>¬ü2 ç“eŠD¤Ìğâ…È&À´àß¡hıÒü€=ÈÆP9ó_áñ=çÃğø¸é‡™ŒÀ¯b¿À­zÎò,~¿{#†«²ø…Hı½ğK*Íô7`1‚µTLØ§õŞ8ÛÛ¼·AŞé†›CÒY’÷ÂŸMú0şM¤Ö77·zêñw)»oÙ´I@ŞÜ ïã^%$ûóäü7ÈøÒµ·!(·Ô·ûZÂ-r0ÜÖÖ@ÜXN¼7{xßsµ€s“ïH#xW®ƒßAo¯Şâûãxµ‰wNñ}íq»$…ph™$@XJÇ„Ù+ÿ:IŠÀ˜<¾ßÿ½BÊNÈH¼Â\ê¯U²ôÂ”D–H™İK$ËX%²]Ê˜º
p\#Y¦`›Ÿx¿dq€t®^uV#qËÛñ>dµxÿ¼K¼×ş–_Çá1I„ñş|¯ë>ÈaŸÈJ„#"|^„§Eøs!†0!†Õ×ˆ÷š}6Fì^•?÷ï–‹ô\Šp‹oá="l¡?ÿâ~‘¾ÒWúJ_é+}¥¯ô•¾ÒWúJ_é+}½×Ò•åu9·ÕJKËå»B…üåÅ´*
œ¤»R·È-R”‚bOk8äLI*ñ„¶yİg¡¯Aäìv›q‰ôÍŞĞ\}@Šœ¶ôN‹÷Ff,”î¿¯E2¥)ûÛÛ•6o Øê¯oö…*RhD‘eåø»`şş>Ÿ¿ÁMHDíLn)“ÄíÛ±KÙ˜p¹}N§³¬¥¾]A÷õ»ÖØÉ‚OS}@	ê}¡ ôµ Àû1Åç)Øw§Ï'E²ç+^ämm¤ó)åaqVßáI)WX¬(má‚¥ë=!o@	z?öú=0äĞ3¸vbrÑ¾ú Ï£´Co}‹{·²Û¡8»6(Õwì*VZ¤H™±‘y¥° Û6)ûê=÷*ÁæÖû”¶úPæ¸s·"E¬‹¨TQ‚÷Õ·)­Ø_ÀnÂ÷…½¦zlƒI‰nßÎ]…@tÊp4İßkÏnìs©‚c*&hÖŒôOá:æÆ‰7äFI
”/ƒŒşz[¼Àm×R#Ã:…G†0èU<­--­~wå¾È5`L!§Hê,¥8”ÍŞaÀĞXïñ†°Ã…×œ¨K)\ækRc¥û½!¨È›Ë¼ ¹u?5¶­YN
tY–ù³Ç’?17¯¥N2NÌ±Ïï9[c÷Û€‘¤à:šŠË<Ós2E,'QÒ{	µK›ï¹õã—P¿4èõ‡·8wî*RKß¥cÑ‡aàP4>¬;–RWp”x"%3ÁAE ½°$ëöÁÊ¬F÷´úƒ>¬JÀK¼Ëõµ¹ë—xš½õçG±È4ÙÚb¬Åç¯y©jw¦+özE÷Æ‹øZı4÷Éû¼û}~Šxšh^“9^$MO?LoxMèú’™Ô×XÊ-ŞOÛA‡]§‘CÆV©„/ŸXi”¡HÙôı$¿”ÑK·İë	åMŞzÜurï‘n"O}FA‰éÛX;ßXXÂ„ùvHÁL©ï=R¦„>ı®#}İòæ6²_dJY—,4ÿ˜1Ÿ@—^Ï¸L»“–i®)½’™™YÃ9ÿ~ôãÌKŞg~
M­‘2³Æo‚ÇP<º+$)Ó¸5?’5këÿB–ØŞÿ1+3k¢jEî†Gïİ0yŞìêH†,÷ff/,_"G2&Le[åˆM–ğíå–Ñù„g3üO	øßœ½”á…‹îçËœ-Î?>$`YœÇ01!|BÏ—Å9Š€#â\æ£VIzOVò;Cø¨€ğˆ€{<%ào	ø:ñ]¡“~\À¸>ì–äw›¶Iœù¬Ÿ="`ıüè)ëçHÖÏ…¶ZÖÏ…>%`ı|èWÖÏ…ğ›6vKvâ oKÓW'è»-ƒÂÄ'Œv2œ8úùŒ	ş	ş‘	ş_lËL…kLğçMğ‹&Ø–•
»MpÔ?e‚¿g‚a‚_3Á…Rá&X!8’€Ã¦ü˜)ÿ³&øó¦òO˜àQ|ÚÿÖ¿n‚—.LÏ÷™àëMp	ÆŸ5ã0¾'¶×Üø°Àã÷ ğ{Gø-©UŸ¯‘ø˜Ï´¯–ø;NxŸdÂãá›$ş,!úQ3ÜEpã»#ø]äR‰¿7´n|I–øì¿„ŸìÂ7™6À½™É,ÿó¡¶ÿKÜß¼	÷&¬·7´Ü.În»ìVÛÛb±]fkím°Õe¶>¥ªe¶¶Şªu‘Öü¶Õ…­ªºUŞF;ëm1°.Ñ²ºd“ê-ÚRoÅˆº$ëi–ìBş¯¹í«K6¬æ³¨f™Rs»7æö»é~á×¸°ù5‡İ5ËàšÛÒJ1±æöÜé—njé6Ö,aü¡ÙæK¢'ùL6_ÉB;¥ yj(æzÿ~?X®$æÏˆi¶lÖBK‹i1\L=ó"¸¨¶
/±-ÓØj«o f‡U2äB‰©Å~ÅÃDXõÙ,å-qWşaË‰õá„diû¶m†ï¦6{³R
g¥l˜•R0»PAñì¤Ò¿Tÿ?ÿù]ıÿ…EÌß/),Hÿù¸’Ÿw÷‰µ6çŞñ³ëÈ(¹y÷Ûl‹g}Ø=©Î{6Û7¶dúR»O¾Yvl†`ËÍr1„k×â?†á2ÖX—PUsóò şâ¸Í_“7Ö¸I.tPÁùa!(Eôâ¦-oÙ"¯4½"¼©n+›gß#¯„ ĞA€¼÷âŠç\ÎâE—HÌGüæ
³jŞ’|yMH4»ró=79Æ{|{/Ø•[GúÛş—_şWÕßëmô5{ß5ùï(Ş0[ş¥ÿÿÇ;r9k;¶V9a=£x·İyÛ_ïñu­2‰ÿV›m[m-$’Æºv-B·WnİåòaÁŞìY»ÖÑ.ç{äüırş9ÿnĞ áémuÎVYa¨ZY1»¦ÍÅ7É«s)y6[2¾‰şª'²®§Ø¯Î­¬È“WÿŒB˜'ç·Ê«Ëm6*İš¬……^(½E¦·Ù¸‡›R°ÎYM-ÿ&Ûâü@‹œß(ßÃb 5-@ÒWúJ_é+}¥¯ô•¾Ò×_Ôõÿç‡2— x  