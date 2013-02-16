# Pluck

Pluck is an Objective-C OEmbed-ish library to support embedding images from URLs. This library isn't concerned with a particular standard, but whatever works including OEmbed, Open Graph, or if a service supports their own representation. It will fetch the data and return a standardized representation.

Pluck is in early stages of development and the API may change until 1.0.

## Installation

Pluck is available via CocoaPods, but you can also install it directly. The only dependency is AFNetworking 1.1 or later. Pluck requires ARC.

## Usage

`[PluckService itemForURL:url block:block]`

This is the primary method. It will figure out which service supports the URL, fetch it and return a `PLKItem`. You can also call the same method on any service directly.


## Services

Pluck currently supports:

- CloudApp
- YouTube
- Flickr

Support is planned for:
- Vimeo
- Twitter
- Instagram
- Dribbble
- ADN
- OpenGraph

## Extending

Pluck services are based on the `PLKService` class. To add another service, subclass `PLKService` and add support for these three class methods:

- `+ (BOOL)isPluckableURL:(NSURL *)url`
- `+ (void)itemForURL:(NSURL *)url block:(void (^)(PLKItem *item, NSError *error))block`
- `+ (PLKItem *)itemFromDictionary:(NSDictionary *)dictionary`

Check the existing services for examples.

## License

Licensed under the MIT license.

Copyright (c) 2012 Zach Waugh

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.