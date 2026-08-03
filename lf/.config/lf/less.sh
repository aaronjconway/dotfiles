#!/bin/sh
# Shell script to start Vim with less.vim.
# Read stdin if no arguments were given and stdin was redirected.

if test -t 1; then
    echo "stdout: terminal"
elif test -p /proc/$$/fd/1; then
    echo "stdout: pipe"
else
    echo "stdout: file or other"
fi
