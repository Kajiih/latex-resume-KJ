#!/bin/sh

# Define the images and output paths
IMAGES_PATH="images"
TEXT_PATH="text"

# Create necessary directories if they don't exist
mkdir -p "$IMAGES_PATH" "$TEXT_PATH"

# Clear out old files in the directories
rm -rf "$IMAGES_PATH"/* "$TEXT_PATH"/*

# Loop through all PDF files in the current directory
for PDF_FILE in *.pdf; do
    # Skip non-PDF files (just in case)
    if [[ ! "$PDF_FILE" =~ \.pdf$ ]]; then
        continue
    fi

    # Get the base name (without extension) of the PDF file
    BASE_NAME=$(basename "$PDF_FILE" .pdf)

    # Convert PDF to PNG images with ImageMagick
    if magick -density 300 "$PDF_FILE" -background white -alpha remove -quality 90 "$IMAGES_PATH/$BASE_NAME.png"; then
        echo "$PDF_FILE successfully converted to PNG images."
    else
        echo "Failed to convert $PDF_FILE to PNG." >&2
        exit 1
    fi

    # Copy the PDF to the images folder
    if cp "$PDF_FILE" "$IMAGES_PATH/$PDF_FILE"; then
        echo "$PDF_FILE copied to images folder."
    else
        echo "Failed to copy $PDF_FILE to images folder." >&2
        exit 1
    fi

    # Convert PDF to plain text using pdftotext
    if pdftotext "$PDF_FILE" "$TEXT_PATH/$BASE_NAME.txt"; then
        echo "$PDF_FILE successfully converted to plain text."
    else
        echo "Failed to convert $PDF_FILE to text." >&2
        exit 1
    fi
done

# Stage changes in git
if git add "$IMAGES_PATH/" "$TEXT_PATH/"; then
    echo "Files staged for git."
else
    echo "Failed to stage files for git." >&2
    exit 1
fi
