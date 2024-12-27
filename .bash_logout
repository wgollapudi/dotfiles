### ~/.bash_logout: executed by bash(1) when login shell exits.

# Force save history
history -a

# CLose SSH agent
[ -n "$SSH_AGENT_PID" ] && eval "$(ssh-agent -k)"

# Sync Filesystems
sync

# Clear the screen when exiting the shell for privacy
if [ "$SHLVL" = 1 ]; then
    [ -x /usr/bin/clear_console ] && /usr/bin/clear_console -q
fi
