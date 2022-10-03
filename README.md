# Workstation assimilation

> Make my workstation the way I like it.

## Using Chef

### Development

On the development machine, run:
```
make
```

Commit, and push to the `master` branch on GitHub.

### Target

On the workstation-to-be-assimilated, run:
```
curl -s -L -o assimilation.tar.gz        https://github.com/batzilo/workstation-assimilation/raw/master/out/assimilation.tar.gz
curl -s -L -o assimilation.tar.gz.sha512 https://github.com/batzilo/workstation-assimilation/raw/master/out/assimilation.tar.gz.sha512
echo "$(cat assimilation.tar.gz.sha512)" | sha512sum --check
```

Assimilate:
```
tar zxvf assimilation.tar.gz
bash run.sh [--cli]
```

## Using plain Bash

The old version of the workstation assimilation is the
[`assimilate.sh`](assimilate.sh) script.

It is written in Bash, and even though I personally wrote it,
I am unable to understand what it does ...

Soon to be completely removed.

## Extra disks for alan

```
# mkdir -p /mnt/external
# mkdir -p /mnt/garage

# chown batzilo:batzilo /mnt/external
# chown batzilo:batzilo /mnt/garage
```

In `/etc/fstab` add:
```
UUID=7e51fa27-b811-4ed2-a78d-a6641ac86e1a /mnt/external auto defaults,noauto,user 0 0
UUID=6fc110af-712e-468b-916c-5907861a4410 /mnt/garage auto defaults,noauto,user 0 0
```

This will allow any regular user to mount these filesystems.
