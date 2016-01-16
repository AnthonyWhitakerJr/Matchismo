//
//  Card.h
//  Matchismo
//
//  Created by Anthony Whitaker on 11/14/13.
//  Copyright (c) 2013 Anthony Whitaker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (strong, nonatomic) NSString *contents;

@property (nonatomic, getter = isChosen) BOOL chosen;
@property (nonatomic, getter = isMatched) BOOL matched;

/**
 * Performs one to many match of this card against given cards.
 * @Returns High number for a really good match, low number for a poor match and 0 when no matches occur.
 */
- (int) match: (NSArray *) otherCards;

@end
