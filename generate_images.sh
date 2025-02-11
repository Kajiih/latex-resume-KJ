#!/bin/sh

# Define the images path
IMAGES_PATH="images"

# Create images directory if it doesn't exist
mkdir -p "$IMAGES_PATH"

# Clear out old images
rm -rf "$IMAGES_PATH"/*

# Loop through all PDF files in the current directory
for PDF_FILE in *.pdf; do
    # Skip non-PDF files (just in case)
    if [[ ! "$PDF_FILE" =~ \.pdf$ ]]; then
        continue
    fi

    # Get the base name (without extension) of the PDF file
    BASE_NAME=$(basename "$PDF_FILE" .pdf)

    # Convert the PDF to PNG images with ImageMagick
    if magick -density 300 "$PDF_FILE" -background white -alpha remove -quality 90 "$IMAGES_PATH/$BASE_NAME.png"; then
        echo "$PDF_FILE successfully converted to PNG images."
    else
        echo "Failed to convert $PDF_FILE to PNG." >&2
        exit 1
    fi

    # Copy the PDF to the images folder
    if cp "$PDF_FILE" "$IMAGES_PATH/$PDF_FILE"; then
        echo "$PDF_FILE copied successfully."
    else
        echo "Failed to copy $PDF_FILE." >&2
        exit 1
    fi
done

# Stage changes in git
if git add "$IMAGES_PATH/"; then
    echo "Images staged for git."
else
    echo "Failed to stage images for git." >&2
    exit 1
fi
