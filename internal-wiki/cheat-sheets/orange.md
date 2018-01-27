# Dealing with the Orange Team

## Policy Creation
Some injects may involve dealing with creating policies (i.e. Acceptable Use). Use an existing template for this
* [SANS](https://www.sans.org/security-resources/policies/)
* [California's Department of Technology](http://www.cio.ca.gov/OIS/Government/library/samples.asp)

## Incident Reporting
* Make sure that there are logs and audits for this
  * Windows LSP/GPO set for Auditing; make sure no program is piping to /dev/null
  * Check /var/log/, but make sure not to get overloaded by useless information
* Must demonstrate some issue other than just port scanning
* Before uninstalling rootkits/mitigation, send the report first

## Presentation Topics
* In regionals, you have two hours or more to prepare for a five minute presentation, with the ability to bring a PowerPoint.
* Whoever does it shouldn't have much to do; they will have to be with the rest of the teams until everyone is done
  * ~1 hour; early leave/late arrival is 0 points
* Topics are usually easily searchable and business (buzzword) related, such as "Next Gen End Point Security"

## Other Reporting (i.e. Vuln. Scans, Usage)
* They will occasionally ask for a vulnerability scan of the system or a usage check of a service
  * For the former, a nmap picture is *not* enough
