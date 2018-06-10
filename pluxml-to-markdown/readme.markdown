# PluXml to Markdown

Get rid of XML + HTML and take some sweet Markdown.

### Warnings

You'll loss your comments and maybe articles with more than one category affected to will be skipped.

### Requirements

* python3.3
* python3.3
* python3.3
* python3.3

### How to use?

For the moment, if you use [Pelican](http://getpelican.com) do the following:

```bash
git clone https://github.com/Leryan/pluxml-to-markdown.git pluxml-to-markdown
cd pluxml-to-markdown
python3 pluxml-to-markdown.py --pluxml-datas /path/to/your/pluxml/directory/data --md-datas /path/to/pelican/content --converter PelicanMD
```

Note that even if you don't use Pelican, you should use PelicanncMD. **nc** for **non categorized**, it means you'll not have any subdir in the content Pelican folder. The default PelicanMD does. With PelicanncMD, the category is written in the file name and into.

There is also an Octopress (OctopressMD) converter, but please, if you want to use it and if it doesn't work, send an issue here.

Finally, use SimpleMD if you just want Markdown. You'll lose every tags, category, date, author… informations.

```bash
cd /path/to/pelican
make html && make serve
```

See the magic!

## How can I write a converter?

Huh… understand yourself how it works or wait for doc :)
