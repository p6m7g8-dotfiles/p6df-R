######################################################################
#<
#
# Function: p6df::modules::R::deps()
#
#>
######################################################################
p6df::modules::R::deps() {
  ModuleDeps=(
    p6m7g8-dotfiles/p6common
    viking/Renv
    viking/R-build
  )
}

######################################################################
#<
#
# Function: p6df::modules::R::init()
#
#  Environment:	 P6_DFZ_SRC_DIR
#>
######################################################################
p6df::modules::R::init() {

  p6df::modules::R::Renv::init "$P6_DFZ_SRC_DIR"

  p6df::modules::R::prompt::init
}

######################################################################
#<
#
# Function: p6df::modules::R::prompt::init()
#
#>
######################################################################
p6df::modules::R::prompt::init() {

  p6df::core::prompt::line::add "p6_lang_prompt_info"
  p6df::core::prompt::line::add "p6_lang_envs_prompt_info"
  p6df::core::prompt::lang::line::add R
}

######################################################################
#<
#
# Function: p6df::modules::R::Renv::init(dir)
#
#  Args:
#	dir -
#
#  Environment:	 DISABLE_ENVS HAS_RENV RENV_ROOT
#>
######################################################################
p6df::modules::R::Renv::init() {
  local dir="$1"

  [ -n "$DISABLE_ENVS" ] && return

  RENV_ROOT=$dir/viking/Renv

  if [ -x $RENV_ROOT/bin/renv ]; then
    export RENV_ROOT
    export HAS_RENV=1

    p6df::util::path_if $RENV_ROOT/bin
    eval "$(p6_run_code renv init - zsh)"
  fi
}

######################################################################
#<
#
# Function: str str = p6_R_env_prompt_info()
#
#  Returns:
#	str - str
#
#  Environment:	 RENV_ROOT _R_
#>
######################################################################
p6_R_env_prompt_info() {

  local str="renv_root=$RENV_ROOT"

  p6_return_str "$str"
}
