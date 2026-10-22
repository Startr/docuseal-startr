# DocuSeal with the Startr brand (https://github.com/Startr/docuseal-startr),
# built by CapRover from a tarball of this repository (captain-definition). overlay/
# mirrors /app: seven views and the favicons replace DocuSeal's, and
# public/startr-theme.css plus public/startr/ are new. Every other file is
# DocuSeal's own, so an upgrade is a new digest on the FROM line and a diff of
# the seven views against the new tag (README.md, "Upgrading").
# AGPLv3 with a section 7(b) term: the "powered by DocuSeal" credit stays on
# every page, and SOURCE.md is served at /startr/source.txt.
# 3.0.3 is what seal.startr.cloud served on 2026-10-22 (/version, pack hashes).
FROM docuseal/docuseal:3.0.3@sha256:4d029dd71693924fe4c03e4caf01428b9c967cb10708ceab993aa6dfb556e9b0
COPY --chown=docuseal:docuseal overlay/ /app/
COPY --chown=docuseal:docuseal SOURCE.md /app/public/startr/source.txt
