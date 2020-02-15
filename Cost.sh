#!/bin/sh

costPerGB=0.005

get_pools()
{
	root=$1	
	df -k /pool/* | sed 1d | awk -v costPerGB=$costPerGB '{gbSize=sprintf("%.2f GB", $3/1024/1024); tbSize=sprintf("%.2f TB", $3/1024/1024/1024); cost=(costPerGB/1024/1024)*$3*12;  totalSize+=tbSize; totalCost+=cost; costFormatted=sprintf("$%.2f", cost);  printf "%-50s %8s %8s\n", $1, tbSize, costFormatted}END {totalSizeFormatted=sprintf("%.2f TB", totalSize); totalCostFormatted=sprintf("$%.2f", totalCost); printf "%-50s %8s %8s / year\n", "", totalSizeFormatted, totalCostFormatted}'
}

if [ $# -eq 0 ];
then
	echo "Please provide a root path"
	exit 1
fi

get_pools $1
