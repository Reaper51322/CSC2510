move_files() {
    local source_dir="$1"
    local destination_dir="$2"
    local file="$3"
    
    if [ ! -d "$destination_dir" ]; then
        echo "Creating directory: $destination_dir"
        mkdir -p "$destination_dir"
    fi
    
    mv "$source_dir/$file" "$destination_dir/$file"
}

create_directories() {
    for dir in "images" "documents" "pdfs" "executables" "data" "unknown"; do
        if [ ! -d "$dir" ]; then
            echo "Creating directory: $dir"
            mkdir "$dir"
        fi
    done
}

total_files_moved=0
total_bytes_transferred=0
declare -A category_files_moved
declare -A category_bytes_transferred

create_directories

for file in *; do
    if [ -f "$file" ]; then
        if [[ "$file" =~ \.jpg$|\.jpeg$|\.png$|\.gif$ ]]; then
            move_files "." "images" "$file"
            category="images"
        elif [[ "$file" =~ \.txt$|\.docx$|\.doc$|\.pages$|\.key$|\.pptx$|\.ppt$|\.odt$|\.md$ ]]; then
            move_files "." "documents" "$file"
            category="documents"
        elif [[ "$file" =~ \.pdf$ ]]; then
            move_files "." "pdfs" "$file"
            category="pdfs"
        elif [[ -x "$file" || "$file" =~ \.sh$|\.exe$ ]]; then
            move_files "." "executables" "$file"
            category="executables"
        elif [[ "$file" =~ \.csv$|\.xlsx$|\.json$ ]]; then
            move_files "." "data" "$file"
            category="data"
        else
            move_files "." "unknown" "$file"
            category="unknown"
        fi

        ((total_files_moved++))
        file_size=$(stat -c %s "$file")
        total_bytes_transferred=$((total_bytes_transferred + file_size))
        category_files_moved["$category"]=$((category_files_moved["$category"] + 1))
        category_bytes_transferred["$category"]=$((category_bytes_transferred["$category"] + file_size))
    fi
done

echo "Total files moved: $total_files_moved"
echo "Total bytes transferred: $total_bytes_transferred bytes"
if [ "$total_files_moved" -ne 0 ]; then
    echo "Average file size (bytes) for all files: $((total_bytes_transferred / total_files_moved))"
else
    echo "No files moved."
fi

for category in "${!category_files_moved[@]}"; do
    echo "Category: $category"
    echo "  Files moved: ${category_files_moved[$category]}"
    echo "  Bytes transferred: ${category_bytes_transferred[$category]} bytes"
    if [ "${category_files_moved[$category]}" -ne 0 ]; then
        echo "  Average file size (bytes): $((category_bytes_transferred[$category] / category_files_moved[$category]))"
    else
        echo "  No files moved in this category."
    fi
done
