#############################
# Modules VMod Dependencies #
#############################
import std;

#######################
# User Custom Modules #
#######################
include "module.d/mod_userCustom.vcl";

###################
# General Modules #
###################
include "module.d/mod_customError.vcl";
#include "module.d/mod_shortCircuit.vcl";
#include "module.d/mod_shortCircuitTrigger.vcl";
#include "module.d/mod_test.vcl";
#include "module.d/mod_debug.vcl";


####################
# Security Modules #
####################
include "module.d/mod_security.vcl";


##########################
# WWW/PHP/Drupal Modules #
##########################
#include "module.d/mod_drupal.vcl";
#include "module.d/mod_php.vcl";


#####################
# Main/Core Modules #
#####################
include "module.d/mod_main.vcl";
#include "module.d/mod_default.vcl";


