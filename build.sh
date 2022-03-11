#!/bin/bash

echo "Building mermaid2 version"
docker image build -t rfenn/mkdocs .

echo "Building markdownmermaid compatibility version"
docker image build -t rfenn/mkdocs:markdownmermaid -f Dockerfile.markdownmermaid .
