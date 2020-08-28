#!/usr/bin/env bash

set -e +o pipefail

ci=""
app=""
branch=""
build=""
job=""
org=""
repo=""
sha=""
slug=""

host="api.featurepeek.com"
print_env=""
image=""
registry_image_path=""
registry=""
tag=""
env_var=""
env_vars=""

res=""

# https://stackoverflow.com/questions/5014632/how-can-i-parse-a-yaml-file-from-a-linux-shell-script
function parse_yaml {
	local prefix=$2
	local s='[[:space:]]*' w='[a-zA-Z0-9_-]*' fs=$(echo @|tr @ '\034')
	sed -ne "s|^\($s\):|\1|" \
		-e "s|^\($s\)\($w\)$s:$s[\"']\(.*\)[\"']$s\$|\1$fs\2$fs\3|p" \
		-e "s|^\($s\)\($w\)$s:$s\(.*\)$s\$|\1$fs\2$fs\3|p"  $1 |
	awk -F$fs '{
		indent = length($1)/2;
		vname[indent] = $2;
		for (i in vname) {
			if (i > indent) {
				delete vname[i]
			}
		}
		if (length($3) > 0) {
			vn="peek_"; for (i=0; i<indent; i++) {
				gsub(/-/, "_", vname[i]);
				vn=(vn)(vname[i])("_")
			}
			gsub(/^[ \t]+/, "", $3);
			gsub(/[ \t]+$/, "", $3);
			printf("%s%s%s=\"%s\"\n", "'$prefix'", vn, $2, $3);
		}
	}'
}

# CLI args
if [ $# != 0 ]; then
	while getopts "a:de:i:p:r:t:" o
	do
		case "$o" in
			"a")
				app="$OPTARG"
				;;
			"d")
				host="api.dev.featurepeek.com"
				print_env="true"
				echo "Pinging dev"
				;;
			"e")
				echo $OPTARG
				env_var+="$OPTARG||"
				;;
			"i")
				image="$OPTARG"
				;;
			"p")
				registry_image_path="$OPTARG"
				;;
			"r")
				registry="$OPTARG"
				;;
			"t")
				tag="$OPTARG"
				;;
		esac
	done
fi

# print CI env vars
if [ "$print_env" ]; then
	echo ""
	printenv
	echo ""
fi

env_vars=$(echo $env_var | sed -e 's/||$//')

# being CI system detection
if [ "$JENKINS_URL" ] || [ "$JENKINS_HOME" ]; then
	echo "Jenkins CI detected."
	# https://wiki.jenkins-ci.org/display/JENKINS/Building+a+software+project
	# https://wiki.jenkins-ci.org/display/JENKINS/GitHub+pull+request+builder+plugin#GitHubpullrequestbuilderplugin-EnvironmentVariables
	ci="jenkins"
	build="$BUILD_NUMBER"

	if [ "$ghprbSourceBranch" ]; then
		branch="$ghprbSourceBranch"
	elif [ "$CHANGE_BRANCH" ]; then
		branch="$CHANGE_BRANCH"
	elif [ "$GIT_BRANCH" ]; then
		branch="$GIT_BRANCH"
	elif [ "$BRANCH_NAME" ]; then
		branch="$BRANCH_NAME"
	fi

	if [ "$ghprbActualCommit" ]; then
		sha="$ghprbActualCommit"
		echo "ghprbActualCommit: ${sha}"
	else
		sha=$(git ls-remote -q | grep "refs/heads/${branch}" | cut -f1)
		echo "git ls-remote -q: ${sha}"
	fi
elif [ "$CI" = "true" ] && [ "$TRAVIS" = "true" ] && [ "$SHIPPABLE" != "true" ]; then
	echo "Travis CI detected."
	# https://docs.travis-ci.com/user/environment-variables/
	ci="travis"
	branch="$TRAVIS_PULL_REQUEST_BRANCH"
	build="$TRAVIS_JOB_NUMBER"
	job="$TRAVIS_JOB_ID"
	sha="$TRAVIS_PULL_REQUEST_SHA"
	slug="$TRAVIS_REPO_SLUG"
elif [ "$DOCKER_REPO" ]; then
	echo "DockerHub detected."
	# https://docs.docker.com/docker-cloud/builds/advanced/
	ci="docker"
	branch="$SOURCE_BRANCH"
	sha="$SOURCE_COMMIT"
	slug="$DOCKER_REPO"
elif [ "$CI" = "true" ] && [ "$CI_NAME" = "codeship" ]; then
	echo "Codeship CI detected."
	# https://www.codeship.io/documentation/continuous-integration/set-environment-variables/
	ci="codeship"
	branch="$CI_BRANCH"
	build="$CI_BUILD_NUMBER"
	sha="$CI_COMMIT_ID"
elif [ "$CI" = "true" ] && [ "$CIRCLECI" = "true" ]; then
	echo "CircleCI detected."
	# https://circleci.com/docs/environment-variables
	ci="circleci"
	branch="$CIRCLE_BRANCH"
	build="$CIRCLE_BUILD_NUM"
	job="$CIRCLE_NODE_INDEX"
	sha="$CIRCLE_SHA1"
	if [ "$CIRCLE_PROJECT_REPONAME" ]; then
		slug="$CIRCLE_PROJECT_USERNAME/$CIRCLE_PROJECT_REPONAME"
	else
		# git@github.com:owner/repo.git
		slug="${CIRCLE_REPOSITORY_URL##*:}"
		# owner/repo.git
		slug="${slug%%.git}"
	fi
elif [ "$CIRRUS_CI" ]; then
	echo "Cirrus CI detected."
	# https://cirrus-ci.org/guide/writing-tasks/#environment-variables
	ci="cirrusci"
	branch="$CIRRUS_BRANCH"
	sha="$CIRRUS_CHANGE_IN_REPO"
	slug="$CIRRUS_REPO_FULL_NAME"
elif [ "$TEAMCITY_VERSION" ]; then
	echo "TeamCity CI detected."
	# https://confluence.jetbrains.com/display/TCD10/Predefined+Build+Parameters
	ci="teamcity"
	branch="$BRANCH_NAME"
	sha="$BUILD_VCS_NUMBER"
elif [ "$WERCKER_MAIN_PIPELINE_STARTED" ]; then
	echo "Wercker CI detected."
	# https://devcenter.wercker.com/administration/environment-variables/available-env-vars/
	ci="wercker"
	branch="$WERCKER_GIT_BRANCH"
	sha="$WERCKER_GIT_COMMIT"
	build="$WERCKER_MAIN_PIPELINE_STARTED"
	slug="$WERCKER_GIT_OWNER/$WERCKER_GIT_REPOSITORY"
elif [ "$CI" = "true" ] && [ "$SEMAPHORE" = "true" ]; then
	echo "Semaphore CI detected."
	# https://semaphoreapp.com/docs/available-environment-variables.html
	ci="semaphore"
	branch="$BRANCH_NAME"
	build="$SEMAPHORE_BUILD_NUMBER"
	job="$SEMAPHORE_CURRENT_THREAD"
	sha="$REVISION"
	slug="$SEMAPHORE_REPO_SLUG"
elif [ "$CI" = "true" ] && [ "$BUILDKITE" = "true" ]; then
	echo "Buildkite CI detected."
	# https://buildkite.com/docs/guides/environment-variables
	ci="buildkite"
	branch="$BUILDKITE_BRANCH"
	build="$BUILDKITE_BUILD_NUMBER"
	job="$BUILDKITE_JOB_ID"
	sha="$BUILDKITE_COMMIT"
	slug="$BUILDKITE_PROJECT_SLUG"
elif [ "$CI" = "drone" ] || [ "$DRONE" = "true" ]; then
	echo "Drone CI detected."
	# http://docs.drone.io/env.html
	# drone commits are not full shas
	ci="drone.io"
	branch="$DRONE_SOURCE_BRANCH"
	build="$DRONE_BUILD_NUMBER"
	job="$DRONE_JOB_NUMBER"
elif [ "$HEROKU_TEST_RUN_BRANCH" ]; then
	echo "Heroku CI detected."
	# https://devcenter.heroku.com/articles/heroku-ci#environment-variables
	ci="heroku"
	branch="$HEROKU_TEST_RUN_BRANCH"
	build="$HEROKU_TEST_RUN_ID"
	sha="$HEROKU_TEST_RUN_COMMIT_VERSION"
	slug="$GITHUB_SLUG"
elif [ "$DEPLOY_PRIME_URL" ]; then
	echo "Netlify CI detected."
	# https://www.netlify.com/docs/continuous-deployment/#environment-variables
	ci="netlify"
	branch="$HEAD"
	build="$BUILD_ID"
	sha="$COMMIT_REF"
	slug=$(echo "$REPOSITORY_URL" | cut -d / -f 4,5)
elif [ "$CODEBUILD_BUILD_ID" ]; then
	echo "AWS CodeBuild detected."
	# https://docs.aws.amazon.com/codebuild/latest/userguide/build-env-ref-env-vars.html
	ci="aws_codebuild"
	branch=$(echo "$CODEBUILD_WEBHOOK_HEAD_REF" | sed -e 's/^refs\/heads\///')
	build="$CODEBUILD_BUILD_ID"
	job="$CODEBUILD_SOURCE_VERSION"
	sha="$CODEBUILD_RESOLVED_SOURCE_VERSION"
	# slug=$(echo "$CODEBUILD_SOURCE_REPO_URL" | cut -d / -f 4,5)
elif [ "$SYSTEM_TEAMFOUNDATIONSERVERURI" ]; then
	echo "Azure Pipelines detected."
	# https://docs.microsoft.com/en-us/azure/devops/pipelines/build/variables?view=vsts
	ci="azure_pipelines"
	build="$BUILD_BUILDNUMBER"
	job="$BUILD_BUILDID"
	if [ "$SYSTEM_PULLREQUEST_SOURCEBRANCH" ]; then
		branch="$SYSTEM_PULLREQUEST_SOURCEBRANCH"
	else
		branch="$BUILD_SOURCEBRANCHNAME"
	fi
	if [ "$SYSTEM_PULLREQUEST_SOURCECOMMITID" ]; then
		sha="$SYSTEM_PULLREQUEST_SOURCECOMMITID"
	else
		sha="$BUILD_SOURCEVERSION"
	fi
elif [ "$GITHUB_ACTION" ] || [ "$GITHUB_WORKFLOW" ]; then
	echo "GitHub Actions CI detected."
	# https://help.github.com/en/articles/virtual-environments-for-github-actions#default-environment-variables
	ci="github_actions"
	branch=$(echo "$GITHUB_REF" | sed -e 's/^refs\/heads\///')
	sha="$GITHUB_SHA"
	slug="$GITHUB_REPOSITORY"
else
	echo "CI system not identified."
	exit 0
fi

# catchall for missing values
# find branch from git command
if [ -z "$branch" ]; then
	if [ "$GIT_BRANCH" ]; then
		branch="$GIT_BRANCH"
	else
		branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo "no-git")
	fi
fi

# find commit from git command
if [ -z "$sha" ]; then
	# merge commit -> actual commit
	if [ -n "$pr" ] && [ "$pr" != false ]; then
		mc=$(git show --no-patch --format="%P" 2>/dev/null || echo "")
	fi
	if [[ "$mc" =~ ^[a-z0-9]{40}[[:space:]][a-z0-9]{40}$ ]]; then
		echo "Fixing merge commit SHA"
		sha=$(echo "$mc" | cut -d' ' -f2)
	elif [ "$GIT_COMMIT" ]; then
		sha="$GIT_COMMIT"
	elif [ -z "$sha" ]; then
		sha=$(git log -1 --format="%H" 2>/dev/null || echo "")
	fi
fi

# find slug from git command
if [ -z "$slug" ]; then
	if [ -z "$remote_addr" ]; then
		remote_addr=$(git config --get remote.origin.url || echo "")
	fi
	if [ "$remote_addr" ]; then
		if echo "$remote_addr" | grep -q "//"; then
			# https
			slug=$(echo "$remote_addr" | cut -d / -f 4,5 | sed -e 's/\.git$//')
		else
			# ssh
			slug=$(echo "$remote_addr" | cut -d : -f 2 | sed -e 's/\.git$//')
		fi
	fi
	if [ "$slug" = "/" ]; then
		slug=""
	fi
fi

# if tag is not supplied, set it to the sha
if [ -z "$tag" ]; then
	tag="$sha"
fi

# get org and repo from slug
org=$(echo "$slug" | cut -d / -f 1)
repo=$(echo "$slug" | cut -d / -f 2)

# if -a is not passed, default to first app definition in peek.yml file
if [ -z "$app" ]; then
	app=$(cat peek.y*l | grep -E ":[ ]{0,}$" | head -n 1 | sed 's/://' | xargs)
	# otherwise fallback to 'main'
	if [ -z "$app" ] || [ "$app" = "services" ]; then
		app="main"
	fi
else
	app_definition=$(cat peek.y*l | grep "$app")
	if [ -z "$app_definition" ]; then
		echo "Warning: You passed '-a $app', but '$app' does not exist in your peek.yml file."
	fi
fi

# parse peek.yml config file
eval $(parse_yaml peek.y*l)
if [ "$peek_version" ]; then
	safeapp=$(echo $app | sed -e 's/-/_/g')
	static_build_path=$(eval "echo \$peek_${safeapp}_path" | xargs | sed 's/^\///')
else
	static_build_path=$(cat peek.y*l | grep staticBuildPath | tail -n 1 | cut -d : -f 2 | xargs | sed 's/^\///')
fi

# URL endpoint
url="https://$host/api/v1/peek"


echo ""
echo "app:     $app"
echo "branch:  $branch"
echo "ci:      $ci"
echo "org:     $org"
echo "repo:    $repo"
echo "sha:     $sha"
echo ""

if [ "$static_build_path" ]; then
	echo "Static build detected."

	# heroku ci changes file permissions, set them back
	if [ "$ci" = "heroku" ]; then
		cp -R $static_build_path "$static_build_path-copy"
		chmod -R 755 "$static_build_path-copy"
		static_build_path="$static_build_path-copy"
	fi

	# zip up static assets
	cd $static_build_path
	tar -czf ../artifacts.tar.gz .
	cd ..
fi

function wait_for_peek {
	timeout=$((`date +%s` + 300))
	echo "Waiting for preview to become available..."
	while true; do
		sleep 3
		echo "."
		res=$(curl -s "$url/$1")
		if [ "$res" == "true" ]; then
			break
		elif [ $(date +%s) -gt $timeout ]; then
			echo -e "\nTimed out waiting for preview to be ready..."
			break
		fi
	done
}

# try to contact FeaturePeek API 3 times
for i in {1..3}; do
	if [ "$static_build_path" ]; then
		# form/multipart for zipped static assets
		res=$(curl -i \
			-H "Accept: application/json" \
			-F "artifacts=@artifacts.tar.gz" \
			-F "app=$app" \
			-F "branch=$branch" \
			-F "build=$build" \
			-F "job=$job" \
			-F "org=$org" \
			-F "repo=$repo" \
			-F "ci=$ci" \
			-F "sha=$sha" \
			$url)
	elif [ "$AWS_ACCOUNT_ID" ]; then
		echo "Amazon ECR detected."

		# defaults
		region=""
		if [ "$AWS_DEFAULT_REGION" ]; then
			region="$AWS_DEFAULT_REGION"
		elif [ "$AWS_REGION" ]; then
			region="$AWS_REGION"
		fi

		if [ "$registry_image_path" ]; then
			echo "Registry image path (-p) passed in directly."
		elif [ "$registry" ] && [ "$image" ]; then
			echo "Registry (-r) and image (-i) passed in directly."
			registry_image_path="$registry/$image:$tag"
		else
			echo "Registry image path composed from environment variables."
			registry_image_path="$AWS_ACCOUNT_ID.dkr.ecr.$region.amazonaws.com/$AWS_RESOURCE_NAME_PREFIX:$tag"
		fi
		echo "Registry image path: $registry_image_path"

		res=$(curl -i $url \
			-H "Content-Type: application/json" \
			-H "Accept: application/json" \
			-d @- <<-EOF
				{
					"registry_image_path": "$registry_image_path",
					"aws_account": "$AWS_ACCOUNT_ID",
					"aws_access_key": "$AWS_ACCESS_KEY_ID",
					"aws_secret_access_key": "$AWS_SECRET_ACCESS_KEY",
					"aws_region": "$region",
					"app": "$app", "branch": "$branch", "org": "$org", "repo": "$repo", "ci": "$ci", "sha": "$sha",
					"env_vars": "$env_vars"
				}
			EOF
		)
	elif [ "$GOOGLE_PROJECT_ID" ]; then
		echo "Google Cloud Registry detected."

		# defaults
		if [ -z "$registry" ]; then registry="gcr.io"; fi

		if [ "$GCLOUD_SERVICE_KEY" ]; then
			service_key="$GCLOUD_SERVICE_KEY"
		elif [ "$GOOGLE_APPLICATION_CREDENTIALS" ]; then
			service_key="$GOOGLE_APPLICATION_CREDENTIALS"
		else
			echo "GCloud Service Key not found. Please ensure you have all the required environment variables."
			exit 0
		fi

		if [ "${service_key::1}" = "{" ]; then
			service_key=$(echo "$service_key" | base64)
		fi

		if [ "$registry_image_path" ]; then
			echo "Registry image path (-p) passed in directly."
		else
			registry_image_path="$registry/$GOOGLE_PROJECT_ID/$image:$tag"
		fi
		echo "Registry image path: $registry_image_path"

		res=$(curl -i $url \
			-H "Content-Type: application/json" \
			-H "Accept: application/json" \
			-d @- <<-EOF
				{
					"registry_image_path": "$registry_image_path",
					"gcp_key": "$service_key",
					"google_compute_zone": "$GOOGLE_COMPUTE_ZONE",
					"google_project_id": "$GOOGLE_PROJECT_ID",
					"app": "$app", "branch": "$branch", "org": "$org", "repo": "$repo", "ci": "$ci", "sha": "$sha",
					"env_vars": "$env_vars"
				}
			EOF
		)
	elif [ "$ACR_REGISTRY_ID" ]; then
		echo "Azure Container Registry detected."

		if [ "$registry_image_path" ]; then
			echo "Registry image path (-p) passed in directly."
		else
			echo "You must pass in the registry image path (-p)."
			exit 0
		fi
		echo "Registry image path: $registry_image_path"

		# Azure expects either a combination of (acr_user_name + acr_password) or (acr_sp_id + acr_sp_passwd)
		# so set key names and values accordingly

		if [ "$ACR_USER_NAME" ] && [ "$ACR_PASSWORD" ]; then
			acr_user_key="acr_user_name"
			acr_pass_key="acr_password"
			acr_user_value="$ACR_USER_NAME"
			acr_pass_value="$ACR_PASSWORD"
		elif [ "$ACR_SP_ID" ] && [ "$ACR_SP_PASSWD" ]; then
			acr_user_key="acr_sp_id"
			acr_pass_key="acr_sp_passwd"
			acr_user_value="$ACR_SP_ID"
			acr_pass_value="$ACR_SP_PASSWD"
		else
			echo "You are missing the environment variables that FeaturePeek requires for Azure Container Registry."
			echo "Please consult the documentation at https://docs.featurepeek.com/azure-container-registry"
			exit 0
		fi

		res=$(curl -i $url -H "Content-Type: application/json" \
			-d @- <<-EOF
				{
					"registry_image_path": "$registry_image_path",
					"acr_registry_id": "$ACR_REGISTRY_ID",
					"$acr_user_key": "$acr_user_value",
					"$acr_pass_key": "$acr_pass_value",
					"app": "$app", "branch": "$branch", "org": "$org", "repo": "$repo", "ci": "$ci", "sha": "$sha",
					"env_vars": "$env_vars"
				}
			EOF
		)
	elif [ "$GITHUB_TOKEN" ]; then
		echo "GitHub Packages Docker Registry detected."
		poll_for_peek="true"

		# defaults
		if [ -z "$registry" ]; then registry="docker.pkg.github.com"; fi

		if [ "$registry_image_path" ]; then
			echo "Registry image path (-p) passed in directly."
		else
			echo "Image (-i) passed in directly."
			registry_image_path="$registry/$image:$tag"
		fi
		echo "Registry image path: $registry_image_path"

		res=$(curl -i $url \
			-H "Content-Type: application/json" \
			-H "Accept: application/json" \
			-d @- <<-EOF
				{
					"registry_image_path": "$registry_image_path",
					"github_token": "$GITHUB_TOKEN",
					"app": "$app", "branch": "$branch", "org": "$org", "repo": "$repo", "ci": "$ci", "sha": "$sha",
					"env_vars": "$env_vars"
				}
			EOF
		)
	elif [ "$DOCKER_LOGIN" ] || [ "$DOCKER_USERNAME" ]; then
		echo "DockerHub detected."

		# defaults
		if [ -z "$registry" ]; then registry="docker.io"; fi

		if [ "$DOCKER_LOGIN" ]; then
			docker_username="$DOCKER_LOGIN"
		elif [ "$DOCKER_USERNAME" ]; then
			docker_username="$DOCKER_USERNAME"
		else
			echo "Docker username not found. Please ensure you have all the required environment variables."
			exit 0
		fi

		if [ "$registry_image_path" ]; then
			echo "Registry image path (-p) passed in directly."
		else
			echo "Image (-i) passed in directly."
			registry_image_path="$registry/$image:$tag"
		fi
		echo "Registry image path: $registry_image_path"

		res=$(curl -i $url \
			-H "Content-Type: application/json" \
			-H "Accept: application/json" \
			-d @- <<-EOF
				{
					"registry_image_path": "$(echo "$registry_image_path" | cut -d / -f 2,3)",
					"dockerhub_username": "$docker_username",
					"dockerhub_password": "$DOCKER_PASSWORD",
					"dockerhub_registry": "$(echo "$registry_image_path" | cut -d / -f 1)",
					"app": "$app", "branch": "$branch", "org": "$org", "repo": "$repo", "ci": "$ci", "sha": "$sha",
					"env_vars": "$env_vars"
				}
			EOF
		)
	else
		echo -e "\nContainer registry not identified."
		exit 0
	fi

	# still within the for loop here
	if [ "$res" ]; then
		status=$(echo "$res" | head -1 | cut -d' ' -f2)
		ret=$(echo "$res" | tail -1)
		vals=$(echo "$ret" | tr -d '{}"')
		ping_id=$(echo "$vals" | awk -v RS=',' -F: '/^ping_id/ {print $2}')
		message=$(echo "$vals" | awk -v RS=',' -F: '/^message/ {print $2$3}')

		# if status is 5xx...
		if [ "${status:0:1}" == "5" ]; then
			echo "Trying again in 15s..."
			sleep 15
		elif [ "${status:0:1}" == "4" ]; then
			break
		else
			if [ "$poll_for_peek" ]; then
				wait_for_peek $ping_id
			fi
			echo -e "\n$message"
			exit 0
		fi
	else
		echo "Empty response. Trying again in 15s..."
		sleep 15
	fi
# end for loop
done

echo "Failed to send ping to FeaturePeek API."
exit 0
