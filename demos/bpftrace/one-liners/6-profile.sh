sudo bpftrace -e 'profile:hz:99 { @[kstack] = count(); }'


# flame graph
sudo bpftrace -e 'profile:hz:99 { @[kstack] = count(); }' > bpftrace.out 

~/FlameGraph/stackcollapse-bpftrace.pl bpftrace.out > flamegraph.in
~/FlameGraph/flamegraph.pl < flamegraph.in > ~/demos/flamegraph.svg


# load
cat /dev/urandom | gzip -9 > /dev/null
