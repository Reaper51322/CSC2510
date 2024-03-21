if [ ! -d "system_info" ]; then
    mkdir system_info
fi

INFO_FILE="system_info/system_info.txt"

{
    echo "System information has been gathered. Here’s the summary:"
    echo "Current system date and time: $(date +'%m/%d/%Y %T %Z')"
    echo "Current user: $(whoami)"
    echo "Current working directory: $(pwd)"
    echo "System usage:"
    top -bn1 | head -n5
    echo "Disk usage:"
    df -h
} > "$INFO_FILE"

cat "$INFO_FILE"
