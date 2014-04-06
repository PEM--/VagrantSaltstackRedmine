Redmine installation with Vagrant and SaltStack
===============================================
**Work in progress**

* /!\ : A bug in Saltstack prevents from creating grants to the redmine user <br>
  Use the mysql CLI manually logged:<br>
  ```GRANT ALL PRIVILEGES ON redmine.* TO 'redmine'@'localhost';```
