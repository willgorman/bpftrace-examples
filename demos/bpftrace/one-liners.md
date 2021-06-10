## Show new processes with arguments

```
sudo bpftrace -e 'tracepoint:syscalls:sys_enter_execve { join(args->argv) }'
```


## Profile to FlameGraph

```
sudo bpftrace -e 'profile:hz:99 { @[kstack] = count(); }' > bpftrace.out; \
~/FlameGraph/stackcollapse-bpftrace.pl bpftrace.out > flamegraph.in; \
~/FlameGraph/flamegraph.pl < flamegraph.in > ~/demos/flamegraph.svg
```
