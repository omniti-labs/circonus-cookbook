maintainer       "OmniTI"
maintainer_email "sa@omniti.com"
license          "All rights reserved"
description      "Circonus API client lib, resources, and such"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.2"
name             "circonus"

recommends 'java' # depended on by the broker recipe

recipe "circonus::broker", "Installs the basics of a Circonus enterprise broker, to be manually configured via http"
