//
//  SetDeck.m
//  Matchismo
//
//  Created by Anthony Whitaker on 7/1/14.
//  Copyright (c) 2014 Anthony Whitaker. All rights reserved.
//

#import "SetDeck.h"

@implementation SetDeck

-(instancetype)init{
    self = [super init];
    
    if (self) {
        for (NSUInteger number = 1; number <= [SetCard maxNumber]; number++) {
            for (NSString* symbol in [SetCard validSymbols]) {
                for (NSNumber *shade in [SetCard validShades]) {
                    for (UIColor *color in [SetCard validColors]) {
                        SetCard *card = [[SetCard alloc] initWithNumber:number
                                                                 Symbol:symbol
                                                                  Shade:[shade integerValue]
                                                                  Color:color];
                        [self addCard:card];
                    }
                }
            }
        }
    }
    
    return self;
}

@end
