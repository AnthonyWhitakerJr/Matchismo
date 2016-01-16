//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Anthony Whitaker on 11/17/13.
//  Copyright (c) 2013 Anthony Whitaker. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, readwrite) NSInteger lastScore;
@property (nonatomic, readwrite) NSArray *lastChosenCards;
@property (nonatomic, strong) NSMutableArray *cards; /// of Card
@end


@implementation CardMatchingGame

static const int MATCH_BONUS = 4;
static const int MISMATCH_PENALTY = 2;
static const int COST_TO_CHOOSE = 1;

-(instancetype) init{
    return nil;
}

-(instancetype) initWithCardCount: (NSUInteger)count
                        usingDeck: (Deck *) deck
{
    self = [super init];
    
    if(self){
        for(int i = 0; i<count; i++){
            Card* card = [deck drawRandomCard];
            if(card){
                [self.cards addObject:card];
            }
            else{
                self = nil; break;
            }
            
        }
    }
    
    return self;
}

- (NSUInteger)numberOfCardsForMatch{
    return _numberOfCardsForMatch < 2 ? _numberOfCardsForMatch = 2 : _numberOfCardsForMatch;
}

- (NSMutableArray *)cards{
    if(!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

-(Card *) cardAtIndex: (NSUInteger) index{
    return index<[self.cards count] ? self.cards[index] : nil;
}

-(void) chooseACardAtIndex: (NSUInteger) index{
    Card *card = [self cardAtIndex:index];
    
    if(!card.isMatched){
        if(card.isChosen){
            card.chosen = NO;
        }
        else{
            self.lastScore = 0;
            self.lastChosenCards = [[self getChosenCards] arrayByAddingObject:card];
            
            if(self.numberOfCardsForMatch == [self.lastChosenCards count]){
                
                //match other chosen cards
                NSInteger matchScore = [self matchMultipleCards:self.lastChosenCards];
                
                if(matchScore){
                    self.lastScore += matchScore * MATCH_BONUS;
                    for(Card *chosenCard in self.lastChosenCards){ // Disable all chosen cards.
                        chosenCard.matched = YES;
                    }
                    
                }
                else{
                    self.lastScore -= MISMATCH_PENALTY;
                    for(Card *chosenCard in self.lastChosenCards){ // Flip all chosen cards down.
                        chosenCard.chosen = NO;
                    }
                    
                }
            }
            card.chosen = YES; // Leave the last selected card face up.
            self.score += self.lastScore - COST_TO_CHOOSE;
        }
    }
}

-(NSMutableArray *) getChosenCards{
    NSMutableArray* chosenCards = [[NSMutableArray alloc] init];
    
    for(Card* otherCard in self.cards){
        if(otherCard.isChosen && !otherCard.isMatched){
            [chosenCards addObject:otherCard];
        }
    }
    
    return chosenCards;
}

/// Matches every card against each given card.
- (NSInteger) matchMultipleCards: (NSArray *) cardsToMatch{
    int matchScore = 0;
    
    NSMutableArray* cardsLeftToMatch = [[NSMutableArray alloc] initWithArray:cardsToMatch];
    
    while([cardsLeftToMatch count] > 0){
        Card* card = [cardsLeftToMatch firstObject];
        [cardsLeftToMatch removeObject:card];
        matchScore += [card match:cardsLeftToMatch];
    }
    
    return matchScore;
}

@end