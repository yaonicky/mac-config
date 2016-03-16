#!bash
#
# Thanks for installing Lunchy.  We know you're going to love it!
#
# If you want to add tab-completion (for bash), add the following
# to your .bash_profile, .bashrc or .profile

LUNCHY_DIR=$(dirname `gem which lunchy`)/../extras
if [ -f $LUNCHY_DIR/lunchy-completion.bash ]; then
 . $LUNCHY_DIR/lunchy-completion.bash
fi
