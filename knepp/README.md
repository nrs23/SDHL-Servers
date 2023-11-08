# KNEPP container scripts
These are the scripts used by the KNEPP container running on `shl2.inf.susx.ac.uk`. This runs scripts that write audio streams (from `locus.creacast.com`) of site recordings to file, saving them as 1 minute mp3 files.

The `stop-*.sh` scripts work by being overwritten with the `PID` of the recording process after it has been started and captured by the `record-stream-*.sh` script using `$!` (`PID` of last background task).

An additional backup script copies all files nightly over to the backup server downstairs in the SDHL lab's physcial space. It requires that the rsync user (in the script itself) have an ssh key set up to log in to the lab computer.

The crontab configuration on the container is:

```
1 * * * * /mnt/knepp_extra/record-stream-air.sh
1 * * * * /mnt/knepp_extra/record-stream-water.sh
20 2 * * * /mnt/knepp_extra/knepp-backup.sh
```
