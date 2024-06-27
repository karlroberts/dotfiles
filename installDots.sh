#!/bin/bash

CWD=`pwd`
cd `dirname $0`

DOTFILES=`pwd`

cd $CWD

echo DOTFILE is $DOTFILES

SCALA-DIST=${DOTFILES}/../skunk/scala-dist

UPDATE-SCALA-DIST=false

# credentials
if [[ -d /media/robertk/secret/backup/ssh ]]
then
  mkdir -p ~/.ssh
  chmod 700 ~/.ssh
  cp /media/robertk/secret/backup/ssh/id_rsa ~/.ssh
  chmod 400 ~/.ssh/id_rsa
  cp /media/robertk/secret/backup/ssh/id_rsa.pub ~/.ssh
  chmod 400 ~/.ssh/id_rsa.pub
  cp /media/robertk/secret/backup/ssh/id_rsa_skyfii ~/.ssh
  chmod 400 ~/.ssh/id_rsa_skyfii
  cp /media/robertk/secret/backup/ssh/id_rsa_skyfii.pub ~/.ssh
  chmod 400 ~/.ssh/id_rsa_skyfii.pub
  
  mkdir ~/.sbt
  chmod 770 ~/.sbt
  cp /media/robertk/secret/backup/nexus/skyfii-nexus-credentials ~/.sbt/.credentials
  chmod 400 ~/.sbt/.credentials
  
  cp /media/robertk/secret/backup/nexus/beonic-nexus-credentials ~/.sbt/.beonic-nexus-credentials
  chmod 400 ~/.sbt/.beonic-nexus-credentials
  
  mkdir -p ~/.m2
  ln -s ~/.sbt/.credentials ~/.m2/.credentials
  ln -s ~/.sbt/.credentials ~/.m2/.credentials
  
  mkdir -p ~/.ivy2
  ln -s ~/.sbt/.credentials ~/.ivy2/.credentials
  ln -s ~/.sbt/.beonic-nexus-credentials ~/.ivy2/.beonic-nexus-credentials
  
  # .docker
  mkdir -p ~/.docker
  rm -f ~/.docker/config.json
  cp /media/robertk/secret/backup/docker/docker_config.json ~/.docker/config.json
  chmod 700 ~/.docker/config.json
  echo "moded docker_config_from_secret if you see this diff be sure to back up to secrets before you trash me" >> ${DOTFILES}/docker_config.json
fi

#bash profile stuff
rm -f ~/.bash_aliases
ln -s ${DOTFILES}/bash_aliases ~/.bash_aliases
rm -f ~/.bash_paths
ln -s ${DOTFILES}/bash_paths ~/.bash_paths


# .coinspotpos
mkdir -p ~/.coinspotpos
#rm -rf ~/.coinspotpos
for f in `ls ${DOTFILES}/coinspotpos`
do
  ln -s ${DOTFILES}/coinspotpos/${f} ~/.coinspotpos
done


# .gitconfig
rm ~/.gitconfig
ln -s ${DOTFILES}/gitconfig  ~/.gitconfig

# .vimrc
rm ~/.vimrc
ln -s ${DOTFILES}/vimrc       ~/.vimrc

rm -rf ~/.vim
ln -s ${DOTFILES}/vim         ~/.vim 

rm -rf ~/.ctags
ln -s ${DOTFILES}/ctags       ~/.ctags

rm -rf ~/.tmux.conf
ln -s ${DOTFILES}/tmux.conf   ~/.tmux.conf

# install the pathogen plugin
mkdir -p /tmp/downloads/pathogen
curl -Sso /tmp/downloads/pathogen/pathogen.vim https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim

if [ -e /tmp/downloads/pathogen/pathogen.vim -a -s /tmp/downloads/pathogen/pathogen.vim ]
then
  rm -rf ${DOTFILES}/vim/autoload/pathogen.vim
  mkdir -p ${DOTFILES}/vim/autoload
  cp /tmp/downloads/pathogen/pathogen.vim ${DOTFILES}/vim/autoload/pathogen.vim
fi

grep "execute pathogen#infect()" ${DOTFILES}/vimrc
if test $? -gt 0
then 
  #the grep failed so prepend pathogen to .vimrc
  echo "execute pathogen#infect()" | cat - ${DOTFILES}/vimrc > /tmp/vimrc_edited && mv /tmp/vimrc_edited ${DOTFILES}/vimrc
  cp /tmp/vimrc_edited ${DOTFILES}/vimrc.tmp
fi

# get scala-dist vim stuff
if test ${UPDATE-SCALA-DIST}x -eq "truex"
then
  cd ${SCALA-DIST}
  git pull origin
  cd $CWD
  # scala plugin
  mkdir -p ${DOTFILES}/vim/bundle/scala
  cp -r $UPDATE-SCALA-DIST/tool-support/src/vim/* ${DOTFILES}/vim/bundle/scala/
fi

# taglist get from vim online
mkdir -p /tmp/downloads/taglist
curl -Sso /tmp/downloads/taglist/taglist.zip http://vim.sourceforge.net/scripts/download_script.php?src_id=19574

if [ -e /tmp/downloads/taglist/taglist.zip -a -s /tmp/downloads/taglist/taglist.zip ]
then
  rm -rf ${DOTFILES}/vim/bundle/taglist
  mkdir  ${DOTFILES}/vim/bundle/taglist
  cd ${DOTFILES}/vim/bundle/taglist
  # gen the helpfiles
  mkdir ./doc
  cd ./doc
  echo " cd vim/bundle/taglist; go to vim run :helptags ."
  # vim -c ":helptags ."
  cd ..
  unzip /tmp/downloads/taglist/taglist.zip
  cd $CWD
fi


