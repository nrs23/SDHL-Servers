# KNEPP container scripts
These are the scripts used by the KNEPP container running on `shl2.inf.susx.ac.uk`. This runs scripts that write audio streams (from `locus.creacast.com`) of site recordings to file, saving them as 1 minute mp3 files.

An additional backup script copies all files nightly over to the backup server downstairs in the SDHL lab's physcial space.

The crontab configuration on the container is:

```
1 * * * * /mnt/knepp_extra/record-stream-air.sh
1 * * * * /mnt/knepp_extra/record-stream-water.sh
20 2 * * * /mnt/knepp_extra/knepp-backup.sh
```
