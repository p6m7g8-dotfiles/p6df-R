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
    p6m7g8-dotfiles/p6df-python
    viking/Renv
    viking/R-build
  )
}

######################################################################
#<
#
# Function: p6df::modules::R::external::brew()
#
#>
######################################################################
p6df::modules::R::external::brew() {

  p6df::core::homebrew::cli::brew::install openblas

  p6_return_void
}

######################################################################
#<
#
# Function: p6df::modules::R::home::symlinks()
#
#  Environment:	 P6_DFZ_SRC_DIR
#>
######################################################################
p6df::modules::R::home::symlinks() {

  p6_dir_mk "$P6_DFZ_SRC_DIR/viking/Renv/plugins"
  p6_file_symlink "$P6_DFZ_SRC_DIR/viking/Renv/plugins/R-build" "$P6_DFZ_SRC_DIR/viking/R-build"

  p6_return_void
}

######################################################################
#<
#
# Function: p6df::modules::R::langs()
#
#>
#/ Synopsis
#/  $XDG_CONFIG_HOME/radian/profile or $HOME/.config/radian/profile (Unix)
######################################################################
p6df::modules::R::langs() {

  # nuke the old one
  local previous=$(p6df::modules::R::Renv::latest::installed)
  Renv uninstall -f "$previous"

  # get the shiny one
  local latest=$(p6df::modules::R::Renv::latest)
  local configure_opts="\
	--without-x \
	--with-aqua \
	--enable-R-shlib \
	--without-blas \
	--disable-java"
  CONFIGURE_OPTS="$configure_opts" Renv install "$latest"

  Renv global "$latest"
  Renv rehash

  # XXX: install packages - languageserver, linter, httpgd

  # cli tools
  pip install radian

  p6_return_void
}

######################################################################
#<
#
# Function: p6df::modules::R::vscodes()
#
#>
######################################################################
p6df::modules::R::vscodes() {

  p6df::modules::vscode::extension::install REditorSupport.r
  p6df::modules::vscode::extension::install RDebugger.r-debugger

  p6_return_void
}

######################################################################
#<
#
# Function: p6df::modules::R::init(_module, dir)
#
#  Args:
#	_module -
#	dir -
#
#  Environment:	 P6_DFZ_SRC_DIR
#>
######################################################################
p6df::modules::R::init() {
  local _module="$1"
  local dir="$2"

  p6df::core::lang::mgr::init "$P6_DFZ_SRC_DIR/viking/Renv" "R"

  p6_bootstrap "$dir"

  p6_return_void
}

######################################################################
#<
#
# Function: str str = p6df::modules::R::prompt::env()
#
#  Returns:
#	str - str
#
#  Environment:	 RENV_ROOT
#>
######################################################################
p6df::modules::R::prompt::env() {

  local str="renv_root:\t  $RENV_ROOT"

  p6_return_str "$str"
}

######################################################################
#<
#
# Function: str str = p6df::modules::R::prompt::lang()
#
#  Returns:
#	str - str
#
#>
######################################################################
p6df::modules::R::prompt::lang() {

  local str
  str=$(p6df::core::lang::prompt::lang \
    "R" \
    "Renv version-name 2>/dev/null" \
    "R --version | p6_filter_row_select ' version ' | p6_filter_column_pluck 3")

  p6_return_str "$str"
}
