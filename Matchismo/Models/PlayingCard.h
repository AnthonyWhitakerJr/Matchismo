//
//  PlayingCard.h
//  Matchismo
//
//  Created by Anthony Whitaker on 11/15/13.
//  Copyright (c) 2013 Anthony Whitaker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface PlayingCard : Card

/**
 * Creates a playing card with the given rank and suit.
 * If given rank or suit are invalid, this card will not initialize properly.
 * @param rank Rank of card.
 * @param suit Suit of card.
 * @return A new instance of playing card if given rank & suit are valid;
 * otherwise returns nil.
 */
-(instancetype) initAsRank:(NSUInteger)rank ofSuit:(NSString *)suit;

/// Suit of this card. Returns ? if not set.
@property (strong, nonatomic) NSString *suit;

/// Rank of this card. Returns ? if not set.
@property (nonatomic) NSUInteger rank;

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;

@end
