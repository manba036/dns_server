#!/bin/sh

mkdir -p data && cp dnsmasq.conf data/
mkdir -p data/dnsmasq.d && cp dnsmasq.conf data/dnsmasq.d/