#!/bin/bash

echo: "find the script to expand:"
find / -type f \( -name "*.sh" -o -name "*.bash" -o -name "*.zsh" -o -name "*.ksh" \) 2>/dev/null

echo ""
echo "find the script of str #!..."
find / -type f -exec grep -l "^#!/bin/.*sh" {} + 2>/dev/null
find / -type f -exec grep -l "^#!/usr/bin.*sh" {} + 2>/dev/null
find / -type f -exec grep -l "^#!/bin/bash" {} + 2>/dev/null
find / -type f -exec grep -l "^#!/usr/bin/bash" {} 2>/dev/null
