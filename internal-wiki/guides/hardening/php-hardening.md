# PHP Hardening

Create PHP log folder
```bash
cd /var/logs
mkdir php
touch php/php_error.log
chown -R httpd php     # httpd might be www or www-data, check!
cd /var/www
mkdir tmp
chown httpd tmp        # httpd might be www or www-data, check!
```

php.ini
```
register_globals = Off ;Default is Off
enable_dl = Off
open_basedir = /var/www/htdocs/ ;This restricts access to /var/www/htdocs/. Do not forget the last /
memory_limit = 128M ;Or even lower
allow_url_fopen = Off ;Make sure that applications dont break but the usually dont.
allow_url_include = Off ;never ever include from url
disable_functions = openlog, syslog, show_source, system, shell_exec, passthru, exec, popen, proc_open, proc_nice, ini_restore, dl,pclose,proc_terminate,proc_close,pfsockopen,leak,posix_kill,posix_mkfifo,posix_setpgid,posix_setsid,posix_setuid,proc_get_status, apache_child_terminate,apache_get_modules, apache_get_version, apache_getenv, apache_note, apache_setenv, virtual, set_time_limit, php_info
safe_mode_gid = Off
expose_php = Off
error_reporting = E_ALL
log_errors = On
error_log = /var/logs/php/php_error.log
upload_tmp_dir = /var/www/tmp
display_errors = Off
display_startup_errors = Off
;file_uploads = Off ;Consider turning this off if webapp does not need it
upload_max_filesize = 5M
```

Install php-suhosin (either apt-get, yum, pkg, or
http://suhosin.org/stories/install.html)
