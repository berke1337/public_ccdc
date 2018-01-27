#!/bin/bash

# Bash has dumb defaults, make them less dumb
set -euo pipefail

# Put the printable files in the to-print directory
# Also create subdirectories, because pandoc doesn't do that
# TODO: Clean this up, automatically mirror the directory structure in
# guides/ and cheat-sheets/ instead.
mkdir -p to-print
mkdir -p to-print/2017
mkdir -p to-print/2017/guides
mkdir -p to-print/2017/guides/hardening
mkdir -p to-print/2017/cheat-sheets
mkdir -p to-print/2017/cheat-sheets/services
mkdir -p to-print/2017/cheat-sheets/operating_systems

# Convert all markdown files in guides and cheat-sheets to PDFs for printing
for file in $(find {guides,cheat-sheets} -name '*.md'); do
  outputFile="to-print/2017/${file%.*}.pdf"
  pandoc "$file" -o "$outputFile" -V geometry:'top=1cm, bottom=1cm, left=1cm, right=1cm'
done
