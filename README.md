# Kasdown

A utility for turning Markdown "scripts" into interactive web-pages

## Usage

### Output

Outputs directly to `stdout`:

```bash
kasdown script.md > output.html
```

### Server

Runs a local web-server (defaults to port `8000`):

```bash
kasdown -s script.md
```

Runs a local web-server with specific port:

```bash
kasdown -p 8000 script.md
```
