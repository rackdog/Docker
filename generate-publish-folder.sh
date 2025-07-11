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
            csproj_filename=$(basename "$csproj_file")
            if [ "$csproj_filename" == "Rackdog.csproj" ]; then
                echo "Skipping publishing for Rackdog.csproj in $dir."
            else
                echo "Publishing project in $dir ..."
                dotnet nuget locals all --clear
                dotnet add package rackdog.Rackdog
                rm -r ./publish
                dotnet publish "$csproj_file" -o "./publish"
            fi
        else
            echo "No .csproj file found in $dir, skipping publish."
        fi

        cd ..
    fi
done
