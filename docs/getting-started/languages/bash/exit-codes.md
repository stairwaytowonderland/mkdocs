# Exit Codes

## Overview

The exit codes are a major part of applications especially if called form other
commands. They help to easily detect if everything worked fine or anything made
problems.

Exit codes are returned from processes to their caller as an unsigned small integer with a value between 0..255. The definitions may vary. Other numbers can be used, but these are treated modulo 256, so exit -10 is equivalent to exit 246, and exit 257 is equivalent to exit 1.

## Status Code for Success

In general a **zero exit status indicates that a command succeeded**, a non-zero exit status indicates failure.

## All[*](#starnote) Status Codes

The exit codes are arranged alongside the UNIX default:

| Code | Description                                  |
| ---: | -------------------------------------------- |
|    0 | OK - no error                                |
|    1 | General error which should not occur         |
|    2 | Misuse of shell builtins                     |
|  124 | command times out                            |
|  125 | if a command itself fails                    |
|  126 | Command invoked cannot execute               |
|  127 | "command not found"                          |
|  128 | Invalid argument to exit                     |
|  129 | `SIGHUP` (Signal 1)                          |
|  130 | `SIGINT` like through ++ctrl+c++  (Signal 2) |
|  131 | `SIGQUIT` (Signal 3)                         |
|  132 | `SIGILL` (Signal 4)                          |
|  133 | `SIGTRAP` (Signal 5)                         |
|  134 | `SIGABRT` or `SIGIOT` (Signal 6)             |
|  135 | `SIGBUS` (Signal 7)                          |
|  136 | `SIGFPE` (Signal 8)                          |
|  137 | `SIGKILL`  (Signal 9)                        |
|  143 | `SIGTERM` (Signal 15)                        |
|  255 | Exit status out of range                     |

<a name="starnote"></a>
!!! note "*"
    Not all signals are listed here, they are mapped to `128 + signal number`.
