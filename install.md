sudo apt update

# Install R and the R tools
sudo apt install -y r-base
sudo apt-get install -y libxml2-dev libcurl4-openssl-dev libssl-dev build-essential

sudo Rscript -e 'install.packages(c("data.table","dplyr","readr"))'

# Install Python and the Python tools + duckdb
sudo apt-get install -y python3 python3-pip 

sudo pip3 install pandas polars duckdb --break-system-packages


# Install clickhouse
sudo apt install -y apt-transport-https ca-certificates dirmngr

sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 8919F6BD2B48D754
echo "deb https://packages.clickhouse.com/deb stable main" | sudo tee /etc/apt/sources.list.d/clickhouse.list

sudo apt update
sudo apt install -y clickhouse-server clickhouse-client

sudo systemctl start clickhouse-server
