#!/bin/sh
set -e

update_repo() {
    if [ -d "/app/.git" ]; then
        cd /app
        git fetch origin

        LOCAL=$(git rev-parse HEAD)
        REMOTE=$(git rev-parse origin/main)

        if [ "$LOCAL" != "$REMOTE" ]; then
            echo "new repo updates found: pulling..."
            git reset --hard origin/main
            yarn install --frozen-lockfile
            kill -HUP 1
        fi
    else
        git clone --depth=1 "$GIT_REPO" /app
        cd /app
        yarn install
    fi
}

echo "starting app..."

if [ "$USE_LOCAL" = "true" ]; then
    echo "running container locally..."
    cd /app
    yarn install
    exec yarn run dev &
    while true; do
        sleep 30
    done
else
    echo "running container with remote repo..."
    update_repo
    exec yarn run dev &
    while true; do
        # add webhook instead in future work
        sleep 30
        update_repo
    done
fi
