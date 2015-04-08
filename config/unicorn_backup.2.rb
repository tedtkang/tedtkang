# Set the working application directory
# working_directory "/path/to/your/app"
working_directory "/home/ubuntu/tedtkang"

# Unicorn PID file location
# pid "/path/to/pids/unicorn.pid"
pid "/home/ubuntu/tedtkang/tmp/pids/unicorn.pid"

# Path to logs
# stderr_path "/path/to/log/unicorn.log"
# stdout_path "/path/to/log/unicorn.log"
stderr_path "/home/ubuntu/tedtkang/log/unicorn.log"
stdout_path "/home/ubuntu/tedtkang/log/unicorn.log"

# Unicorn socket
listen "/home/ubuntu/tedtkang/tmp/sockets/unicorn.tedtkang.sock"
listen "/home/ubuntu/tedtkang/tmp/sockets/unicorn.myapp.sock"

# Number of processes
# worker_processes 4
worker_processes 2

# Time-out
timeout 30
