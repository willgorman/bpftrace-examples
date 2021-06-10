sudo bpftrace -e 'tracepoint:syscalls:sys_enter_execve { join(args->argv) }'

# shell 2
gimme 1.13
