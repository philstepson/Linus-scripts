#!/bin/sh
echo "+-----------------------------------------------+"
echo "|         Collect Server Information            |"
echo "+-----------------------------------------------+"
rm -r metrics; mkdir /opt/scripts/metrics;
/opt/scripts/sar-cpu-avg.sh > /opt/scripts/metrics/SarCpuAv;
/opt/scripts/sar-memory-avg.sh > /opt/scripts/metrics/SarMemAvg;
/opt/scripts/sar-cpu-mem-avg.sh > /opt/scripts/metrics/CpuMemAvg;
lscpu > /opt/scripts/metrics/lscpu; hostname > /opt/scripts/metrics/hostname;
 hostnamectl > /opt/scripts/metrics/hostnamectl; 
dnsdomainname > /opt/scripts/metrics/dnsdomainname;
dmidecode  > /opt/scripts/metrics/SysInfo
#sudo dmidecode | grep -A3 '^System Information'
lsblk -o NAME,UUID,SIZE,FSTYPE,TYPE,MOUNTPOINT  > /opt/scripts/metrics/diskLSBLK
du -h --max-depth=2 / 2>/dev/null | sort -rh | head -15 > /opt/scripts/metrics/disk1
df -h > /opt/scripts/metrics/diskDF
df -h --output=size --total | awk 'END {print $1}' > /opt/scripts/metrics/disktot
/opt/scripts/diskio.sh > /opt/scripts/metrics/diskio
iostat -m -x  > /opt/scripts/metrics/iostat
