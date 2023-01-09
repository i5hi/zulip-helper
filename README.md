# INSTALL

Refer to `init.sh`

# EMAIL

Fill out the section of /etc/zulip/settings.py headed “Outgoing email (SMTP) settings”. 
This includes the hostname and typically the port to reach your SMTP provider, and the username to log in to it. 
You’ll also want to fill out the noreply email section.
Put the password for the SMTP user account in /etc/zulip/zulip-secrets.conf by setting email_password. For example: email_password = abcd1234.

Like any other change to the Zulip configuration, be sure to restart the server to make your changes take effect.

Configure your SMTP server to allows your Zulip server to send emails originating from the email addresses listed in /etc/zulip/settings.py as ZULIP_ADMINISTRATOR, NOREPLY_EMAIL_ADDRESS and if ADD_TOKENS_TO_NOREPLY_ADDRESS=True (the default), TOKENIZED_NOREPLY_EMAIL_ADDRESS.]

Once your configuration is working, restart the Zulip server with su zulip -c '/home/zulip/deployments/current/scripts/restart-server'.



```
su zulip -c '/home/zulip/deployments/current/manage.py send_test_email vishalmenon.92@gmail.com
```

# PUSH NOTIFICATIONS:

Uncomment the PUSH_NOTIFICATION_BOUNCER_URL = 'https://push.zulipchat.com' line in your /etc/zulip/settings.py file
```
su zulip -c '/home/zulip/deployments/current/manage.py register_server'
```

See https://zulip.readthedocs.io/en/latest/production/mobile-push-notifications.html

# BACKUPS

```
su zulip -c '/home/zulip/deployments/current/manage.py backup' --ouput=/tmp/zulip-backup.tar.gz
```

On your localhost
```
# From remote
scp ztm:/tmp/zulip-backup.tar.gz /home/ishi/backups/

# To remote
scp /home/ishi/backups/zulip-backup.tar.gz ztm:/tmp/zulip-backup.tar.gz

```

To recover from a backup
```
su zulip -c 'home/zulip/deployments/current/scripts/setup/restore-backup /tmp/zulip-backup.tar.gz'
```

# ANSIBLE

You will need to configure your local ansible with the provided settings in the `ansible.cfg`


