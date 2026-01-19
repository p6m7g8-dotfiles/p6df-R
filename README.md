# P6's POSIX.2: p6df-R

## Table of Contents

- [Badges](#badges)
- [Summary](#summary)
- [Contributing](#contributing)
- [Code of Conduct](#code-of-conduct)
- [Usage](#usage)
  - [Functions](#functions)
- [Hierarchy](#hierarchy)
- [Author](#author)

## Badges

[![License](https://img.shields.io/badge/License-Apache%202.0-yellowgreen.svg)](https://opensource.org/licenses/Apache-2.0)

## Summary

TODO: Add a short summary of this module.

## Contributing

- [How to Contribute](<https://github.com/p6m7g8-dotfiles/.github/blob/main/CONTRIBUTING.md>)

## Code of Conduct

- [Code of Conduct](<https://github.com/p6m7g8-dotfiles/.github/blob/main/CODE_OF_CONDUCT.md>)

## Usage

### Functions

#### p6df-R

##### p6df-R/init.zsh

- `p6df::modules::R::deps()`
- `p6df::modules::R::external::brew()`
- `p6df::modules::R::home::symlinks()`
- `p6df::modules::R::init(_module, dir)`
- `p6df::modules::R::langs()`
- `p6df::modules::R::vscodes()`
- `str str = p6df::modules::R::prompt::env()`
- `str str = p6df::modules::R::prompt::lang()`

#### p6df-R/lib

##### p6df-R/lib/Renv.sh

- `p6df::modules::R::Renv::latest()`
- `p6df::modules::R::Renv::latest::installed()`

## Hierarchy

```text
.
├── init.zsh
├── lib
│   └── Renv.sh
└── README.md

2 directories, 3 files
```

## Author

Philip M. Gollucci <pgollucci@p6m7g8.com>
