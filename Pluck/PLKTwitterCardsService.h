//
//  PLKTwitterCardsService.h
//  Pluck
//
//  Created by Zach Waugh on 2/18/13.
//  Copyright (c) 2013 Zach Waugh. All rights reserved.
//

#import "PLKService.h"

@interface PLKTwitterCardsService : PLKService

+ (NSDictionary *)twitterCardsAttributesFromHTMLData:(NSData *)data;

@end
