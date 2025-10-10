# Run from app/build/ directory
VERSION=`grep "\"version\"" ../../app/package.json | sed -e "s|^.*\"version\": \"||" -e "s|\",$||"`
echo Building version $VERSION
perl -p -i \
  -e "s|production = false|production = true|;" \
  -e "s|appVersion: string = '.*';$|appVersion: string = '$VERSION';|;" \
  ../logic/build.ts
perl -p -i \
  -e "s|\"version\": \".*\"|\"version\": \"$VERSION\"|;" \
  ../../e2/package.json

perl -e 'print "IOS_PROVISION_PROFILE_NAME=Mustang Mail\n"' >> $ENV{"GITHUB_ENV"}
perl -e 'print "IOS_TEAM_ID=2QD8MW9GBW\n"' >> $ENV{"GITHUB_ENV"}
