//
//  Card.m
//  Matchismo
//
//  Created by Anthony Whitaker on 11/14/13.
//  Copyright (c) 2013 Anthony Whitaker. All rights reserved.
//

#import "Card.h"

@implementation Card

- (NSString *)description {
    return self.contents;
}

- (int) match:(NSArray *)otherCards
{
    int score = 0;
    
    for (Card *card in otherCards){
        if([card isKindOfClass: [Card class]])
        if([card.contents isEqualToString:self.contents])
            score = 1;
    }
    
    return score;
}

// Attempt at toString() method for printing in array
//- (NSString *) description{
//    return self.contents;
//}

@end
