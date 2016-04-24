# A basic .muttrc

source ~/.ssh/tgulacsi78@gmail.com.muttrc

# Change the following six lines to match your Gmail account details
set imap_user = "tgulacsi78@gmail.com"
set smtp_url = "smtps://$imap_user@smtp.gmail.com:465/"
set smtp_pass = "$imap_pass" # leave blank for prompt
set from = "tgulacsi78@gmail.com"
set realname = "Tamás Gulácsi"

set folder = "imaps://imap.gmail.com:993"
set spoolfile = "+INBOX"
set imap_check_subscribed
set hostname = gmail.com
set mail_check = 60
set timeout = 300
set imap_keepalive = 300
set postponed = "+[Gmail]/Drafts"
set record = "" # gmail automatically handles saving sent emails

# Gmail-style keyboard shortcuts
macro index,pager Ga "<change-folder>=[Gmail]/All Mail<enter>" "Go to All Mail"
macro index,pager Gd "<change-folder>=[Gmail]/Drafts<enter>" "Go to Drafts"
macro index,pager Gs "<change-folder>=[Gmail]/Sent Mail<enter>" "Go to Sent Mail"

macro index,pager d ";s+[Gmail]/Trash<enter><enter>" "Trash"
macro index,pager !  <save-message>=[Gmail]/Spam<enter><enter> "Report spam"
macro index,pager +  <save-message>=[Gmail]/Important<enter><enter> "Mark as Important"
macro index,pager *  <save-message>=[Gmail]/Starred<enter><enter> "Star Message"
