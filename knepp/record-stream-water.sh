#designed to run every hour to create hourly snapshots of an mp3 stream. eg at one minute past the hour with cron "1 * * * *"

URL=http://locus.creacast.com:9001/knepp_water.mp3

DIR=/mnt/knepp_extra/
REC=recordings/water

cd $DIR

./stop-water.sh

FORMAT=%H-%d-%m-%Y

YEAR=`date +'%Y'`
MONTH=`date +'%m'`
DAY=`date +'%d'`

mkdir -p $REC/$YEAR/$MONTH/$DAY

nohup wget -q $URL -O $REC/$YEAR/$MONTH/$DAY/knepp-`date +"$FORMAT"`.mp3 & 

PID=$!

echo "kill $!" > stop-water.sh

chmod +x stop-water.sh
