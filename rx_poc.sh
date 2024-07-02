#! /bin/bash

today=$(date +%Y%m%d)

weather_report=raw_data_$today

city=Indore

curl wttr.in/$city --output $weather_report

grep °C $weather_report > temperatures.txt

obs_tmp=$(head -1 temperatures.txt | tr -s " " | xargs | rev | cut -d " " -f2 | rev)


fc_temp=$(head -3 temperatures.txt | tail -1 | tr -s " " | xargs | cut -d "C" -f2 | rev | cut -d " " -f2 | rev)


hour=$(TZ='India/Kolkata' date -u +%H) 
day=$(TZ='India/Kolkata' date -u +%d) 
month=$(TZ='India/Kolkata' date +%m)
year=$(TZ='India/Kolkata' date +%Y)


record=$(echo -e "$year\t$month\t$day\t$hour\t$obs_tmp\t$fc_temp")
echo $record>>rx_poc.log
