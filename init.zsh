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

  brew install openblas

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
#  Environment:	 CONFIGURE_OPTS XXX
#>
#/ Synopsis
#/  $XDG_CONFIG_HOME/radian/profile or $HOME/.config/radian/profile (Unix)
######################################################################
p6df::modules::R::langs() {

  # nuke the old one
  local previous=$(p6df::modules::R::Renv::latest::installed)
  Renv uninstall -f $previous

  # get the shiny one
  local latest=$(p6df::modules::R::Renv::latest)
  local configure_opts="\
	--without-x \
	--with-aqua \
	--enable-R-shlib \
	--without-blas \
	--disable-java"
  CONFIGURE_OPTS="$configure_opts" Renv install $latest 

  Renv global $latest
  Renv rehash

  # XXX: install packages - languageserver, lintr, httpgd

  # cli tools
  pip install radian

  p6_return_void
}

######################################################################
#<
#
# Function: p6df::modules::R::Renv::latest::installed()
#
#>
######################################################################
p6df::modules::R::Renv::latest::installed() {

  Renv install -l | p6_filter_select "[0-9]" | p6_filter_from_end "2" | p6_filter_spaces_strip
}

######################################################################
#<
#
# Function: p6df::modules::R::Renv::latest()
#
#>
######################################################################
p6df::modules::R::Renv::latest() {

  Renv install -l | p6_filter_select "[0-9]" | p6_filter_last "1" | p6_filter_spaces_strip
}

######################################################################
#<
#
# Function: p6df::modules::R::vscodes()
#
#>
######################################################################
p6df::modules::R::vscodes() {

  code --install-extension REditorSupport.r
  code --install-extension RDebugger.r-debugger
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

  p6df::core::lang::mgr::init "$P6_DFZ_SRC_DIR/viking/Renv" "R"

  p6_return_void
}

######################################################################
#<
#
# Function: str str = p6df::modules::R::env::prompt::info()
#
#  Returns:
#	str - str
#
#  Environment:	 RENV_ROOT
#>
######################################################################
p6df::modules::R::env::prompt::info() {

  local str="renv_root:\t  $RENV_ROOT"

  p6_return_str "$str"
}
