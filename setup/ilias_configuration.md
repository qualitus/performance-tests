# ILIAS Configuration for jMeter

The following ILIAS settings are recommended

* Deactivate the setting "users must change their password on first login" (can be reactivated once the jMeter users have logged in)
* Deactivate the user agreement (or login with the jMeter users and accept the agreement)
* Activate the english language (a minority of testcases like 'logout' depend on specific translations)
* If you want to test calendar, courses, session and forums use the export file from [here](https://github.com/gvollbach/PerformanceTestsExportFile) and add the needed informations, like ref-ids and titles to the calendar_and_sessions.csv, course_objects.csv, forum_objects.csv files.
Optional:
* You might want to either disable the trash - or purge it from time to time.
