//
//  Deck.h
//  Matchismo
//
//  Created by Anthony Whitaker on 11/14/13.
//  Copyright (c) 2013 Anthony Whitaker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

- (void)addCard:(Card *)card atTop:(BOOL)atTop;
- (void)addCard:(Card *)card;

/**
 * Draws a random card from this deck.
 * @return The card drawn. Returns nil if the deck is empty.
 */
- (Card *)drawRandomCard;

/// Number of cards remaining in this deck.
-(NSUInteger)cardsRemaining;

@end
