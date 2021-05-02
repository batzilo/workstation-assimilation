# Workstation assimilation

> Make my workstation the way I like it.

## Using Chef

### Development

On the development machine, run:
```
bash pusblish.sh
```

And note the MD5 sum.

### Target

On the workstation-to-be-assimilated, run:
```
curl -s -q -o assimilation.tar.gz http://vsoul.net/assimilation.tar.gz
md5sum assimilation.tar.gz
```

If you like the MD5 sum, proceed:
```
tar zxvf assimilation.tar.gz
bash run.sh
```

If you want the CLI version only, then:
```
bash run.sh --cli
```

## Using plain Bash

The old version of the workstation assimilation is the
[`assimilate.sh`](assimilate.sh) script.

It is written in Bash, and even though I personally wrote it,
I am unable to understand what it does ...

Soon to be completely removed.
