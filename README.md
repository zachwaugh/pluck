# Pluck

Pluck is an Objective-C library for grabbing content from OEmbed (and similar) supporting sites. This library isn't concerned with a particular standard, but whatever works including OEmbed, Open Graph, Twitter Cards, or if a service supports their own format. It will fetch the data and return a standardized representation.

Pluck is in early stages of development and the API may change until 1.0. This is currently geared toward the use case of display images from a service in a client app (i.e. [Flint](http://giantcomet.com/flint)), but can be extended.

## Installation

Pluck is available via CocoaPods, but you can also install it directly. Pluck requires ARC and AFNetworking. 

## Usage

`[PluckService itemForURL:url completion:block]`

This is the primary method. It will figure out which service supports the URL, fetch it and return a `PLKItem`. You can also call the same method on any service directly. Check the demo project and tests for more examples


## Demo

There is a PluckDemo project that has a demo Mac app for entering a URL and returning the data and image. The Xcode project also contains the tests.

![Pluck demo screenshot](http://cl.ly/image/3S3t2X3K3y0z/Image%202013-04-06%20at%203.19.57%20PM.png)


## Services

Pluck currently supports:
- CloudApp
- YouTube
- Vimeo
- Flickr
- Instagram
- Dribbble
- Droplr
- Rdio

Support is planned for:
- Twitter
- ADN
- Vine

## Extending

Pluck services are based on the `PLKService` class. To add another service, subclass `PLKService` and add support for these three class methods:

- `+ (BOOL)isSupportedURL:(NSURL *)url`
- `+ (void)itemForURL:(NSURL *)url completion:(void (^)(PLKItem *item, NSError *error))block`
- `+ (PLKItem *)parseItemFromDictionary:(NSDictionary *)dictionary`

Check the existing services for examples.

## License

Licensed under the MIT license.

Copyright (c) 2012 Zach Waugh

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.