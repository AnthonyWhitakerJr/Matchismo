//
//  SetCard.h
//  Matchismo
//
//  Created by Anthony Whitaker on 7/1/14.
//  Copyright (c) 2014 Anthony Whitaker. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card

@property (nonatomic) NSUInteger number;
@property (strong, nonatomic) NSString *symbol;
@property (nonatomic) NSUInteger shade;
@property (strong, nonatomic) UIColor *color;

-(instancetype)initWithNumber:(NSUInteger)number
                       Symbol:(NSString *)symbol
                        Shade:(NSUInteger)shade
                        Color:(UIColor *)color;

/// Max number of symbols on card.
+(NSUInteger)maxNumber;
+(NSArray *)validSymbols;
+(NSArray *)validShades;
+(NSArray *)validColors;

@end
