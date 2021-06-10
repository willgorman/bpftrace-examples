sudo bpftrace -e 'kr:tcp_recvmsg /retval >= 0/ { @recv_bytes = hist(retval); }'

# wget https://golang.org/dl/go1.16.5.linux-amd64.tar.gz
