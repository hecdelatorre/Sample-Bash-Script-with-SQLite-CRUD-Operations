#!/bin/bash

database="example.db"

# Create database if it doesn't exist
if [ ! -e "$database" ]; then
    sqlite3 "$database" <<EOF
    CREATE TABLE IF NOT EXISTS users (
        id INTEGER PRIMARY KEY,
        name TEXT,
        age INTEGER
    );
EOF
    echo "Database created successfully."
fi

# CRUD Operations
while true; do
    echo "1. Create User"
    echo "2. Read Users"
    echo "3. Update User"
    echo "4. Delete User"
    echo "5. Exit"

    read -p "Choose an option (1-5): " choice

    case $choice in
        1)
            read -p "Enter name: " name
            read -p "Enter age: " age
            sqlite3 "$database" "INSERT INTO users (name, age) VALUES ('$name', $age);"
            echo "User created successfully."
            ;;
        2)
            sqlite3 "$database" "SELECT * FROM users;"
            ;;
        3)
            read -p "Enter user ID to update: " id
            read -p "Enter new name: " new_name
            read -p "Enter new age: " new_age
            sqlite3 "$database" "UPDATE users SET name='$new_name', age=$new_age WHERE id=$id;"
            echo "User updated successfully."
            ;;
        4)
            read -p "Enter user ID to delete: " id
            sqlite3 "$database" "DELETE FROM users WHERE id=$id;"
            echo "User deleted successfully."
            ;;
        5)
            echo "Exiting..."
            exit 0
            ;;
        *)
            echo "Invalid option. Please choose a number from 1 to 5."
            ;;
    esac
done
