#!/bin/bash

# Exit on any error
set -e

for dir in */; do
    if [[ -d "$dir" ]]; then
        cd "$dir"

        csproj_file=$(find . -maxdepth 1 -name "*.csproj" | head -n 1)

        if [[ -n "$csproj_file" ]]; then
            # Extract just the filename (no path)
            csproj_name=$(basename "$csproj_file")

            # Skip if the project file is Rackdog.csproj
            if [[ "$csproj_name" == "Rackdog.csproj" ]]; then
                echo "Skipping $dir (Rackdog.csproj)"
                cd ..
                continue
            fi

            echo "Processing $dir with $csproj_file"

            dotnet nuget locals all --clear
            dotnet add "$csproj_file" package rackdog.Rackdog
            dotnet build

            git pull
            git add .
            git commit -m "new rackdog nuget" || true
            git push || true
        fi

        cd ..
    fi
done
