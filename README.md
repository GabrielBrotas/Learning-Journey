# Advanced-Journey
[![gh-pages](https://github.com/GabrielBrotas/Advanced-Journey/actions/workflows/gh-pages.yml/badge.svg)](https://github.com/GabrielBrotas/Advanced-Journey/actions/workflows/release.yml)

This repository contains documentation related to Architecture, DevOps, and Backend tools and concepts that I have been learning.

The documentation is organized in a mkdocs site and published using github pages. To view it, simply navigate to the [github-page](https://gabrielbrotas.github.io/Advanced-Journey/).

## Local Development

### With Docker

```sh
docker-compose up -d --build
```

Navigate to [localhost:8000](http://localhost:8000).

Changes in your workspace will automatically be reflected in your local browser.

### With Python

```sh
# Install dependencies
pip install -r requirements.txt

# Start the live-reloading docs server
mkdocs server
```
