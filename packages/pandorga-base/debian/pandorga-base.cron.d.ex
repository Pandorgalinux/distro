#
# Regular cron jobs for the pandorga-base package
#
0 4	* * *	root	[ -x /usr/bin/pandorga-base_maintenance ] && /usr/bin/pandorga-base_maintenance
