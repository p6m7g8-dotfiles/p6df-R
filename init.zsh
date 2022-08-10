# shellcheck shell=bash
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

  p6_return_void
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

  p6_return_void
}

######################################################################
#<
#
# Function: p6df::modules::R::Renv::init(dir)
#
#  Args:
#	dir -
#
#  Environment:	 HAS_RENV P6_DFZ_LANGS_DISABLE RENV_ROOT
#>
######################################################################
p6df::modules::R::Renv::init() {
  local dir="$1"

  local RENV_ROOT=$dir/viking/Renv
  if p6_string_blank "$P6_DFZ_LANGS_DISABLE" && p6_file_executable "$RENV_ROOT/bin/renv"; then
    p6_env_export RENV_ROOT "$RENV_ROOT"
    p6_env_export HAS_RENV 1

    p6_path_if $RENV_ROOT/bin
    eval "$(renv init - zsh)"
  fi

  p6_return_void
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

  local str="renv_root:\t  $RENV_ROOT"

  p6_return_str "$str"
}
