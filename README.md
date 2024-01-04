# Learning-Journey

[![gh-pages](https://github.com/GabrielBrotas/Learning-Journey/actions/workflows/gh-pages.yml/badge.svg)](https://github.com/GabrielBrotas/Learning-Journey/actions/workflows/release.yml)

This project contains a collection of notes, code snippets, and other resources that I've found useful while diving into Cloud, Architecture, DevOps, Backend tools, and more.

The documentation is organized in a mkdocs site and published using github pages. To view it, simply navigate to the [github-page](https://gabrielbrotas.github.io/Learning-Journey/).

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
