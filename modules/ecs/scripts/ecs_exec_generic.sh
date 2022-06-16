#!/bin/bash

# Bash Functions:
decorator () {
    echo -e "Generating Task List: \n"
    echo -ne '[....................](00%)\r'
    sleep 1
    echo -ne '[#####...............](25%)\r'
    sleep 1
    echo -ne '[##########..........](50%)\r'
    sleep 1
    echo -ne '[###############.....](75%)\r'
    sleep 1
    echo -ne '[####################](100%)\r'
    echo -e '\n'
}

generate_task_list () {
    TASK_LIST=$(aws ecs list-tasks --cluster demo-cluster --family demo_flask_app --region us-east-1 | jq -r '.taskArns' | jq -r '.[]' | awk -F "/" '{print $3}')
    array=(${TASK_LIST/// })
    echo "Task ID List:"
    echo ""
    for i in "${!array[@]}"
        do
            echo "Task ID $i = ${array[i]}"
        done
}

# Commands validation:
CMMD="session-manager-plugin"

if command -v $CMMD > /dev/null
	then
		echo "" > /dev/null
	else
		echo "[ERROR] $CMMD not installed - Please install $CMMD to continue"
        echo -e '\n'
        echo "Ref: https://docs.aws.amazon.com/systems-manager/latest/userguide/session-manager-working-with-install-plugin.html"
        echo -e '\n'
		exit 1
fi

CMMD2="jq"

if command -v $CMMD2 > /dev/null
	then
		echo "" > /dev/null
	else
		echo "[ERROR] $CMMD2 not installed - Please install $CMMD2 to continue"
        echo -e '\n'
        echo "Ref: https://stedolan.github.io/jq/download/"
        echo -e '\n'
		exit 1
fi

PS3='Are you using a Profile? (Select an option): '
OPTIONS=("Yes" "No" "Quit")
select opt in "${OPTIONS[@]}"
do
	case $opt in
		"Yes")
            read -p "Input your AWS Profile Name: " AWS_PROFILE
            read -p "Input your AWS Region: " AWS_REGION
            read -p "Input the ECS Cluster Name: " ECS_CLUSTER
            read -p "Input the Container Name: " CONTAINER_NAME
            decorator; generate_task_list
            echo -e '\n'
            read -p "Input your Task ID (Copy and paste one of the above): " TASK_ID
            echo -e '\n'
            echo -e "[INFO] Using variales: $AWS_PROFILE $AWS_REGION $ECS_CLUSTER $CONTAINER_NAME $TASK_ID"
			aws ecs execute-command --cluster $ECS_CLUSTER --task $TASK_ID --container $CONTAINER_NAME --command "/bin/bash" --interactive --region $AWS_REGION --profile $AWS_PROFILE
			exit 0
			;;
		"No")
            read -p "Input your AWS Region: " AWS_REGION
            read -p "Input the ECS Cluster Name: " ECS_CLUSTER
            read -p "Input the Container Name: " CONTAINER_NAME
            decorator; generate_task_list
            echo -e '\n'
            read -p "Input your Task ID (Copy and paste one of the above): " TASK_ID
            echo -e '\n'
            echo -e "[INFO] Using variales: $AWS_REGION $ECS_CLUSTER $CONTAINER_NAME $TASK_ID"
			aws ecs execute-command --cluster $ECS_CLUSTER --task $TASK_ID --container $CONTAINER_NAME --command "/bin/bash" --interactive --region $AWS_REGION
			exit 0
			;;
		"Quit")
			echo -e "[INFO] Script ended"
			break
			;;
		*)
			echo -e "[ERROR] $REPLY Is an invalid option - Select the option NUMBER, for example: 1"
			exit 1
			;;
	esac
done