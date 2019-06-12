#!/usr/bin/env bash
show_spinner()
{
  local -r pid="${1}"
  local -r delay='0.4'
  local spinstr='\|/-'
  local temp
  while ps a | awk '{print $1}' | grep -q "${pid}"; do
    temp="${spinstr#?}"
    printf " [%c]  " "${spinstr}"
    spinstr=${temp}${spinstr%"${temp}"}
    sleep "${delay}"
    printf " \r"
  done
  printf " \r"
}

("$@") &
show_spinner "$!"
