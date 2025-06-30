## UPDATING LOCAL DB ##
This is meant to be used for local development. To grab latest from the db, add your ssh key (or get the password) to the remote mysql server. 

In order for this to work, you must insert the credentials to mysql in a .env file. Do NOT check it in to source control.

After that, run ./get-latest-db.sh

To update your local, run docker (listed below) first, then run the ./restore-mysql.sh script



## RUNNING DOCKER##
Firstly, there must be a ./publish folder in each of the repos so we can generate an image.

So, there is a script ./generate-publish-folder.sh you can run to speed this up.

For the docker compose to work, place this repo in the same directory where all the APIs are, and run "docker-compose up". It should download everything.

