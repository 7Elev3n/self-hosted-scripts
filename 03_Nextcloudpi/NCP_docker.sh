sudo apt-get install docker-compose -y

mkdir /$HOME/seafile
mkdir /$HOME/seafile/mysql
mkdir /$HOME/seafile/data

# Remember to change in the docker compose file (real-dir : docker dir) :
## 1. mySQL password (MYSQL_ROOT_PASSWORD)
## 2. mySQL password (DB_ROOT_PASSWORD)
## 3. mySQL db path (1st volumes)
## 4. seafile data path (2nd volumes)

cd /$HOME
