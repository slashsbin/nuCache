#############################
# Modules VMod Dependencies #
#############################
import std;

###################
# General Modules #
###################
include "module.d/mod_customError.vcl";
#include "module.d/mod_shortCircuit.vcl";
#include "module.d/mod_shortCircuit_trigger.vcl";
#include "module.d/mod_test.vcl";
#include "module.d/mod_debug.vcl";


######################
# PHP/Drupal Modules #
######################
#include "module.d/mod_drupal.vcl";
#include "module.d/mod_php.vcl";


#####################
# Main/Core Modules #
#####################
include "module.d/mod_main.vcl";
#include "module.d/mod_default.vcl";