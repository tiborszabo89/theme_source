#!/bin/bash -e
clear

echo "================================================================="
echo "Wordpress installer"
echo "================================================================="

# accept user input for the databse name
echo "Database Name: "
read dbname

# accept the name of our website
echo "Site Name: "
read sitename

# admin username
echo "Admin username: "
read wpuser

# add a simple yes/no confirmation before we proceed
echo "Run Install? (y/n)"
read run

# download the WordPress core files, default EN
wp core download

# create the wp-config file
wp core config --dbname=$dbname --dbuser=mysqlusername --dbpass=mysqluserpass

# parse the current directory name
currentdirectory=${PWD##*/}

# generate random 12 character password
password=$(LC_CTYPE=C tr -dc A-Za-z0-9_\!\@\#\$\%\^\&\*\(\)-+= < /dev/urandom | head -c 12)

# create database, and install WordPress
wp db create
wp core install --url="http://127.0.0.1:8080" --skip-themes --title="$sitename" --admin_user="$wpuser" --admin_password="$password" --skip-email --admin_email="admin@admin.com"

# install the _s theme

#Install my basic theme
wp theme install https://github.com/tiborszabo89/theme_source/raw/main/starter_theme.zip --skip-plugins --activate
wp theme delete twentytwenty twentytwentyone twentytwentytwo

echo "================================================================="
echo "Installation is complete. Your username/password is listed below."
echo ""
echo "Username: $wpuser"
echo "Password: $password"
echo ""
echo "================================================================="