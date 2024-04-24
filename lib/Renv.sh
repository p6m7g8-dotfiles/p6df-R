# shellcheck shell=bash
######################################################################
#<
#
# Function: p6df::modules::R::Renv::latest::installed()
#
#>
######################################################################
p6df::modules::R::Renv::latest::installed() {

  Renv install -l | p6_filter_row_select '"[0-9]"' | p6_filter_row_from_end "2" | p6_filter_spaces_strip
}

######################################################################
#<
#
# Function: p6df::modules::R::Renv::latest()
#
#>
######################################################################
p6df::modules::R::Renv::latest() {

  Renv install -l | p6_filter_row_select '"[0-9]"' | p6_filter_row_last "1" | p6_filter_spaces_strip
}
