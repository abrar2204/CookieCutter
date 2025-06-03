#!/bin/bash -e

cd tools/sonarQube || true
cd ../../

if [ -z "$SONAR_TOKEN" ]; then
    echo "Error: SONAR_TOKEN environment variable is not set"
    echo "Please set the SONAR_TOKEN environment variable as described in "Local machine setup" guide"
    read -n 1 -s
    exit 1
fi

# Set SonarQube host URL
SONAR_HOST="https://sonarqube.shared.int.spaceneobank.com/"

# Determine OS username
if [[ -n "$USER" ]]; then
    USERNAME="$USER"
elif [[ -n "$USERNAME" ]]; then
    USERNAME="$USERNAME"
else
    USERNAME="Unknown"
fi

reponame=$(basename -s .git `git config --get remote.origin.url`)

echo $USERNAME
echo "Reponame: $reponame"

rm -rf tmp
rm -rf .sonarqube
dotnet clean -c Debug -v minimal
dotnet clean -c Release -v minimal

# Install dotnet-sonarscaner tool
if [ ! "$( dotnet tool list -g | grep dotnet-sonarscanner )" ]; then
  echo "dotnet-sonarscanner package is not installed, installing..."
  dotnet tool update -g dotnet-sonarscanner
fi

dotnet sonarscanner begin \
    -k:"${reponame}" \
    -d:sonar.branch.name="local-${USERNAME}" \
    -d:sonar.qualitygate.wait=true \
    -d:sonar.host.url="${SONAR_HOST}" \
    -d:sonar.token="${SONAR_TOKEN}" \
    -d:sonar.cs.opencover.reportsPaths="tmp/coverage/test-results/**/coverage.opencover.xml" \
    -d:sonar.cs.xunit.reportsPaths="$reponame.ComponentTests/TestResults/test_result.xml,$reponame.UnitTests/TestResults/test_result.xml,$reponame.ArchitectureTests/TestResults/test_result.xml" \
    -d:sonar.exclusions="**/*.sql,**/Migrations/*.cs,**/Connected Services/**/*.cs" \
	-d:sonar.newCode.referenceBranch="master"

dotnet build --configuration Release -v minimal
dotnet test  --configuration Release --no-restore --results-directory $(pwd)/tmp/coverage/test-results --collect:"XPlat Code Coverage" --logger:"xunit;LogFilePath=TestResults/test_result.xml" --logger "GitHubActions;summary.includePassedTests=true;summary.includeSkippedTests=true" -- DataCollectionRunSettings.DataCollectors.DataCollector.Configuration.Format=json,opencover,cobertura -- DataCollectionRunSettings.DataCollectors.DataCollector.Configuration.ExcludeByFile="**/*Persistence/Migrations/**.cs,**/*Infrastructure/Connected Services/**/**.cs"
dotnet sonarscanner end -d:sonar.token=$SONAR_TOKEN

rm -rf tmp
rm -rf .sonarqube

# Construct the SonarQube dashboard URL for the current project and user
SONAR_DASHBOARD_URL="${SONAR_HOST}dashboard?branch=local-${USERNAME}&id=${reponame}"

echo -e "\nOpening SonarQube dashboard in browser: $SONAR_DASHBOARD_URL"

# Open URL based on OS
if [[ "$OSTYPE" == "darwin"* ]]; then
    open "$SONAR_DASHBOARD_URL"  # macOS
elif [[ "$OSTYPE" == "cygwin" || "$OSTYPE" == "msys" || "$OSTYPE" == "win32" ]]; then
    start "$SONAR_DASHBOARD_URL"  # Windows (Git Bash, Cygwin, or WSL)
else
    xdg-open "$SONAR_DASHBOARD_URL"  # Linux
fi

read -n 1 -s
exit 0
