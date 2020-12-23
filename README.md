# Workstation assimilation

> Make my workstation

## Old (Bash)

The old version of the workstation assimilation is the
[`assimilate.sh`](assimilate.sh) script.
It is written in Bash, and even though I wrote it some time ago, I am unable to
understand what it does...

Soon to be completely removed.

## New (Chef)

### Development

From the development machine, run:
```
bash pusblish.sh
```

### Target

On the workstation-to-be-assimilated, run:
```
curl -o assimilation.tar.gz http://vsoul.net/assimilation.tar.gz
md5sum assimilation.tar.gz
tar zxvf assimilation.tar.gz
bash run.sh
```
