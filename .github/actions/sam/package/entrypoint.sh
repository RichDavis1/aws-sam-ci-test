#!/bin/bash

set -u

function parseInputs(){
	if [ "${INPUT_SAM_COMMAND}" == "" ]; then
		echo "Input sam_subcommand cannot be empty"
		exit 1
	fi
}

function runSam(){
	if [ "${INPUT_GITHUB_PACKAGE_REGISTRY_TOKEN}" == "" ]; then
		echo "//npm.pkg.github.com/:_authToken=${INPUT_GITHUB_PACKAGE_REGISTRY_TOKEN}" > ~/.npmrc
	fi
	
	echo "stage"
	echo "${INPUT_STAGE}"

	echo "stack"
	echo "${INPUT_STACK}"	

	echo "Running sam build"
	output=$(sam build --debug 2>&1)
	exitCode=${?}
	echo "${output}"	

	commentStatus="Failed"
	if [ "${exitCode}" == "0" ]; then
		commentStatus="Success"
	fi
	
	echo "Running sam deploy"
	echo "sam deploy --stack-name ${INPUT_STACK}-${INPUT_STAGE} --parameter-overrides Stage=${INPUT_STAGE} --no-confirm-changeset --no-fail-on-empty-changeset --debug"
	output=$(sam deploy --stack-name ${INPUT_STACK}-${INPUT_STAGE} --parameter-overrides Stage=${INPUT_STAGE} --no-confirm-changeset --no-fail-on-empty-changeset --debug 2>&1)
	exitCode=${?}
	echo "${output}"		

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
	gotoDirectory
	runSam
}

main
