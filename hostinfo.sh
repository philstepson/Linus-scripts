#!/bin/sh
echo "+-----------------------------------------------+"
echo "|         Collect Server Information            |"
echo "+-----------------------------------------------+"
HST="`hostname`"
DAT="`date +%Y%m%d`"
HOUR="`date +%H`"
DIR="/opt/sripts/${HST}/${DAT}_${HOUR}"
if ! test -d ${DIR}
then
        /bin/mkdir -p ${DIR}
fi
/opt/scripts/sar-cpu-avg.sh > ${DIR}/sat-cpu-avg;
/opt/scripts/sar-memory-avg.sh > ${DIR}/sar-memory-avg.sh;
/opt/scripts/sar-cpu-mem-avg.sh > ${DIR}/sar-cpu-mem-avg.sh;
lscpu > /opt/scripts/metrics/lscpu; 
hostname > ${DIR}/hostname;
hostnamectl > ${DIR}/hostnamectl; 
dnsdomainname > ${DIR}/dnsdomainname;
dmidecode  > ${DIR}/dmidecode
#sudo dmidecode | grep -A3 '^System Information'
lsblk -o NAME,UUID,SIZE,FSTYPE,TYPE,MOUNTPOINT  > ${DIR}/LSBLK
du -h --max-depth=2 / 2>/dev/null | sort -rh | head -15 > ${DIR}/diskDU
df -h > ${DIR}/diskDF;
df -h --output=size --total | awk 'END {print $1}' > ${DIR}/disktot;
/opt/scripts/diskio.sh > ${DIR}/diskio;
iostat -m -x  > ${DIR}/iostat;
tar cvf - /opt/scripts/metrics | gzip >stats-${HST}.tar.g
