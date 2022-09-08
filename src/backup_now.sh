#!/bin/bash

# Initially ran chmod +x backup.sh to make it executable.

source=$BACKUP_SOURCE # "./source_dir"
destination=$BACKUP_DESTINATION # "./destination_dir"


echo "Source: " $source
echo "Destination: " $destination


# Loop through the files in source directory
for file in $(find $source -printf "%P\n") ; do
    # If file in source directory exists in destination directory
    if [ -a $destination/$file ] ; then
        # If the file was modifiled, replace it
        if [ $source/$file -nt $destination/$file ] ; then
        echo "newer file detected, copying"
        scp -r $source/$file $destination/$file
        # If file exists, skip it
        else
        echo "file $file exists, skipping"
        fi
    # If the file does not exist, simply copy the file
    else
    echo $file " is being copied over to $destination"
    scp -r $source/$file $destination/$file
    fi # Close the if statement
done