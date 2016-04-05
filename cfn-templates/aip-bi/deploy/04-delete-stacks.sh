#!/bin/bash

ENV=""
REGION=""

while getopts ":e:r:h" opt; do
	case $opt in
		h)
			echo "Usage: $0 -e <env> -r <region e.g. 'us-1'>"
			exit 0
			;;

		e)
			ENV=$OPTARG
			;;

		r)
			REGION=$OPTARG
			;;

		:)
			echo "Requires -e <env>, -r <region e.g. 'us-1'>"
			exit 1
			;;

	esac
done

if [ -z $ENV ] || [ -z $REGION ]; then
	echo "Usage: $0 -e <env> -r <region e.g. 'us-1'> -z <zone id>"
	exit 1
fi


set -x




aws cloudformation delete-stack --stack-name aip-proxy-$ENV-master --region $REGION
aws cloudformation delete-stack --stack-name bi-app-$ENV-master --region $REGION
aws cloudformation delete-stack --stack-name aip-platform-$ENV-master --region $REGION

ret=$?


exit $ret
