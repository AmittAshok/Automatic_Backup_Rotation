#!/bin/bash
#
<< Details
          This is log analyzer code,where we inspect the code for clairty 
Details

# First check if proper argument provide or not
#
     if [ $# -eq 0 ];then
	     echo " Enter the source path or file"
	     exit 1
     fi

     log_file=$1
     backup_dir=$2
     timestamp=$(date '+%Y-%m-%d-%H-%M-%S')
# check for backup dir file

     if [ ! -d "$backup_dir" ];then
	     echo " Backup dir is not present"
	     #mkdir -p "/home/ubuntu/shell_script/${backup_dir}"
	     
     fi
# check backup dir is writable or not
#
     if [ ! -w "$backup_dir" ];then
	     echo " Backup dir is not writable permission.... "
	     exit 1
     fi
# function for error count and here code will check count of errors in file

     function error_count()
     		{
	                count=$(grep -e 'error' -e 'failed' -i -c "$log_file")
	         	echo " count of 'error' and 'failed' lines :${count} "
		  
# Fucntion critical error find critical error and redirect to new file		
		}
	
     function critical_error()
     		{
	    	              	error=$(grep -n -w "Connection broken" "$log_file") 
	           		#echo "${error}"

		        	echo "${error} > "${backup_dir}"/error_log_${timestamp}"
                                     
 		}
# check for number of lines proceed

	total_lines=$(wc -l < "$log_file")

# sort top 5 errors  from log file

        top_errors=$(grep -Ei 'error|failed' "$log_file" | sort | uniq -c | sort -nr | head -n 5)

# function for summary report

	function summary_report()
		{
		   echo "******** Summary report*******"
	   	   echo "=============================="
		   echo 
		   echo " Date of summary : $(date)"
		   echo " Total line process : ${total_lines}"	
		   echo " Total error count : " 
		   echo "${top_errors}"
		   echo 
		   echo "********** Summary report ends************"
	        }	 


		  		   

     error_count
     critical_error
     summary_report






