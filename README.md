# Workstation assimilation

## Old (Bash)

The old version of the workstation assimilation is the `assimilate.sh` script.
It is written in Bash and I am unable to understand what I have written ...

Soon to be completely removed

## New (Chef)

### Development

Run:
```
bash pusblish.sh
```

### Target

Run:
```
curl -o assimilation.tar.gz http://vsoul.net/assimilation.tar.gz
md5sum assimilation.tar.gz
tar zxvf assimilation.tar.gz
bash go.sh
```
