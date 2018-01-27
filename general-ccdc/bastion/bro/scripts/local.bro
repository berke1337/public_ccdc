# Local Bro policy optimized for full monitorinng.
#
# Author: Matthias Vallentin
#

@load misc/loaded-scripts
@load tuning/defaults

# Process packets despite bad checksums.
redef ignore_checksums = T;

#
# File Analysis
#

const executables = /application\/.*/ &redef;

# Extract these files.
redef IRC::extract_file_types = executables;
redef FTP::extract_file_types = executables;
redef HTTP::extract_file_types = executables;
redef SMTP::extract_file_types = executables;

# Generate MD5 digests for certain files.
redef HTTP::generate_md5 = executables;
redef SMTP::generate_md5 = executables;

#
# Protocl Analysis
#

@load protocols/ftp/detect
@load protocols/conn/known-hosts
@load protocols/conn/known-services
@load protocols/ssl/known-certs
@load protocols/ssl/validate-certs
@load protocols/ssh/geo-data
@load protocols/ssh/detect-bruteforcing
@load protocols/ssh/interesting-hostnames
@load protocols/http/detect-MHR
@load protocols/http/detect-sqli

# Log plain-text passwords.
redef FTP::default_capture_password = T;
redef HTTP::default_capture_password = T;

# Log HTTP cookies.
redef record HTTP::Info += { cookie: string &log &optional; };
event http_header(c: connection, is_orig: bool, name: string, value: string)
  {
  if ( is_orig && name == "COOKIE" )
    c$http$cookie = value;
  }


#
# Software framework
#
@load frameworks/software/version-changes
@load frameworks/software/vulnerable

redef Software::vulnerable_versions += {
  ["Flash"] = [$major=10, $minor=2, $minor2=153, $addl="1"],
  ["Java"] =  [$major=1,  $minor=6, $minor2=0,   $addl="22"],
};

@load protocols/ftp/software
@load protocols/smtp/software
@load protocols/ssh/software
@load protocols/http/software
@load-sigs frameworks/signatures/detect-windows-shells
@load protocols/http/detect-webapps # Performance-hungry!

#
# Notice Policy
#

hook Notice::policy(n: Notice::Info)
 {
   if ( n$note == SSL::Invalid_Server_Cert && Site::is_local_addr(n$id$orig_h) )
     break;
 }

hook Notice::policy(n: Notice::Info)
 {
   add n$actions[Notice::ACTION_ALARM];
 }
