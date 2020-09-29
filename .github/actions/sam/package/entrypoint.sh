#!/bin/bash

set -u

function parseInputs(){
	# Required inputs
	if [ "${INPUT_SAM_COMMAND}" == "" ]; then
		echo "Input sam_subcommand cannot be empty"
		exit 1
	fi
}

function installAwsSam(){
	echo "Install aws-sam-cli ${INPUT_SAM_VERSION}"
	if [ "${INPUT_SAM_VERSION}" == "latest" ]; then
		pip install --user aws-sam-cli
		#pip3 install aws-sam-cli >/dev/null 2>&1
		if [ "${?}" -ne 0 ]; then
			#test = pip3 install aws-sam-cli >/dev/null 2>&1
			#echo "Run sam ${INPUT_SAM_COMMAND}"
			#output=$(pip install --user aws-sam-cli)
			#output=$(pip3 install aws-sam-cli 2>&1)
			#output=$(pip3 install aws-sam-cli >/dev/null 2>&1)			
			#echo "${output}"
			#echo "${?}"
			echo "done printing errors"
			#test = pip --version
			#echo "${test}"
			
			python3 -m pip list
			echo python --version
			echo "Failed to install aws-sam-cli ${INPUT_SAM_VERSION}"
		else
			echo "Successful install aws-sam-cli ${INPUT_SAM_VERSION}"
		fi
	else
		pip3 install aws-sam-cli==${INPUT_SAM_VERSION} >/dev/null 2>&1
		if [ "${?}" -ne 0 ]; then
			echo "Failed to install aws-sam-cli ${INPUT_SAM_VERSION}"
		else
			echo "Successful install aws-sam-cli ${INPUT_SAM_VERSION}"
		fi
	fi
}

function runSam(){
	if [ "${INPUT_GITHUB_PACKAGE_REGISTRY_TOKEN}" == "" ]; then
		echo "//npm.pkg.github.com/:_authToken=${INPUT_GITHUB_PACKAGE_REGISTRY_TOKEN}" > ~/.npmrc
	fi
	
	#echo "go path"
	
	#echo "${GODEBUG}"
	echo "path in entrypoint"
	echo "$PATH"
	echo "Run sam ${INPUT_SAM_COMMAND}"
	output=$(sam ${INPUT_SAM_COMMAND} 2>&1)
	exitCode=${?}
	echo "${output}"
	
	output=$(sam package --s3-bucket ${AWS_S3_BUCKET} 2>&1)
	output=$(sam deploy --stack-name sam-app --no-confirm-changeset --debug 2>&1)
	exitCode=${?}
	echo "${output}"	
	#echo go --version
	#cd /usr/local/go
	#ls -R

	commentStatus="Failed"
	if [ "${exitCode}" == "0" ]; then
		commentStatus="Success"
	fi

	if [ "$GITHUB_EVENT_NAME" == "pull_request" ] && [ "${INPUT_ACTIONS_COMMENT}" == "true" ]; then
		commentWrapper="#### \`sam ${INPUT_SAM_COMMAND}\` ${commentStatus}
<details><summary>Show Output</summary>
\`\`\`
${output}
\`\`\`
</details>
*Workflow: \`${GITHUB_WORKFLOW}\`, Action: \`${GITHUB_ACTION}\`*"

		payload=$(echo "${commentWrapper}" | jq -R --slurp '{body: .}')
		commentsURL=$(cat ${GITHUB_EVENT_PATH} | jq -r .pull_request.comments_url)

		echo "${payload}" | curl -s -S -H "Authorization: token ${GITHUB_TOKEN}" --header "Content-Type: application/json" --data @- "${commentsURL}" > /dev/null
	fi

	if [ "${exitCode}" == "1" ]; then
		exit 1
	fi
}

function gotoDirectory(){
	echo "directory"
	echo ${INPUT_DIRECTORY}
	
	if [ -z "${INPUT_DIRECTORY}" ]; then
		return 1
	fi

	if [ ! -d "${INPUT_DIRECTORY}" ]; then
		echo "Directory ${INPUT_DIRECTORY} does not exists."
		exit 127
	fi

	echo "cd ${INPUT_DIRECTORY}"
	cd $INPUT_DIRECTORY
}

function main(){
	parseInputs
	#installAwsSam
	gotoDirectory
	runSam
}

main
