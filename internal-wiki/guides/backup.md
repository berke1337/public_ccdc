# Backup Guide

## Recommendations
`git` is your friend. Know how to use it. Use it. In addition to putting every
directory into git (or at least `/etc` and `/var`, since those typically contain
important information), make a copy into `/root/backup` (or something less
obvious) in case the red team tampers with the `.git` folder too.

## Specific Services

**Make sure to include the dump files in git and make multiple copies of them!**

### Webserver
Usually under `/var/www`, but check webserver configuration to see exactly
where the web roots are. There is a webroot finding script at
[webroot][webroot], just copy the files from the directory it gives to some
backup location. Make sure to backup web applcation databases too! (see sections
below)

[webroot]: https://github.com/berke1337/public_ccdc/blob/master/rootfind.sh


### MySQL

* To dump: `mysqldump -u [username] -p [dbname] > dump.sql`. Use `-h host` and
  `-P port` if remote, and use `--all-databases` if all databases should be
  backed up, or `--databases` followed by a list of databases if multiple
  different databases should be included.
* To restore: `mysql -u [username] -p [dbname] < dump.sql`, with
  `-h host` and `-P port` if remote. `[dbname]` is optional, and shouldn't be
  included if restoring multiple databases (dumped with `--all-databases`).


### PostgreSQL

#### Single database

* To dump: `pg_dump [dbname] > dump.sql`. Use `-h host` and `-p port` if remote.
* To restore: `psql [dbname] < dump.sql`. Make sure the database `dbname` is
  created before running this, e.g. with `createdb -T template0 [dbname]`

#### All databases

* To dump: `pg_dumpall > dump.sql`. Use `-h host` and `-p port` if remote.
* To restore: `psql -f dump.sql postgres`, where `postgres` is the default
  cluster name.


### MongoDB

#### mongodump

Using `mongodump` is probably your best bet, it will dump data in a `BSON`
format that `mongorestore` can use to restore from. This can be done while
`mongod` is running. It will not include index data, but that's probably fine,
as nobody cares about performance in the competition as long as things sorta
work. `mongodump` can be given `--host <hostname><:port>` to dump from if the
MongoDB is remote, and `--ssl` to connect with if TLS/SSL is used. To
authenticate, give `--username <username>` and it should prompt for a password.
By default, it dumps into a `dump` directory in the current working directory,
give `--out <path>` if you want a different location, or `--out -` for stdout.
`mongorestore` takes pretty much the same arguments.

#### Just using cp

Stopping `mongod` and then just copying its files is fine too.
`/etc/mongodb.conf` should have a line `dbpath` that says where the data is
stored so that it can be copied.
