#!/usr/bin/env bash

SOURCE_DIR="$1"
DEST_DIR="$2"
DRY_RUN=false

if [[ "$3" == "--dry-run" ]]; then
    DRY_RUN=true
fi

if [[ -z "$SOURCE_DIR" || -z "$DEST_DIR" ]]; then
    echo "Error: Missing arguments."
    echo "Usage: $0 <source_directory> <destination_directory> [--dry-run]"
    exit 1
fi

if [[ ! -d "$SOURCE_DIR" ]]; then
    echo "Error: Source directory '$SOURCE_DIR' does not exist."
    exit 1
fi

if [[ "$DRY_RUN" == false ]]; then
    mkdir -p "$DEST_DIR"
fi

find "$SOURCE_DIR" -mindepth 2 -maxdepth 2 -type f -name "*.toml" | while IFS= read -r toml_path; do
    raw_toml_filename=$(basename "$toml_path")
    flavor_name="${raw_toml_filename%.toml}"
    target_folder="$DEST_DIR/${flavor_name}.yazi"
    
    parent_path=$(dirname "$toml_path")
    # Extract the base theme name from the directory (e.g., "latte")
    parent_theme=$(basename "$parent_path")
    
    # Strictly search for an XML file that contains the parent theme name.
    # -iname makes it case-insensitive so "latte" matches "Catppuccin Latte.xml"
    # head -n 1 ensures we safely capture the path even if spaces are involved.
    xml_path=$(find "$parent_path" -maxdepth 1 -type f -name "*.xml" -iname "*${parent_theme}*" | head -n 1)

    if [[ "$DRY_RUN" == true ]]; then
        echo "[DRY RUN] Would create folder: $target_folder"
        echo "[DRY RUN] Would copy: '$toml_path' -> '$target_folder/flavor.toml'"
        if [[ -n "$xml_path" ]]; then
            echo "[DRY RUN] Would copy: '$xml_path' -> '$target_folder/tmtheme.xml'"
        else
            echo "[DRY RUN] [WARNING] No exact matching XML found for '$parent_theme'."
        fi
        echo "---"
    else
        mkdir -p "$target_folder"
        cp "$toml_path" "$target_folder/flavor.toml"
        if [[ -n "$xml_path" ]]; then
            cp "$xml_path" "$target_folder/tmtheme.xml"
        fi
    fi
done
