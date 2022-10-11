For Linux users, set the path to /srv/gitlab:

export GITLAB_HOME=/srv/gitlab


Local location	Container location	Usage

$GITLAB_HOME/data	/var/opt/gitlab	For storing application data.

$GITLAB_HOME/logs	/var/log/gitlab	For storing logs.

$GITLAB_HOME/config	/etc/gitlab	For storing the GitLab configuration files.


Visit the GitLab URL (gitlab.example.com), and log in with username root and the password from the following command:

sudo docker exec -it gitlab grep 'Password:' /etc/gitlab/initial_root_password

