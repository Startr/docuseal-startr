# DocuSeal, Startr brand

The Startr-branded build of [DocuSeal](https://github.com/docusealco/docuseal), the open-source document signing service, as Startr LLC runs it at https://seal.startr.cloud.

It is DocuSeal 3.0.3, pinned by digest, plus a small overlay:

- Seven page templates show the Startr mark and name beside a "powered by DocuSeal" credit. The signing and start pages also link to this source.
- One stylesheet, `overlay/public/startr-theme.css`, sets Startr's colours and Nunito Sans.
- The favicons are Startr's.

Every other file is DocuSeal's own.

## Licence

AGPL-3.0, like DocuSeal, with DocuSeal's section 7(b) term: keep the "powered by DocuSeal" credit on every interactive page. See `LICENSE`, `LICENSE_ADDITIONAL_TERMS` and `NOTICE`. The Startr name and mark are not licensed for your own deployments (`NOTICE`, under section 7(e)).

## Build and run locally

```bash
COPYFILE_DISABLE=1 tar --no-xattrs --exclude .DS_Store --exclude .git -cf /tmp/docuseal.tar .
docker build -t docuseal-startr:local - < /tmp/docuseal.tar
docker run --rm -p 127.0.0.1:38080:3000 -v docuseal-test:/data/docuseal docuseal-startr:local
```

Open http://localhost:38080, create an admin, upload a PDF, send it and open the signing link. `--no-xattrs` matters on macOS: without it, tar adds extended-attribute headers that break the build. `captain-definition` lets CapRover build the same Dockerfile from that tarball.

## What the overlay changes

`overlay/` mirrors `/app` in the image.

| File | Change |
|---|---|
| `app/views/layouts/_head_tags.html.erb` | Title starts "Startr"; links `/startr-theme.css?v=1` |
| `app/views/shared/_logo.html.erb` | The Startr mark in place of DocuSeal's |
| `app/views/shared/_title.html.erb` | App header: "Startr · powered by DocuSeal" |
| `app/views/start_form/_docuseal_logo.html.erb` | "Startr", then "powered by DocuSeal · source" |
| `app/views/submit_form/_docuseal_logo.html.erb` | Signing page: the same |
| `app/views/submissions/_logo.html.erb` | Mark over "powered by DocuSeal" |
| `app/views/templates_share_link_qr/_logo.html.erb` | QR poster: mark, "Startr", credit |
| `public/favicon*`, `public/apple-*` (8 files) | Startr icons |

New files: `public/startr-theme.css`, `public/startr/` (the mark, the fonts and their licence) and `SOURCE.md`, which the image serves at `/startr/source.txt`. DocuSeal's own "Powered by DocuSeal" footers are untouched.

## Upgrading DocuSeal

1. Put the new release's index digest on the `FROM` line: `docker buildx imagetools inspect docuseal/docuseal:<version>`.
2. Diff the seven views between the old and new tags, and carry our change onto any that moved.
3. Check that DocuSeal still uses daisyUI 3 and the `docuseal` theme. daisyUI 4 renames the colour variables `startr-theme.css` sets.
4. Bump `?v=` in `_head_tags.html.erb` after a theme or mark change, and update the tags in `SOURCE.md`.
5. Test on a copy of real data first: a new DocuSeal version migrates its database when it starts.

## Branches

`develop` is the working branch. `master` and tags such as `v3.0.3-startr.1` record what runs in production.
