bitbar-kinnosuke-cli
====================

![This way](https://raw.githubusercontent.com/udzura/bitbar-kinnosuke-cli/master/screemshot.png)

## Pre-requirement

[`kinnosuke-clocking-cli`](https://github.com/yano3/kinnosuke-clocking-cli/) version equal to or after `0.2.0`.
Please put kinnosuke-clocking-cli to `/usr/local/bin`.

## Install

Put `kin.10s.sh` to your bitbar plugin directory.

## Config

Please put `~/.kinnosuke` to your $HOME:

```bash
export KINNOSUKE_COMPANYCD="foobar"
export KINNOSUKE_LOGINCD="5471"
export KINNOSUKE_PASSWORD="hogehoge123"
```

NOTE: Environment vars are the same ones as what `kinnosuke-clocking-cli` uses.
