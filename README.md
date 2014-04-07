Redmine installation with Vagrant and SaltStack
===============================================

### Work in progress

**/!\** : A bug in Saltstack prevents from creating grants to the redmine user. Use the MySQL CLI while being manually logged in the VM:
```sql
GRANT ALL PRIVILEGES ON redmine.* TO 'redmine'@'localhost';
```

Some additional steps need to be manually performed as they are not indempotent:
```bash
vagrant ssh
cd /usr/local/src/redmine-2.5.1
sudo rake generate_secret_token
sudo RAILS_ENV=production rake db:migrate
sudo RAILS_ENV=production rake redmine:load_default_data
```

Log files are exported using a shared folder `~/tmp`. Watch them with:
```bash
tail -f ~/tmp/minion
```

The current VM is available on your network at: http://192.168.50.40
