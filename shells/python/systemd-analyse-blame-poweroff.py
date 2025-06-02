import sys
import subprocess
from datetime import datetime

from tabulate import tabulate

# Dictionary to store the 'Stopping' event timestamps
stopping_events = {}

# Dictionary to store the elapsed time for each service
elapsed_times = {}

# Function to parse the log line and extract relevant information
def parse_log_line(line):
    parts = line.split()
    timestamp_str = " ".join(parts[:3])
    service_name = " ".join(parts[6:]).replace('.', '')
    event = parts[5]
    timestamp = datetime.strptime(f"{datetime.now().year} {timestamp_str}", "%Y %b %d %H:%M:%S")
    return timestamp, service_name, event

# Run the command in a subshell and gather the output
command = r'journalctl -b -1 | grep -P "Stopp(ed|ing)" | grep "$(date +"%b %d")"'
process = subprocess.Popen(command, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
stdout, stderr = process.communicate()

# Read lines from stdin
for line in stdout.decode().splitlines():
    timestamp, service_name, event = parse_log_line(line)

    if event == "Stopping":
        stopping_events[service_name] = timestamp
    elif event == "Stopped":
        if service_name in stopping_events:
            elapsed_time = (timestamp - stopping_events[service_name]).total_seconds()
            elapsed_times[service_name] = elapsed_time

# Prepare data for tabular output
table_data = []
for service, elapsed_time in sorted(elapsed_times.items(), key=lambda x: x[1]):
    if int(elapsed_time) == 0:
        continue
    table_data.append([service, f"{elapsed_time:.2f} seconds"])

total_elapsed_time = sum(elapsed_times.values())
table_data.append(["Total", f"{total_elapsed_time:.2f} seconds"])

# Print the report in tabular format
print(tabulate(table_data, headers=["Service", "Elapsed Time"], tablefmt="simple_grid"))
