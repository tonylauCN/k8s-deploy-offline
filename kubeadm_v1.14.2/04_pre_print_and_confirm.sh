#!/bin/bash

sysctl -p

sysctl --system --pattern '^net.ipv6'
