#!bash
#
# bash completion support for symfony1.4 console
#
# Copyright (C) 2011 Matthieu Bontemps <matthieu@knplabs.com>
# Distributed under the GNU General Public License, version 2.0.

_symfony()
{
    local cur prev cmd
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    cmd="${COMP_WORDS[0]}"
    PHP='$ret = shell_exec($argv[1] . "");

$comps = "";
$ret = preg_replace("/^.*Available commands:\n/s", "", $ret);
if (preg_match_all("@^(\s|[a-z])+([^ ]+)(\n|\s)@m", $ret, $m)) {
    $tmp = $m[0];
}
$cmd_1 = null;
$comps = array();
foreach($tmp as $t){
    $t = trim($t);
    if (substr($t, 0, 1) != ":"){
        $t1 = explode("\n", $t);
        $cmd_1 = $t1[0];
        if (!empty($t1[1]))
            $comps[] = $cmd_1.trim($t1[1]);
    }elseif($cmd_1){
        $comps[] = $cmd_1.$t;
    }
}

echo implode("\n", $comps);
'
    possible=$($(which php) -r "$PHP" $COMP_WORDS);
    COMPREPLY=( $(compgen -W "${possible}" -- ${cur}) )
    return 0
}
complete -F _symfony symfony
COMP_WORDBREAKS=${COMP_WORDBREAKS//:}