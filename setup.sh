#!/bin/bash

################################################## variables ##################################################

DATABASE_FILE="api/db/database.sql" # Directory containing the SQL files
TABLE_DIR="api/db/table" # Directory containing the SQL files
OUTPUT_FILE="tmp/combined.sql" # Output file

################################################## execution ##################################################

clear
rm -rf tmp
mkdir tmp

echo -e "################################################## database ##################################################" >> "$OUTPUT_FILE"
cat $DATABASE_FILE >> "$OUTPUT_FILE" # Clear the output file and create table
# Loop through all .sql files and append them to the output file
for file in "$TABLE_DIR"/*.table.sql; do
    echo -e "\n################################################## $file ##################################################" >> "$OUTPUT_FILE"
    cat "$file" >> "$OUTPUT_FILE"
done

# docker compose up --detach
# docker cp tmp/combined.sql mysql_local:tmp/combined.sql 
# docker exec -it mysql_local /bin/bash
# mysql -u root -p'P@ssw0rd' < /tmp/combined.sql 

