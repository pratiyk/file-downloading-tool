#!/bin/bash

echo "Enter the URL: "
read URL

echo "$URL" > webpage_link.txt

curl -s "$URL" > webpage.html

grep -o -E 'https?://[^"]+\.(jpg|jpeg|png|apng|avif|svg|webp)' webpage.html > images.txt
line=$(wc -l < images.txt)
echo "There are $line images in the link which is provided."

grep -o -E 'https?://[^"]+\.(mp4|mkv|gif|mov|avi|flv)' webpage.html > videos.txt
line_1=$(wc -l < videos.txt)
echo "There are $line_1 videos in the link "

grep -o -E 'https?://[^"]+\.(mp3|ogg|wav)' webpage.html > audios.txt
line_2=$(wc -l < audios.txt)
echo "There are $line_2 audios in the link "

# Function to download files based on type
download_files() {
    file_type=$1
    file_list=$2

    case $file_type in
        images)
            wget -i $file_list
            ;;
        videos)
            wget -i $file_list
            ;;
        audios)
            wget -i $file_list
            ;;
        *)
            echo "Invalid file type"
            ;;
    esac
}

# Prompt user for download choice
echo "Choose what to download:"
echo "1. Images"
echo "2. Videos"
echo "3. Audios"
read choice

case $choice in
    1)
        download_files "images" "images.txt"
        ;;
    2)
        download_files "videos" "videos.txt"
        ;;
    3)
        download_files "audios" "audios.txt"
        ;;
    *)
        echo "Invalid choice"
        ;;
esac
