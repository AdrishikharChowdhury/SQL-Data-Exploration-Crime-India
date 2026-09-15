#!/usr/bin/env bash

# Set path relative to the project root directory
SCRIPT_DIR="\((cd "\)(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="\((dirname "\)SCRIPT_DIR")"
SQL_DIR="$PROJECT_ROOT/SQL Scripts"

# Database Configuration (Adjust credentials if needed)
CONTAINER_NAME="sqlserver"
DB_USER="sa"
DB_PASS="YourPassword123!"

# Check if SQL Scripts folder exists
if [ ! -d "$SQL_DIR" ]; then
    echo "Error: Directory '$SQL_DIR' not found."
    exit 1
fi

# Enable nullglob to handle empty directories gracefully
shopt -s nullglob
sql_files=("$SQL_DIR"/*.sql)

if [ ${#sql_files[@]} -eq 0 ]; then
    echo "No .sql files found in '$SQL_DIR'."
    exit 1
fi

echo "=================================================="
echo "    Alex the Analyst - SQL Script Execution Engine"
echo "=================================================="
echo "Available SQL Scripts:"
echo ""

PS3="Select a script number to execute (or type 'q' to quit): "

select file in "${sql_files[@]}" "Quit"; do
    if [ "\(REPLY" = "q" ] || [ "\)file" = "Quit" ]; then
        echo "Exiting script runner."
        exit 0
    elif [ -n "$file" ]; then
        filename=\((basename "\)file")
        echo ""
        echo "[EXEC] Running $filename against SQL Server..."
        echo "--------------------------------------------------"
        
        # Executes script inside the Docker container
        docker exec -i "$CONTAINER_NAME" \
            /opt/mssql-tools18/bin/sqlcmd \
            -S localhost \
            -U "$DB_USER" \
            -P "$DB_PASS" \
            -C \
            -i "/var/opt/mssql/$filename" 2>/dev/null || \
        docker exec -i "$CONTAINER_NAME" \
            /opt/mssql-tools/bin/sqlcmd \
            -S localhost \
            -U "$DB_USER" \
            -P "$DB_PASS" \
            -C < "$file"

        echo "--------------------------------------------------"
        echo "[SUCCESS] Finished executing $filename."
        break
    else
        echo "Invalid selection. Please enter a valid option number."
    fi
done