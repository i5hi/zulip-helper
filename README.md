# INSTALL

Refer to `init.sh`

# EMAIL

Fill out the section of `/etc/zulip/settings.py` headed “Outgoing email (SMTP) settings”. 
This includes the hostname and typically the port to reach your SMTP provider, and the username to log in to it. 
You’ll also want to fill out the noreply email section.
Put the password for the SMTP user account in `/etc/zulip/zulip-secrets.conf` by setting email_password. For example: email_password = abcd1234.

Like any other change to the Zulip configuration, be sure to restart the server to make your changes take effect.

Configure your SMTP server to allows your Zulip server to send emails originating from the email addresses listed in `/etc/zulip/settings.py` as

```
ZULIP_ADMINISTRATOR
NOREPLY_EMAIL_ADDRESS 
ADD_TOKENS_TO_NOREPLY_ADDRESS=False
TOKENIZED_NOREPLY_EMAIL_ADDRESS
```

Once your configuration is working, restart the Zulip server with 

```
su zulip -c '/home/zulip/deployments/current/scripts/restart-server'
```


```
su zulip -c '/home/zulip/deployments/current/manage.py send_test_email vishalmenon.92@gmail.com
```

# PUSH NOTIFICATIONS:

In `/etc/zulip/settings.py` uncomment:

```
PUSH_NOTIFICATION_BOUNCER_URL = 'https://push.zulipchat.com'
PUSH_NOTIFICATION_REDACT_CONTENT = True (This provides privacy against the push notification server)
```

Then:

```
su zulip -c '/home/zulip/deployments/current/manage.py register_server'
```

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

To recover from a backup; as rpot run:

```
home/zulip/deployments/current/scripts/setup/restore-backup /tmp/zulip-backup.tar.gz
```

# ANSIBLE

You will need to configure your local ansible with the provided settings in the `ansible.cfg`

Use `ansible-playbook ssh.yml` to update the ssh user to zulip before running the backup.yml playbook.

# SECURITY

Take the time to go over the following docs on security to harden your server:

https://zulip.readthedocs.io/en/latest/production/security-model.html#

Major security takeaways:

Disable SSH Root and Password Login
Change SSH Port to a non-standard port
Install fail2ban with meaningful configs
Install ufw and block unnecessarily open ports: Refer to https://zulip.readthedocs.io/en/latest/production/requirements.html#network-and-security-specifications

# SUPPORT

For additional support, reach out to the team at https://chat.zulip.org
