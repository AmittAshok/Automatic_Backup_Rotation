#!/bin/bash

<< comment

 ********* This script is use for taking backup with rotation ***********
          run = ./backup.sh <source_path> <backup_path> 
comment

   function handling {
	   echo " run = ./backup.sh <source_path> <backup_path> "
   }

   if [ $# -eq 0 ] ;then
	   handling
   fi

   source_dir=$1
   timestamp=$(date '+%Y-%m-%d-%H-%M-%S')
   backup_dir=$2

   function backup_creation {

	   zip -r "${backup_dir}/backup_${timestamp}.zip" "${source_dir}" > /dev/null

	   if [ $? -eq 0 ];then

	   echo " Backup generated sucesfully for ${timestamp} "
           fi
   }

   function backup_rotation {

	   backups=($(ls -t "${backup_dir}/backup_"*.zip 2>/dev/null))
	   # echo "${backups[@]}"
           
	    if [ "${#backups[@]}" -gt 5 ];then
                      echo "Performing rotation for 5 days "
	             
		      backup_to_remove=("${backups[@]:5}")
		      # echo "${backup_to_remove[@]}"

		      for backup in "${backup_to_remove[@]}";
		      do
			      rm -f ${backup}

		      done
	    fi

	  
          }

   backup_creation
   backup_rotation
