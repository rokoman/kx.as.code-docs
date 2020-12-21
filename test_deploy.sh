#!/bin/bash

# Run build and start debug server on localhost:8000
./createKxDocs.sh
mkdocs build --clean
mkdocs serve
