#!/bin/sh

# Define paths and filenames
IMAGES_PATH="images"
FINAL_NAME_FRENCH="resume-fr"
FINAL_NAME_ENGLISH="resume-en"

# Create images directory if it doesn't exist
mkdir -p "$IMAGES_PATH"

# Clear out old images
rm -rf "$IMAGES_PATH"/*

# Convert French PDF to PNG images with ImageMagick
if magick -density 300 "$FINAL_NAME_FRENCH.pdf" -background white -alpha remove -quality 90 "$IMAGES_PATH/$FINAL_NAME_FRENCH.png"; then
    echo "French PDF successfully converted to PNG images."
else
    echo "Failed to convert French PDF to PNG." >&2
    exit 1
fi

# Convert English PDF to PNG images with ImageMagick
if magick -density 300 "$FINAL_NAME_ENGLISH.pdf" -background white -alpha remove -quality 90 "$IMAGES_PATH/$FINAL_NAME_ENGLISH.png"; then
    echo "English PDF successfully converted to PNG images."
else
    echo "Failed to convert English PDF to PNG." >&2
    exit 1
fi

# Copy the French PDF to the images folder
if cp "$FINAL_NAME_FRENCH.pdf" "$IMAGES_PATH/$FINAL_NAME_FRENCH.pdf"; then
    echo "French PDF copied successfully."
else
    echo "Failed to copy French PDF." >&2
    exit 1
fi

# Copy the English PDF to the images folder
if cp "$FINAL_NAME_ENGLISH.pdf" "$IMAGES_PATH/$FINAL_NAME_ENGLISH.pdf"; then
    echo "English PDF copied successfully."
else
    echo "Failed to copy English PDF." >&2
    exit 1
fi

# Stage changes in git
if git add "$IMAGES_PATH/"; then
    echo "Images staged for git."
else
    echo "Failed to stage images for git." >&2
    exit 1
fi
