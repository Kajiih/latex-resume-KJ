#!/bin/sh

# Define paths and filenames
IMAGES_PATH="images"
FINAL_NAME="resume_latex_kj"
PDF_FILE="main.pdf"

# Create images directory if it doesn't exist
mkdir -p "$IMAGES_PATH"

# Clear out old images
rm -rf "$IMAGES_PATH"/*

# Convert PDF to PNG images with ImageMagick
if magick -density 300 "$PDF_FILE" -background white -alpha remove -quality 90 "$IMAGES_PATH/$FINAL_NAME.png"; then
    echo "PDF successfully converted to PNG images."
else
    echo "Failed to convert PDF to PNG." >&2
    exit 1
fi

# Copy the PDF to the images folder
if cp main.pdf "$IMAGES_PATH/$FINAL_NAME.pdf"; then
    echo "PDF copied successfully."
else
    echo "Failed to copy PDF." >&2
    exit 1
fi

# Stage changes in git
if git add "$IMAGES_PATH/"; then
    echo "Images staged for git."
else
    echo "Failed to stage images for git." >&2
    exit 1
fi
