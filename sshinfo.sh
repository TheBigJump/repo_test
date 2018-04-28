SystemMountPoint="/";
LinesPrefix="  ";
b=$(tput bold); n=$(tput sgr0);

SystemLoad=$(cat /proc/loadavg | cut -d" " -f1);
ProcessesCount=$(cat /proc/loadavg | cut -d"/" -f2 | cut -d" " -f1);

MountPointInfo=$(/bin/df -Th $SystemMountPoint 2>/dev/null | tail -n 1);
MountPointFreeSpace=( \
  $(echo $MountPointInfo | awk '{ print $6 }') \
  $(echo $MountPointInfo | awk '{ print $3 }') \
);
UsersOnlineCount=$(users | wc -w);

#UsedRAMsize=$(free -m);

SystemUptime=$(uptime | sed 's/.*up \([^,]*\), .*/\1/');

if [ ! -z "${LinesPrefix}" ] && [ ! -z "${SystemLoad}" ]; then
  echo -e "${LinesPrefix}${b}System load:${n}\t${SystemLoad}\t\t\t${LinesPrefix}${b}Processes:${n}\t\t${ProcessesCount}";
fi;

if [ ! -z "${MountPointFreeSpace[0]}" ] && [ ! -z "${MountPointFreeSpace[1]}" ]; then
  echo -ne "${LinesPrefix}${b}Usage of $SystemMountPoint:${n}\t${MountPointFreeSpace[0]} of ${MountPointFreeSpace[1]}\t\t";
fi;
echo -e "${LinesPrefix}${b}Users logged in:${n}\t${UsersOnlineCount}";

if [ ! -z "${UsedRAMsize}" ]; then
  echo -ne "${LinesPrefix}${b}Memory usage:${n}\t${UsedRAMsize}%\t\t\t";
fi;
echo -e "${LinesPrefix}${b}System uptime:${n}\t${SystemUptime}";
