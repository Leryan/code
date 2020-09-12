# webpandoc

Very tiny ugly thing that launches pandoc and allow only markdown -> pdf/odt for the moment.

Feel free to contribute ;-)

# Install & use

### Server and Client

From Git repository:

```bash
pip install git+https://github.com/Leryan/python-webpandoc.git
```

From Pypi:

```bash
pip install webpandoc
```

You can use a virtualenv:

```bash
virtualenv pyvenv-webpandoc
source pyvenv-webpandoc/bin/activate
pip install git+https://github.com/Leryan/python-webpandoc.git
```

Then, run it:

```bash
webpandoc
```

You must install pandoc, and for PDF, install many LaTeX things… like… most things… time to burn your Internet link.

### Client:

For direct use:

```bash
curl -XPOST http://localhost:5000/api \
  -F 'sourceFile=@"your/file.markdown"' \
  -F 'format_to=pdf' -F 'raw=1' > your/file.pdf
```

For use in a JSON-compliant application:

```bash
curl -XPOST http://localhost:5000/api \
  -F 'sourceFile=@"your/file.markdown"' \
  -F 'format_to=pdf'
```

Python client:

```bash
webpandoc-client --sourcefile test.markdown \
    --server http://localhost:5000/api \
    --destfile test.pdf
```

### About sourceFile, sourceArchive and archiveIndex

The `sourceFile` parameter can be replaced by `sourceArchive`, a ZIP archive containing all files you need, like pictures, to get a complete document.

In combination to `sourceArchive`, add `archiveIndex` with the name of the file you want to convert. By default, it is `webpandoc_index`.

Example:

```bash
curl -XPOST http://localhost:5000/api \
  -F 'sourceArchive=@"project.zip"' \
  -F 'format_to=pdf'
```

`project.zip` could contain something like this:

```
project.zip
 \_ webpandoc_index
 \_ pics
    \_ main.png
    \_ chapter.png
 ...
```

ZIP command hint:

```
zip -r project.zip README.md pics yourfiles ...
```


Parameters:

 * `format_from`: `markdown`
 * `format_to`: `pdf`, `odt`
 * `raw`: get raw file instead of JSON + base64-encoded
 * `pandoc_writer`: `latex`, `odt`
