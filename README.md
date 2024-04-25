# bmstu-devops


База по виртуалкам

```bash
virt-install \
--name=VM-A \
--vcpus=2 \
--memory=2048 \
--location=rhel-9.3-x86_64-dvd.iso \
--disk size=20 \
--network bridge=virbr0,model=virtio \
--graphics none \
--console pty,target_type=serial \
--extra-args 'console=ttyS0'


server {
    listen 80;
    server_name _;

    location / {
        proxy_pass http://192.168.122.5:80;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}

netstat -lntu


firewall-cmd --add-port=80/tcp
setsebool -P httpd_can_network_connect true


virsh domiflist --domain VM-B
arp -e
```
