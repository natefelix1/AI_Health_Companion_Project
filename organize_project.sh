#!/bin/bash

# Create a backup of the original project
echo "Creating backup of original project..."
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
mkdir -p "/Users/personal/Desktop/AI_Health_Companion_Project_Backup_$TIMESTAMP"
cp -R "/Users/personal/Desktop/AI_Health_Companion_Project" "/Users/personal/Desktop/AI_Health_Companion_Project_Backup_$TIMESTAMP"

# Move the organized project structure to the main project location
echo "Moving organized project structure..."
rm -rf "/Users/personal/Desktop/AI_Health_Companion_Project_NEW"
mkdir -p "/Users/personal/Desktop/AI_Health_Companion_Project_NEW"
cp -R "/Users/personal/Desktop/AI_Health_Companion_Project/Organized_VitAl/"* "/Users/personal/Desktop/AI_Health_Companion_Project_NEW"

echo "Backup created at: /Users/personal/Desktop/AI_Health_Companion_Project_Backup_$TIMESTAMP"
echo "New organized project is at: /Users/personal/Desktop/AI_Health_Companion_Project_NEW"
echo ""
echo "To complete the process:"
echo "1. Verify that the new project structure works correctly by opening VitAl.xcodeproj"
echo "2. Once verified, you can rename AI_Health_Companion_Project_NEW to your desired folder name"
