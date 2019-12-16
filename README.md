# MkDocs Image

Simple image with [MkDocs](https://www.mkdocs.org). MkDocs give your project

- Simple, clean presentation of your Markdown
- A search interface
- Plain html you can serve from any webserver
- A simple webserver with live updates when you hack on your docs

## Using this image

### Quick Start

If your project is already configured, simply run:

```shell
docker container run --rm -p 8000:8000 -v $(pwd):/app rfenn/mkdocs
```
And point your browser to [http://localhost:8000/](http://localhost:8000)

### Prepare your docs

1) Your site should have a `docs` directory, with Markdown files
1) A `mkdocs.yml` file with project metadata

### Example `mkdocs.yml`

```yaml
site_name: My Docker Project
theme: material
repo_name: My Docker Project
use_directory_urls: false
repo_url: https://<path_to_your_git_repository>
markdown_extensions:
  - smarty
  - extra
  - admonition
  - footnotes
  - tables
plugins:
  - markdownmermaid
  - search
extra_javascript:
  - https://unpkg.com/mermaid@8.4/dist/mermaid.min.js
extra_css:
  - https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.11.2/css/all.css
```

### Example shell script to call mkdocs

Simple shell script to serve your project docs on localhost.

```shell
#!/bin/bash

PORT=${PORT:-8000}
echo "Starting MkDocs container. Listening on localhost port ${PORT}"
docker container run --rm -p ${PORT}:8000 -v ${PWD}:/app rfenn/mkdocs $@
```

The default action is to serve your documentation on port 8000.

- View with any browser on `http://localhost:8000`
- Change the port by exporting `PORT=9999` or similar
- `build` will build static html pages in the `site` directory
- `--help` will show a few other options

### Serve your docs with [Nginx](https://hub.docker.com/_/nginx)

In this example, we build the docs as html, then put them into an Nginx image.

Example `Dockerfile` (in to the top level directory,  above `docs`):

```
FROM rfenn/mkdocs as mkdocs
COPY * /app
RUN mkdocs build

FROM nginx
COPY --from=mkdocs /app/site /usr/share/nginx/html
```

Build your Nginx image:

```shell
$ docker image build -t me/mydocs .
```

And run it:

```shell
$ docker container run --rm -d --name mydocs -p 8888:80 me/mydocs
```

### Serve your docs locally with docker cli-plugins

If your local docker cli has [plugins](https://github.com/docker/cli/issues/1534) enabled, you can substitute the above shell script with a plugin to the docker cli

```shell
#!/usr/bin/env bash
PORT=${PORT:-8000}

if [[ "$1" == "docker-cli-plugin-metadata" ]]; then
cat <<EOF
{
        "Name": "MkDocs local server",
        "SchemaVersion": "0.1.0",
        "Vendor": "Russell Fenn",
        "Version": "v19.08.00",
        "ShortDescription": "Serve MkDocs documents locally, using `mkdocs.yml` in the current directory."
}
EOF
exit
fi

if [[ "$2" == "-p" ]]; then
    PORT=$3
    shift
    shift
fi

shift

echo "Starting MkDocs container. Listening on localhost port ${PORT}"
exec docker container run --rm -p ${PORT}:8000 -v ${PWD}:/app rfenn/mkdocs $@
```

Now run as:

```shell
docker mkdocs
```