sudo bpftrace -e 'kretprobe:vfs_read { @bytes = lhist(retval, 0, 2000, 200); }'

# shell 2
dd if=/dev/urandom bs=1200 count=50 of=random.img
