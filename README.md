# Pluck

Objective-C OEmbed/OpenGraph-ish library to support embedding images from URLs. This library isn't concerned with a particular standard, but whatever works. It will use OEmbed in some cases, but also supports OpenGraph as well as some services that provide a different, but similar representation.

## Usage

`[PluckEmbed isEmbeddableURL:url]`

`[PluckEmbed embedForURL:url block:block]`

## Services

Pluck will support:

- OpenGraph
- CloudApp
- Dribbble
- Instagram
- YouTube
- Vimeo
- Flickr
- Twitter

