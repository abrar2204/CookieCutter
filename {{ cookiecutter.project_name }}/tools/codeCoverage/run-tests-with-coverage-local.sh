#!/bin/bash -e

cd tools/codeCoverage || true
cd ../../

date=$(date '+%Y-%m-%dT%H%M%S')

dotnet tool install --global dotnet-reportgenerator-globaltool

dotnet build --configuration Release

dotnet test --configuration Release --no-restore --results-directory tmp/coverage/test-results/$date --collect:"XPlat Code Coverage" -- DataCollectionRunSettings.DataCollectors.DataCollector.Configuration.Format=json,opencover,cobertura -- DataCollectionRunSettings.DataCollectors.DataCollector.Configuration.ExcludeByFile="**/*Persistence/Migrations/**.cs,**/*Infrastructure/Connected Services/**/**.cs"

reportgenerator "-reports:tmp/coverage/test-results/$date/*/coverage.opencover.xml" "-targetdir:tmp/coverage/reports/$date" "-reporttypes:HtmlInline;Cobertura;Badges;Latex;" -verbosity:Info

start tmp/coverage/reports/$date/index.html
