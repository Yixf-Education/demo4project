#!/bin/bash

usage() {
  echo -e "Usage:\n$0 [-d <working directory>] [-i <input file>] [-f <input folder>] [-o <output folder>]"
  grep " .)\ #" $0
  echo -e "Note: Input is SRR*.fastq, and output is GSM*.fastq.\n"
  exit 0
}

while getopts ":hd:i:f:o:" arg
do
  case $arg in
    d) # Specify working directory. [default: .(current directory)]
      dir_work=${OPTARG}
      ;;
    i) # Specify input file, which contains GSM-SRR information. [default: GSM2SRR.txt]
      file_in=${OPTARG}
      ;;
    f) # Specify input folder, which contains SRR*.fastq. [default: fastq]
      dir_in=${OPTARG}
      ;;
    o) # Specify output folder, saving the merged FASTQ. [default: fastq_merged]
      dir_out=${OPTARG}
      ;;
    h | *) # Display help.
      usage
      exit 0
      ;;
  esac
done

[ ! $dir_work ] && dir_work="."
[ ! $file_in ] && file_in="$dir_work/GSM2SRR.txt"
[ ! $dir_in ] && dir_in="$dir_work/fastq"
[ ! $dir_out ] && dir_out="$dir_work/fastq_merged"
[ ! -d $dir_out ] && mkdir $dir_out
[ ! -f $file_in ] && usage

echo -e "---------- Runing parameters ----------"
echo -e "Working directory:\t$dir_work"
echo -e "Input file:\t$file_in"
echo -e "Input folder:\t$dir_in"
echo -e "Output folder:\t$dir_out"
echo -e "---------------------------------------\n\n"

check_to_backup () {
  GSM=$1
  file_to_se=$dir_out/${GSM}.fastq
  if [ -f $file_to_se ]
  then
    echo -e "$file_to_se exists! The old file will be backuped to ${file_to_se}.bak\n"
    mv $file_to_se ${file_to_se}.bak
  fi
  file_to_pe1=$dir_out/${GSM}_1.fastq
  if [ -f $file_to_pe1 ]
  then
    echo -e "$file_to_pe1 exists! The old file will be backuped to ${file_to_pe1}.bak\n"
    mv $file_to_pe1 ${file_to_pe1}.bak
  fi
  file_to_pe2=$dir_out/${GSM}_2.fastq
  if [ -f $file_to_pe2 ]
  then
    echo -e "$file_to_pe2 exists! The old file will be backuped to ${file_to_pe2}.bak\n"
    mv $file_to_pe2 ${file_to_pe2}.bak
  fi
}

GSM_string=`cat $file_in | grep -v "#" | cut -f1 | sort | uniq`
GSM_array=($GSM_string)
for GSM in ${GSM_array[@]}
do
  echo "Processing $GSM ..."
  file_to_se=$dir_out/${GSM}.fastq
  file_to_pe1=$dir_out/${GSM}_1.fastq
  file_to_pe2=$dir_out/${GSM}_2.fastq

  check_to_backup $GSM

  SRR_string=$(grep $GSM $file_in | sort | uniq | cut -f2 | sort | uniq)
  SRR_array=($SRR_string)
  srr_total=${#SRR_array[@]}
  srr_count=0
  if [ $srr_total -gt 1 ]
  then
    for SRR in ${SRR_array[@]}
    do
      srr_count=$(($srr_count+1))
      echo -e "\tProcessing $SRR [$srr_count/$srr_total] ..."

      file_from_se=$dir_in/${SRR}.fastq
      file_from_pe1=$dir_in/${SRR}_1.fastq
      file_from_pe2=$dir_in/${SRR}_2.fastq
      if [ -f $file_from_se ]
      then
        cat $file_from_se >> $file_to_se
      elif [ -f $file_from_pe1 -a -f $file_from_pe2 ]
      then
        cat $file_from_pe1 >> $file_to_pe1
        cat $file_from_pe2 >> $file_to_pe2
      else
        echo -e "${SRR}.fastq or ${SRR}_1.fastq or ${SRR}_2.fastq can not be found in $dir_in!"
        exit 1
      fi

      echo -e "\tProcessing $SRR [$srr_count/$srr_total] ... Done!"
    done
  else
      file_from_se=$dir_in/${SRR_array[0]}.fastq
      file_from_pe1=$dir_in/${SRR_array[0]}_1.fastq
      file_from_pe2=$dir_in/${SRR_array[0]}_2.fastq
      if [ -f $file_from_se ]
      then
        ln $file_from_se $file_to_se
      elif [ -f $file_from_pe1 -a -f $file_from_pe2 ]
      then
        ln $file_from_pe1 $file_to_pe1
        ln $file_from_pe2 $file_to_pe2
      else
        echo -e "${SRR}.fastq or ${SRR}_1.fastq or ${SRR}_2.fastq can not be found in $dir_in!"
        exit 1
      fi
  fi

  echo -e "Processing $GSM ... Done!\n"
done

