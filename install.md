sudo apt update

sudo apt install -y r-base
sudo apt-get install -y libxml2-dev libcurl4-openssl-dev libssl-dev build-essential

sudo Rscript -e 'install.packages(c("data.table","dplyr","readr"))'


sudo apt-get install -y python3 python3-pip 

sudo pip3 install pandas polars duckdb --break-system-packages

