//
//  PlayingCard.m
//  Matchismo
//
//  Created by Anthony Whitaker on 11/15/13.
//  Copyright (c) 2013 Anthony Whitaker. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

@synthesize suit = _suit;   // Because we provide getter AND setter.

-(instancetype) initAsRank:(NSUInteger)rank ofSuit:(NSString *)suit{
    self = [super init];
    
    if(self){
        self.rank = rank;
        self.suit = suit;
        
        if (!rank) {
            self.rank = 0;
        }
    }
    
    return self;
}

- (NSString *) contents{
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

+ (NSArray *)rankStrings{
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

+ (NSUInteger) maxRank{
    return [[self rankStrings] count] -1;
}

- (void) setRank:(NSUInteger)rank{
    if(rank <= [PlayingCard maxRank]){
        _rank = rank;
    }
}

+ (NSArray *)validSuits{
    return @[@"♠️",@"♥️",@"♣️",@"♦️"];
}

- (NSString *) suit{
    return _suit ? _suit : @"?";
}
- (void)setSuit:(NSString *)suit{
    if([[PlayingCard validSuits] containsObject:suit]){
        _suit = suit;
    }
}

-(int) match:(NSArray *)otherCards{
    int score = 0;
    
    for(PlayingCard* otherCard in otherCards){
        if([otherCard isKindOfClass:[PlayingCard class]])
            score += [self matchAgainstAnotherCard:otherCard];
    }
    
    return score; 
}

-(int) matchAgainstAnotherCard:(PlayingCard *)otherCard{
    int score = 0;
    
    if(self.rank == otherCard.rank){
        score = 4;
    }
    else if([self.suit isEqualToString: otherCard.suit]){
        score = 1;
    }
    
    return score;
}

@end
