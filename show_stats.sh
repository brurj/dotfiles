sensors | awk '/^CPU:/ {print "CPU temperature: " $2}'
echo "CPU usage (%):"
ps axch -o cmd:15,%cpu --sort=-%cpu | head
echo
free -h | awk '/^Mem:/ {print "Memory: " $3 "/" $2}'
echo "Memory usage (%):"
ps axch -o cmd:15,%mem --sort=-%mem | head
