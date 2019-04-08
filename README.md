# MkDocs Image

Simple image with [MkDocs](https://www.mkdocs.org). MkDocs give your project

- Simple, clean presentation of your Markdown
- A search interface
- Plain html you can serve from any webserver
- A simple webserver with live updates when you hack on your docs

## Using this image

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
```

### Example shell script to call mkdocs

```shell
#!/bin/bash

PORT=${PORT:-8000}
echo "Starting MkDocs container. Listening on localhost port ${PORT}"
docker container run --rm -p ${PORT}:8000 -v ${PWD}:/workdir rfenn/mkdocs $@
```

The default action is to serve your documentation on port 8000.

- View with any browser on `http://localhost:8000`
- Change the port by exporting `PORT=9999` or similar
- `build` will build static html pages in the `site` directory
- `--help` will show a few other options