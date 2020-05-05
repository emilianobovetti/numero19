#!/bin/bash -eu

if [ -z "$NETLIFY_AUTH_TOKEN" ]; then
    echo "NETLIFY_AUTH_TOKEN not setted"
    echo "You may want to visit https://app.netlify.com/user/applications#personal-access-tokens"
    exit 1
fi

if [ -z "$NETLIFY_SITE_ID" ]; then
    echo "NETLIFY_SITE_ID not setted"
    echo "You may want to visit https://app.netlify.com/sites/<your site>/settings/general"
    exit 1
fi

if [ ! -f node_modules/.bin/netlify ]; then
    yarn
fi

if [ "$TRAVIS_BRANCH" = "master" ]; then
    npx netlify deploy \
        --message="$TRAVIS_BRANCH@$(git rev-parse --short HEAD)" \
        --auth="$NETLIFY_AUTH_TOKEN" \
        --site="$NETLIFY_SITE_ID" \
        --dir=public \
        --prod
else
    npx netlify deploy \
        --message="$TRAVIS_BRANCH@$(git rev-parse --short HEAD)" \
        --auth="$NETLIFY_AUTH_TOKEN" \
        --site="$NETLIFY_SITE_ID" \
        --dir=public
fi
