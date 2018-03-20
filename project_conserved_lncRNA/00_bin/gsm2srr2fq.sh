#!/bin/bash

check_dependency () {
# Make sure "Entrez Direct" and "SRA Toolkit" installed.
  err_code=0
  if ! type "efetch" > /dev/null 2>&1
  then
    err_code=$(($err_code+1))
  fi

  if ! type "fastq-dump" > /dev/null 2>&1
  then
    err_code=$(($err_code+2))
  fi

  case $err_code in  
    1)  
      echo -e "Please install E-utilitie(Entrez Direct).\n"
      exit 1
      ;;  
    2)  
      echo -e "Please install SRA Toolkit.\n"
      exit 1
      ;;  
    3)  
      echo -e "Please install E-utilitie(Entrez Direct) and SRA Toolkit.\n"
      exit 1
      ;;  
  esac  
}

check_dependency


usage() {
  echo -e "Usage:\n$0 [-d <working directory>] [-i <input file>] [-o <output file>]"
  grep " .)\ #" $0
  echo -e "Note: SRA and FASTQ files will be saved at 'sra' and 'fastq' folder respectively, under workding directory.\n"
  exit 0
}

while getopts ":hd:i:o:t" arg
do
  case $arg in
    d) # Specify working directory. [default: .(current directory)]
      dir_work=${OPTARG}
      ;;
    i) # Specify input file, whose first column is GSM-IDs. [default: GSM.txt]
      file_in=${OPTARG}
      ;;
    o) # Specify output file, saving the GSM-SRR information. [default: GSM2SRR.txt]
      file_out=${OPTARG}
      ;;
    t) # Just convert GSM-IDs to SRR-IDs, don't download any SRR-FASTQ reads.
      flag_test=1
      ;;
    h | *) # Display help.
      usage
      exit 0
      ;;
  esac
done


[ ! $dir_work ] && dir_work="."
[ ! $file_in ] && file_in="$dir_work/GSM.txt"
[ ! $file_out ] && file_out="$dir_work/GSM2SRR.txt"
[ ! -f $file_in ] && usage
if [ -f $file_out ]
then
  echo -e "$file_out exists! The old file will be backuped to ${file_out}.bak\n"
  mv $file_out ${file_out}.bak
fi

echo -e "---------- Runing parameters ----------"
echo -e "Working directory:\t$dir_work"
echo -e "Input file:\t$file_in"
echo -e "Output file:\t$file_out"
echo -e "---------------------------------------\n\n"

vdb-config --set /repository/user/main/public/root="$dir_work"

if [ ! $flag_test ]
then
  dir_sra="$dir_work/sra"
  dir_fastq="$dir_work/fastq"
  [ ! -d $dir_fastq ] && mkdir $dir_fastq
fi

echo -e "#GSM\tSRR" > $file_out

GSMs=`cat $file_in | grep -v "#" | cut -f1 | sort | uniq`

gsm_total=`cat $file_in | grep -v "#" | cut -f1 | sort | uniq | wc -l`
gsm_count=0

if [ ! $flag_test ]
then
  for GSM in $GSMs
  do
    gsm_count=$(($gsm_count+1))
    echo "Processing $GSM [$gsm_count/$gsm_total] ..."

    echo -e "\t[1/4]: Get SRR-ID(s) from GSM-ID ..."
    SRR_string=`esearch -db sra -query $GSM | efetch -format docsum | xtract -pattern DocumentSummary -element Run@acc`
    # SRR=$(esearch -db sra -query $GSM |efetch -format runinfo | cut -d"," -f1 | grep "SRR")
    echo -e "\t[1/4]: Get SRR-ID(s) from GSM-ID ... Done!"

    SRR_array_unsorted=($SRR_string)
    IFS=$'\n' SRR_array=($(sort <<<"${SRR_array_unsorted[*]}"))
    unset IFS

    srr_total=${#SRR_array[@]}
    srr_count=0

    for SRR in ${SRR_array[@]}
    do
      echo -e "$GSM\t$SRR" >> $file_out
      srr_count=$(($srr_count+1))
      echo -e "\tProcessing $SRR [$srr_count/$srr_total] ..."

      echo -e "\t\t[2/4]: Retrieve SRA from NCBI ..."
      prefetch --max-size 100000000 $SRR
      SRA="$dir_sra/$SRR".sra
      echo -e "\t\t[2/4]: Retrieve SRA from NCBI ... Done!"
      echo -e "\t\t[3/4]: Validate SRA file ..."
      vdb-validate $SRA
      if [ $? -eq 0 ]
      then
        echo -e "\t\t[3/4]: Validate SRA file ... Done!"
        echo -e "\t\t[4/4]: Convert SRA to FASTQ ..."
        fastq-dump -O $dir_fastq --split-3 $SRA
        echo -e "\t\t[4/4]: Convert SRA to FASTQ ... Done!"
      fi
      echo -e "\tProcessing $SRR [$srr_count/$srr_total] ... done!"
    done

    echo -e "Processing $GSM [$gsm_count/$gsm_total] ... Done!\n"
  done
fi

if [ $flag_test ]
then
  for GSM in $GSMs
  do
    gsm_count=$(($gsm_count+1))
    echo "Processing $GSM [$gsm_count/$gsm_total] ..."
    SRR_string=`esearch -db sra -query $GSM | efetch -format docsum | xtract -pattern DocumentSummary -element Run@acc`
    SRR_array_unsorted=($SRR_string)
    IFS=$'\n' SRR_array=($(sort <<<"${SRR_array_unsorted[*]}"))
    unset IFS
    for SRR in ${SRR_array[@]}
    do
      echo -e "$GSM\t$SRR" >> $file_out
    done
  done
fi

