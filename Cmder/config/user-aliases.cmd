;= @echo off
;= rem Call DOSKEY and use this file as the macrofile
;= %SystemRoot%\system32\doskey /listsize=1000 /macrofile=%0%
;= rem In batch mode, jump to the end of the file
;= goto:eof
;= Add aliases below here
e.=explorer .
ls=ls --show-control-chars -F --color $*
ll=ls -l --show-control-chars -F --color $*
pwd=cd
clear=cls
history=cat "%CMDER_ROOT%\config\.history"
unalias=alias /d $1
vi=vim $*
cmderr=cd /d "%CMDER_ROOT%"

gad=git add -A $*
gbr=git branch $*
gcf=git config $*
gcm=git commit -am $*
gco=git checkout $*
gdf=git diff $*
glg=git log --oneline --all --graph --decorate  $*
gps=git push $*
gst=git status $*
gsb=git submodule $*
