sudo bpftrace -e 't:block:block_rq_issue { @bytes = hist(args->bytes); } '

