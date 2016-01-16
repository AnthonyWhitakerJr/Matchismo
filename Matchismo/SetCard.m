//
//  SetCard.m
//  Matchismo
//
//  Created by Anthony Whitaker on 7/1/14.
//  Copyright (c) 2014 Anthony Whitaker. All rights reserved.
//

#import "SetCard.h"

@interface SetCard()
@property (strong, nonatomic) NSDictionary *propertyMap;
@end


@implementation SetCard

// FIXME: ARWJ: Are these necessary??
@synthesize number = _number;   // Because we provide getter AND setter.
@synthesize symbol = _symbol;   // Because we provide getter AND setter.
@synthesize shade = _shade;   // Because we provide getter AND setter.
@synthesize color = _color;   // Because we provide getter AND setter.


-(instancetype)init{
    self = [super init];
    
    if(self){
        self.propertyMap = [[NSDictionary alloc]initWithObjectsAndKeys:
                            nil, @"number",
                            nil, @"symbol",
                            nil, @"shade",
                            nil, @"color",
                            nil];
    }
    
    return self;
}

-(instancetype)initWithNumber:(NSUInteger)number
                       Symbol:(NSString *)symbol
                        Shade:(NSUInteger)shade
                        Color:(UIColor *)color
{
    self = [self init];
    
    if(self){
        self.number = number;
        self.symbol = symbol;
        self.shade = shade;
        self.color = color;
    }
    
    return self;
}

+(NSUInteger)maxNumber{
    return 3;
}
-(NSUInteger)number{
    NSNumber *num = [self.propertyMap objectForKey:@"number"];
    return [num integerValue];
}
-(void)setNumber:(NSUInteger)number{
    if (number <= [SetCard maxNumber]) {
        [self.propertyMap setValue:[NSNumber numberWithInteger:number] forKey:@"number"];
    }
}

+(NSArray *)validSymbols{
    return @[@"▲",@"●",@"■"];
}
- (NSString *) symbol{
    return [self.propertyMap objectForKey:@"symbol"];
}
-(void)setSymbol:(NSString *)symbol{
    if([[SetCard validSymbols] containsObject:symbol]){
        [self.propertyMap setValue:symbol forKey:@"symbol"];
    }
}

+(NSArray *)validShades{
    return @[@0, @.5, @1];
}
-(NSUInteger)shade{
    NSNumber *shading = [self.propertyMap objectForKey:@"shade"];
    return [shading integerValue];
}
-(void)setShade:(NSUInteger)shade{
    NSNumber *shading = [NSNumber numberWithInteger:shade];
    if ([[SetCard validShades] containsObject:shading]) {
        [self.propertyMap setValue:shading forKey:@"shade"];
    }
}


+(NSArray *)validColors{
    return @[[UIColor redColor], [UIColor blueColor], [UIColor greenColor]];
}
-(UIColor*)color{
    return [self.propertyMap objectForKey:@"color"];
}
-(void)setColor:(UIColor *)color{
    if ([[SetCard validColors] containsObject:color]) {
        [self.propertyMap setValue:color forKey:@"color"];
    }
}



/**
 * Matches this card against an array of other SetCards.
 * @param otherCards array of other SetCards to match.
 * @return 1 if this card creates a set with given cards, 0 otherwise.
 */
-(int) match:(NSArray *)otherCards{
    int score = 1;
    
    NSEnumerator *keys = [self.propertyMap keyEnumerator];
    NSString *key;
    
    while (key = [keys nextObject]) {
        score *= [self matchOtherCards:otherCards OnProperty:key];
    }
    
    return score;
}

-(int) matchOtherCards:(NSArray *)otherCards OnProperty:(NSString *)property{
    if ([self areAllTheSame:otherCards OnProperty:property] ||
        [self areAllDifferent:otherCards OnProperty:property])
    {
        return 1;
    }
    
    return 0;
}

/**
 * Checks if all given cards have the same value for the given property.
 * @return True if all values are the same, false otherwise.
 */
-(BOOL)areAllTheSame:(NSArray *)otherCards OnProperty:(NSString *)property{
    for(id object in otherCards){
        if([object isKindOfClass:[SetCard class]]){
            SetCard *otherCard = (SetCard*)object;
            if([self.propertyMap objectForKey:property] != [otherCard.propertyMap objectForKey:property])
                return false;
        }
    }
    return true;
}

/**
 * Checks if all given cards have different values for the given property.
 * @return True if all values are different, false otherwise.
 */
-(BOOL)areAllDifferent:(NSArray *)otherCards OnProperty:(NSString *)property{
    for(id object in otherCards){
        if([object isKindOfClass:[SetCard class]]){
            SetCard *otherCard = (SetCard*)object;
            if([self.propertyMap objectForKey:property] == [otherCard.propertyMap objectForKey:property])
                return false;
        }
    }
    return true;
}



@end
