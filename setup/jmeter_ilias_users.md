# Setup ILIAS Users for jMeter

In order to use the testsuite, please import a customized `setup/var/user_import.xml` into ILIAS and save the credentials for jmeter as `config/users.csv`. The detailed steps are as follows

* **Customize the user accounts** (see below)
* **Login** as administrator
* Navigate to **Administration > User Management > Import Users**
* Choose `setup/var/user_import.xml`
* Confirm twice via **Import** button

## Customize ILIAS user accounts

**Important**: It is strongly recommended that you change the passwords of the jmeter users as follows.

Choose a strong password and create a md5-hash (http://www.md5-generator.de/). Then execute these steps at the root of the repository (substitute `__STRONG_PASSWORD__` and `__MD5_HASH__`)

```bash
cp config/users.csv.dist config/users.csv
sed s/o0X38sRIXGVk/__STRONG_PASSWORD__/ config/users.csv
cp setup/var/user_import.xml.dist setup/var/user_import.xml
sed s/09e705636e39b8d72023b3f18251de11/__MD5_HASH__/ setup/var/user_import.xml
```

**Note**: You can do extended tests, if you choose to grant administrator permissions
(just map the roles user->administrator during import).

* Import these users to ILIAS (administration > user accounts > import users > user_import.xml)
* Deactivate the setting "users must change their password on first login" (can be reactivated once these users have logged in)
* Deactivate the user agreement (or login with these users and accept the agreement)

### Alternative User Data

If you want to add or change user data, you can edit the Excel sheet `setup/var/user_import.xls` and export to `setup/var/user_import.xml`. Don't forget to run these steps at the root of the repository (substitute `__STRONG_PASSWORD__`)
```bash
cp config/users.csv.dist config/users.csv
sed s/o0X38sRIXGVk/__STRONG_PASSWORD__/ config/users.csv
```
