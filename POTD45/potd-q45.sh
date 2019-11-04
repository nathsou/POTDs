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
� d�[�=X\Օo�$��vH�.�6y槂�d��Q�a��
�P�i�A�!L���O$U�NJ�/�Q�-n���v��i���V,u�"_��Ulwm�ݭ�w�ز�~k���7��A0F�����x��s�=��s�=��7�u��~9�%%2��:
�9�\PT���(-(-� ;

���\"�W8� )�>��p���Xc����~$¿�k�zW}�i�����iq�翨�<�E�%���H��e�V����p�W�r��	�n�%RVg4��������f/���m�Pn0԰iW���n�?x�&"���ےw�m���[���
����M���̽��r~�fy�������W5����m����{�r���ȍa�'�k�˞��fo���C�~�\��i�7�*��TTJ_���.����;��뿠�4��ߙ���o�6ʊk�.�ⲭ���&`�E	�K��mM,�\=��4{��CM�Pr=���Vy����k뿥��7������Y�߆���'�����E�dɔ�H��pGHR4r=�n܊R�u����;g�\D;�'7��v��y��I@��P$+J��J3�s,b|��N�YF�YR�*J0�� ���e|ϙ`��
|S�)M��6o`|�7���$�1/}�=���񶅔P��Y��U�%	g�3��	�>���w|���6^�����������:�-�߈�x>)� �������u1;�?t�$S�b�ZC)t΍�a�3�8�+S�������}��J[(0�C��6�f|�)�����W��$a#>�q�uZ��q��­�A�79	�U�WI<F~�>G����	5ka�ʷI�4R���3�e�7�-�m;�<T\�m�oL������*I��#�=�W��>�o��[�p��A�_+�_���<���ٺ����s�>'W���0G�I��-Jm�
�9:�/(��H%چ۳v�u@�o�/3����R��������e�m�
]�Թ�y�v�u�?ǫƥ�ʥvhj���X���8	�KuN�b�iWL��Ѭ���>�M��)�%�G���̸�q����s33��3�D�.�g
��j�4C�I�	�@}ɥ�[16J����Ja�l(�C9���q�Sb��T�'��~�12w$��P����8��S��X���E �[F�ω�tb,�������9�5w� uc�cL�\V�zZic�(�^�sJ;�!��m����;�-�b-c>ʴ��ƻyX� ��p~?e��s��q
{y�g��@N��Sj�+uq�C�Е~��`����3T�u5np��N3��6����)���&+U�(��zVnO���^C9ܞ���r=�)��z2�1�AEla�j���n��:��\�m�ɵ4�<}jt�	�`G@ A?�azĈS:�,*E&�#�D�P_Ė0Q�þ99���J��\�{�}g���H]��������k0�䷫ �}=.���s�l�CRv3~��v�Qj�Ah�����_\M����_�	�Q��H0A�gv'�����lLҾ��]���.g�*b�ډ��PԮS1St+S���a��	�f�[��]řm�~��(�$mg7(jb����@�Vu9ݮXU�Rg��[��a@�����՚i���3���dZ0I�,g�����^��j��(���%Z�ʹ���Lh�_Y���<S���]N�-'��lL�q�\-�LKТf-ǁ�>��8�"�iyt%�mFZ������6��6�r3ӂI���m5�beZ���s�e hZ��L��i�L����M'��8���|�o��M�5���;X<����0E�aK��ڊ;D�	��2\_�w�f2��'2>�d<�"CK�l.�b��[,D��᲌A����`s�0!�F�w:���+h1I+��qC�ǹ���۴WM����^���Z�]�ad���	A�-������n�{���Q�i��I�}��>�yFf%"=�0�!(�g��QH���!�HNxvH���yﳍx�K�w�L7��� �E�X9`z�e�n�t�l#<q�c��pמ��p�Q��J^�1Ӻ1�����e�^�3��|��r]�e�g:^U;���UĜ��+ԓ��=�.�C���$t���w��U#�g���1m����┾#·��Li;@��mO Q���4�+v�F`�i<�i<a,�%��d�}־��"���&��ݔ��[17V�aR3bQ�z�ټcp��6�=��
(�tT$�y��~�sb��6�k؎Y�pp
��qޙE ���Y�
!�k�{���6E/�J��~�P�!��jMdr7���9�p�35U(�i�`Y�I�	��0�L�(�-��>Ʈح�X�+�U��L��9
���H1����$��`�0H�*��P�i�iS�3�t�va5k�vDt�z�狕��^�Ez���VB�$8(��V�X��@<�X�8���V�E޴kx:4 P��Y���eRmRA��䐜a5��n&��);�{5����@�X�'@(uB�|�C�P�9�����D����S$z��\r�CT�Ƃ2���erX%n�b9LJo�5R0Zxl	��q�Yo.3h�:���u1e̢�m��a�̰��`o��;��Z!��zA2	!�"�%dS�_�?1;mF��j�X�_�?�-L��ܬ����m����VQn
�F��6�t����Z���w�<,#�рT�@J��zrҶ�2�銘�BEb�
R�9��b��;��wx�V��V���H
6�Zj��\��6ELю]=�~��hb+�RѦe.2n@)�w,�P�
�T�oH�CK���~՞Kh�P��M]��l��>�n���A[�*As�^��9����)���&��h7,�J6�+ِ�ʐ�P/��-��;�6p�<��2��� ��'L0m���8e�cE$y?t�~~�҅�Q�e��'�1��=F��X/C�����YX돱mɁ�� C\[��2�?\иw[~ػ�}�E��t�.�S��Fy�g����	�/�y�5ܷT�n�B]4��V�X�c�8���t��yb)�^Ch%hy/���@�E�ΎX�����d�VR�Ʃ�:	��ﾗ��a���=�2p�S�(�{	�aXtx�B����0�?�K�"(��Չ�2.p�"�v�:EOf�;��_g�!{�~�6��*��`B �~�p�Yn,N��c��B4�'�}�AX�: b=l	����A�Hq�n��e�]���D�j������
�U�Ȉ@JT��Z���b��D�(<���`�S��;�z8X�;�b�j��(�i���������X�`����
�x`�4����y�n���������8���V���ҮQ�b�u1��P7A䔂U�ӶSɻ@��R㋡���a��k��Ϡ�P�c|m	���	�q�pI�������V3)£G��C#(���6�S���̹��2�%&���v��|�= b8B���kC8[8`Ŭ]�+(�p�Gy�7�,@6��~VjkxwEE5V3D
�Z3.����H�]�(r4�+�Y����&�0|Z���	��!�`�Α��������*�&��N0��ږ*t/��-[�M���FI�c��PZz����_�h,;��U�f��P�q�:X+0}Lx��AG�Zf�
�Q��J갠Cp���*\8���8�9��YC�⍅��\T���iM,Yԥ��P�r�֣�.6�u���׵��S_%�g��l�T�������5^��(�N1nU�qڲ�p!���B��C�NퟯHxL���cW>O����-|�~%��vX��)m4Kv�Z�����\��VBg�������ړW���rj�g݉ė�`Q&$�%��æ���VX?[���3t��.�Q4]pO��>4RM:�}�n��}Ų��-$::�bSa>�Z�F�Xb�ї�07xQ��i���퇏r�O�e��o�a ���}��6��b��e���SF�ɉ�m7��.J��2 � ɚ�h�y�YL{Ϙq#�r���8g���&�#`�0�a}���	���0T��������	�4፺<��|���_nT'�,#>�Ӡ}{q����I�G�]�EF�y�b����a�ը�iO����
k��>jpУ�%�SsY^4)Yj��ݹ.eK�Q�A�[#�!�>��X�U�Zu���E�ϲ�e{���33�⒌y�-�1���I].S���e��A˿O	��}��|�|	g��(T������bk4ձo��KՖ@Zbd���a^p��OfG_Ǹ�Ң�T�$L��l y��-"�3����ř��t�>My?��E9֏:y��m�]�AlxJ���!�."�7X���-z��E�B�#T��̘���C���ź�:��������H�
��o�I����#>�9��4��}>)�е�Wwt��g02O����X]��|}�j�1�zc�r,|l1�V��K��3��C��Z�_�Z�&=�0�b>�]�=�XuB/W�XS��<�hp�	�3�/�X��Jt*�=��94���{hY�z5���.H��]���Y�&~T�Ɩ�>3w��܂����@CE�Xb�j���>VTQ���I]*s�^#��O΢$�ř�������){�9�% ���tX���R�@��7,�YU�
�{t��.&���}�~��T��K��<�'�I9�ru��9ϟ::�"P�E�r&d,I�q<B��|uv3!�{����z�v�G�܊#<�b?e���+�޸�r�N�)oPr��V�%�P9��A8Cc���V�o�q�g}����y-I�ĭ��"�f?���O+��? �0$�O.ꜰtN���׸��q�X��~�Y>o7Z�h}ҢM��"��;�[1ܝ�>�C�6Y(C�:�BP����a�j�>A:�L \p4�*�Pb\����fbI�a�|l1J'��&��I���?8&�Y�NG#܋_�.L���bjqE�h:5[��ÿÜ��$�by\�RHY*F5S��]k�Ra����Rq�Rȉ)~mDKV
oN�� ^နl��vhd�"����Z,����g��t,|vsx�������C��%��.�̚A�ͬ��g��9z>Lϣ��<=��������8=�D����
=�Jϯӳ��ߤ��|���|��O��z��=G�y��c�<E����<=��Y��w`o�5���v7]�#�k�h�G0��S1��}cc�>�ед��	�݋��`yr�c�{c�A�M~c�}c_�����ȁ�%(&0�c�`�v�� kڏ��1vc[0��
1�$�p��L.��)L�
c?Ƙc�b��G�I���4�C�\|�s������f�˼#��!1���=��笲g�7k1�#
JɎ�<��w��>1���>��2 �e�D�����&���ߡh����=��P9�_��=������釙����b���z��,~�{#�����H���K*��7`1��TL�����8�ۼ���A����C�Y��M�0�M��77�z��w)�oٴI@�ܠ��^%$����7��ҵ�!(�Է�Z�-r0���@�XN�7{�x�s��s��H#xW���Ao�����x��wN�}�q�$�ph�$�@XJ���+�:I���<�����B�N�H��\��U��D�H��K$�X%�]ʘ�
p\#Y�`��x�dq�t�^uV#q���>d�x��K����_��1I���|��>�a��J�#"|^��E�s�!��0�!��׈��}6F�^�?�����\�p�o�="l�?��~���W�J_�+}������W�J_�+}��ҕ�u9��JK���B�����*
���R��-R��bOk8�LI*��y�g��A��v�q��͝��\}@����N��Ff,�E2�)��ە6o ��o��*RhD�e���`��>���MHD�Ln)���۱K٘p�}N�����]A�����ɂOS}@	�}� �����1��)�w��'E��+^�mm��)�aqV��I)WX�(mᐂ��=!o@	z?��=0��3�vbrѾ��ϣ�Co}�{��ۡ8��6(�w�*VZ�H���y�� �6)��=�*�������P��s�"E���TQ��շ)��_�n�����zl�I�n��]�@t�p4��k�n�s��c*&h֌��O�:�Ɖ7�FI
�/���z[��m�R#�:�G�0�U<�--�~w��5`L�!�H��,�8��ލa��X����ל�K)\�kRc���!���˼��u?5���YN
tY����ǒ?17��N2N̱��9[c�ۀ���:���<�s2E,'Q�{	�K�����P�4����8w�*RKߥcчa�P4�>�;�RWp��x"%3�AE ��$���ʬF����>�J�K������x����G��4��b���y�jw�+��zE�Ƌ���Z�4�����}~�x�h^�9^$MO?�LoxM������X�-�O�A�]��C�V��/�Xi���H���$���K���	�M�z�ur�n"O}FA���X;�XX�vH�L��=R��>��#}���6�_dJY�,4��1�@�^ϸL���i�)����Y��9�~���K�g~
M��2��o��P<�+$)Ӹ5?�5k��B����1+3k�jE�G��0y����H�,�ff�/,_"G2&Le�[�M��������g3�O	�����ᅋ����-�?>$`Y��0�1!|Bϗ�9��#�\�VIzOV�;C������{<%�o	�:�]��~\��>��w��I����="`���)��H�υ�Z�υ>%`�|�W�υ�6vKv� oK�W'�-���'�v2�8���	��	��	�_l�L�kL��M��&ؖ�
�Mp�?e��g�a�_3��R�&X!8��æ��)��&���O��Q|����n��.L������Mp�	Ɵ5�0�'��������� �{G�-�U�����ϴ���;Nx��d���$��,!�Q�3�Ep�#�]�R��7�n|I��������7�6����,����K�߼	�&��7��.�n��V��b�]fk�m��e�>���e��ު�u����Յ���U�F;�m1�.Ѳ�d��-�Roň�$�i��B����K6�注f�Rs�7����~�׸��5��5�����J1������nj�6�,�a����K�'�L6_�B;��yj(��z�~?X�$�ψi�l���BK�i1\L=�"���
/�-���j�o f�U2�B���~��DX��,�-qW�aˉ��di��m��6{�R
g�l��R0�PA��ҿT�?��]���E��/),H������w���6�����(�y��l�g}�=��{6�7�d�R�O�Yvl�`��r1�k��?���2�X�PUs������_�7ָI.tP��a!(E��-o�"�4�"��n+�g�#����A�����\��E�H�G��
�jޒ��|�yM�H4�r�=79�{|{/ؕ[G����_�W���m�5{�5��(�0[�����;r9k�;�V9a=�x��y�_��u�2��V�m[m-$�ƺv-B�Wnݎ��a���Y���.�{���r��9�n� ��mu�VYa�ZY1����7ɫs)y6[2����'�����έ�ȓW���B�'�ʫ�m6*ݚ����^(�E��ٸ��R��YM-�&���@���(��b 5-@�W�J_�+}�������_����2� x  