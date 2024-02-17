#!/bin/bash
# Bash Script by Ammar Ahmed Siddiqui

# Tabe must be created with following command prior running of this script.
# CREATE TABLE access_log(timestamp TIMESTAMP, latitude float, longitude float, visitor_id char(37));

echo "-- ETL Bash Process started..."

# get data from web-server-acess-log.txt.gz file

# perform necessary transformation if any

# Load the data to postGreSQL dattabase


# cp-access-log.sh
# This script downloads the file 'web-server-access-log.txt.gz'
# from "https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0250EN-SkillsNetwork/labs/Bash%20Scripting/ETL%20using%20shell%20scripting/".

# The script then extracts the .txt file using gunzip.


# Download the access log file

echo "Downloading access log file..."

wget "https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0250EN-SkillsNetwork/labs/Bash%20Scripting/ETL%20using%20shell%20scripting/web-server-access-log.txt.gz"
# Unzip the file to extract the .txt file.
gunzip -f web-server-access-log.txt.gz


# The .txt file contains the timestamp, latitude, longitude 
# and visitor id apart from other data.

echo "Extracting data..."

cut -d"#" -f1-4 web-server-access-log.txt > extracted-data.txt

echo "Data Extraction completed"
echo "Staging process: Required fields extracted and loaded into extracted-data.txt"


# Transforms the text delimeter from "#" to "," and saves to a csv file.
# Loads the data from the CSV file into the table 'access_log' in PostgreSQL database.

# Transform phase
echo "Transforming data"
# read the extracted data and replace the colons with commas.

tr "#" "," < extracted-data.txt > transformed_data.csv

echo "Transformation complete..."

# show details
echo "Showing content of transformed_Data.csv..."
cat transformed_data.csv

# loading data to database

# Load phase
echo "Loading data"

# Send the instructions to connect to 'template1' and
# copy the file to the table 'access_log' through command pipeline.

echo "\c template1;\COPY access_log  FROM '/home/project/transformed_data.csv' DELIMITERS ',' CSV HEADER;" | psql --username=postgres --host=localhost

# generating qurey to read from PostGreSQL Database
echo '\c template1; \\SELECT * from access_log;' | psql --username=postgres --host=localhost
# ending note
echo "-- ETL Bash Process Finished..."
