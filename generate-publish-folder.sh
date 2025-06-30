#!/bin/bash

# Go one level up
cd ..

# Iterate through all subdirectories
for dir in */; do
    if [ -d "$dir" ]; then
        echo "Processing directory: $dir"

        cd "$dir"

        if [ -d ".git" ]; then
            echo "Running git pull in $dir..."
            git pull
        else
            echo "Not a git repository: $dir, skipping git pull."
        fi

        csproj_file=$(find . -maxdepth 1 -name "*.csproj")

        if [ ! -z "$csproj_file" ]; then
            echo "Publishing project in $dir ..."
            dotnet publish "$csproj_file" -o "./publish"
        else
            echo "No .csproj file found in $dir, skipping publish."
        fi

        cd ..
    fi
done
