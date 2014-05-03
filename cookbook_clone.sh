#!/bin/bash

showhelp () {
cat << EOF

This script creates a new cookbook based on an existing cookbook or cookbook template.
Run it from your base cookbooks base dir.

Just provide the base part of the cookbook you want to create. 
Ie. "my-app" for "my-app-cookbook"

Usage:
${0} -t pack_conf_serv
Create a cookbook (name will be prompted) based on the template in templates/pack_conf_serv-cookbook

${0} -t pack_conf
Create a cookbook (name will be prompted) based on the template in templates/pack_conf-cookbook

${0} -t pack -n vim
Create a cookbook called vim-cookbook based on templates/pack-cookbook

${0} -m mysql
Create a cookbook cloned from the existing cookbook mysql-cookbook

EOF
}

while [ ${#} -gt 0 ]; do
  case "${1}" in
  -t)
    template="${2}"
    shift 2 ;;
  -m)
    cookbook="${2}"
    shift 2 ;;
  -n)
    name="${2}"
    shift 2 ;;
  esac
done

showhelp

clone_from_template() {
  if [ ! -f "templates/${template}-cookbook/recipes/default.rb" ] ; then
    echo "I don't find templates/${template}-cookbook/recipes/default.rb"
    echo "Run this script from the base cookbooks directory and specify a valid source cookbook template"
    echo "Available Templates are in templates:"
    ls -1 templates/ | sed s/"-cookbook"//g
    exit 1
  fi

  OLDMODULE="templates/${template}-cookbook"
  OLDMODULESTRING="xxx_template_xxx"

  clone
}

clone_from_cookbook() {
  # FIXME! Not working now. Not even written :)
  echo "Not working now. Not even written :)"
  exit 1

  if [ ! -f "${cookbook}-cookbook/recipes/default.rb" ] ; then
    echo "I don't find ${cookbook}-cookbook/recipes/default.rb"
    echo "Run this script from the base cookbooks directory and specify a valid source cookbook"
    exit 1
  fi

  OLDMODULE="${cookbook}-cookbook"
  OLDMODULESTRING="${cookbook}"

  clone
}

function clone() {
  echo
  if [ x${name} == 'x' ] ; then
    echo -n "Enter the name of the new cookbook to create (without the -cookbook part, it will be added later):"
    read NEWMODULE
  else
    NEWMODULE="${name}-cookbook"
  fi
  
  if [ -f "${NEWMODULE}/recipes/default.rb" ] ; then
    echo "Module ${NEWMODULE} already exists."
    echo "Move or delete it if you want to recreate it. Quitting."
    exit 1
  fi
  
  echo "COPYING MODULE"
  mkdir ${NEWMODULE}
  rsync -av --exclude=".git" --exclude "spec/fixtures" ${OLDMODULE}/ ${NEWMODULE}


  echo "RENAMING DIRECTORIES"
  for file in $( find ${NEWMODULE} -type d | grep ${OLDMODULESTRING} ) ; do
    newfile=`echo ${file} | sed "s/${OLDMODULESTRING}/${NEWMODULE}/g"`
    echo "${file} => ${newfile}" ;  mv ${file} ${newfile} && echo "Renamed ${file} to ${newfile}"
  done

  echo "RENAMING FILES"
    for file in $( find ${NEWMODULE} -type f | grep ${OLDMODULESTRING} ) ; do
    newfile=`echo ${file} | sed "s/${OLDMODULESTRING}/${NEWMODULE}/g"`
    echo "${file} => ${newfile}" ;  mv ${file} ${newfile} && echo "Renamed ${file} to ${newfile}"
  done

  echo "---------------------------------------------------"
  echo "CHANGING FILE CONTENTS"
  for file in $( grep -R ${OLDMODULESTRING} ${NEWMODULE} | cut -d ":" -f 1 | uniq ) ; do
    # Detect OS
    if [ -f /mach_kernel ] ; then
      sed -i "" -e "s/${OLDMODULESTRING}/${name}/g" ${file} && echo "Changed ${file}"
    else
      sed -i "s/${OLDMODULESTRING}/${name}/g" ${file} && echo "Changed ${file}"
    fi

  done

  echo "Module ${NEWMODULE} created"
  echo "Start to edit ${NEWMODULE}/manifests/params.pp to customize it"

}

if [ "x${cookbook}" == "x" ] ; then
  clone_from_template
else
  clone_from_cookbook
fi

