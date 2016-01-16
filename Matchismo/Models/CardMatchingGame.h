//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Anthony Whitaker on 11/17/13.
//  Copyright (c) 2013 Anthony Whitaker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Card.h"

@interface CardMatchingGame : NSObject

/// Game score
@property (nonatomic, readonly) NSInteger score;

/// Points recieved for last action
@property (nonatomic, readonly) NSInteger lastScore;

/// Cards that were selected during last action
@property (nonatomic, readonly) NSArray *lastChosenCards;

/// Number of cards needed for a match. Never less than 2 cards.
@property (nonatomic) NSUInteger numberOfCardsForMatch;

/**
 * Designated initializer. Starts the game using the given deck.
 * @param count Number of cards to play game with.
 * @param deck Deck to draw cards from.
 * @return Valid instance if sucessful; nil otherwise.
 */
-(instancetype) initWithCardCount:(NSUInteger)count
                         usingDeck:(Deck *) deck;

/// Processes game logic for when a card is chosen.
-(void) chooseACardAtIndex: (NSUInteger)index;

/**
 * Gets card at given index.
 * @return card at given index.
 */
-(Card *) cardAtIndex: (NSUInteger) index;

@end