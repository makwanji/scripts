# create by Jignesh

export APPS_USER=apps
export APPS_PASS=apps


# Pre-clone
echo $APPS_PASS | perl $ORACLE_HOMR/appsutil/scripts/$CONTEXT_NAME/adpreclone.pl dbTier


