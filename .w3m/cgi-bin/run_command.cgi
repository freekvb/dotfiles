#!/bin/sh

# run w3m command from clipboard
printf "%s\r\n" "w3m-control: $(xsel -opsb)";

