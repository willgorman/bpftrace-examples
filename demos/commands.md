# mysqld_qslower

<!-- sudo /usr/local/mysql/bin/mysqld --skip-grant-tables --general-log & -->

sudo demos/bpftrace/scripts/mysqld_qslower.bt -p $(pgrep mysqld)

sudo mysqld_qslower $(pgrep mysqld) 0

# Start ebpf exporter

```
sudo ~/go/bin/ebpf_exporter --config.file=/home/vagrant/demos/exporterconfig.yaml
```

# iscsi login script

```
sudo ~/demos/bpftrace/scripts/iscsi_logins_ubuntu.bt
```

```
iscsi-inq -i iqn.1993-08.org.debian:01:foo iscsi://localhost/iqn.1993-08.org.debian:01:bar/0
```
