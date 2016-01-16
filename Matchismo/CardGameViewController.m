//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Anthony Whitaker on 11/14/13.
//  Copyright (c) 2013 Anthony Whitaker. All rights reserved.
//

#import "CardGameViewController.h"
#import "Deck.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()
@property (strong, nonatomic) CardMatchingGame* game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gamePlayModeControl;
@property (weak, nonatomic) IBOutlet UILabel *gameplayStatus;
@property (strong, nonatomic) NSMutableArray *gameplayMatchHistory;
@property (weak, nonatomic) IBOutlet UISlider *gameplayHistorySlider;
@end

@implementation CardGameViewController

static const int MINIMUM_CARDS_TO_MATCH = 2;

- (IBAction)touchCardButton:(UIButton *)sender {
    self.gamePlayModeControl.enabled = NO;
    NSUInteger chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseACardAtIndex:chosenButtonIndex];
    [self updateUI];
}

- (void) updateUI{
    for(UIButton* cardButton in self.cardButtons){
        NSUInteger cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card* card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
    }
    
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];

    NSString *lastAction = @"";
    
    if([self.game.lastChosenCards count]){
        lastAction = [self createNSStringFromNSArrayOfCards:self.game.lastChosenCards];
        
        if(self.game.lastScore >0 ){
            lastAction = [NSString stringWithFormat:@"Matched %@for %d points!", lastAction, self.game.lastScore];
        }
        else if (self.game.lastScore < 0){
            lastAction = [NSString stringWithFormat:@"%@don't match! %d point penalty!", lastAction, self.game.lastScore];
        }
    }
    
    
    self.gameplayStatus.text = lastAction;
    
    if (![lastAction isEqualToString:@""] && ![[self.gameplayMatchHistory lastObject] isEqualToString:lastAction]) {
        [self.gameplayMatchHistory addObject:lastAction];

    }
    
    float count =[self.gameplayMatchHistory count];
    self.gameplayHistorySlider.maximumValue = count == 0 ? 0 : count - 1;
    self.gameplayHistorySlider.value = self.gameplayHistorySlider.maximumValue;
    self.gameplayStatus.alpha = 1.00;
}

- (NSString *) titleForCard:(Card *)card{
    return card.isChosen ? card.contents : @"";
}

- (UIImage *) backgroundImageForCard:(Card *)card{
    return [UIImage imageNamed: card.isChosen ? @"cardFront" : @"cardBack"];
}

- (IBAction)touchNewGameButton:(UIButton *)sender {
    self.game = nil;
    self.gameplayMatchHistory = nil;
    self.gamePlayModeControl.enabled = YES;
    self.gameplayStatus.text = @"Tap a card to begin";
    [self updateUI];
    
}
- (IBAction)gamePlayModeControl:(UISegmentedControl *)sender {
    self.game.numberOfCardsForMatch = sender.selectedSegmentIndex + MINIMUM_CARDS_TO_MATCH;
}

- (IBAction)slideGameplayHistory:(UISlider *)sender {
    if([self.gameplayMatchHistory count])
        self.gameplayStatus.text = [self.gameplayMatchHistory objectAtIndex: sender.value];

    self.gameplayStatus.alpha = sender.value < sender.maximumValue ? .65 : 1.00;
}

- (NSString *)createNSStringFromNSArrayOfCards: (NSArray *) arrayOfCards{
    //    return [arrayOfCards componentsJoinedByString:@" "];
    NSString* output = @"";
    
    for(Card* card in arrayOfCards){
        output = [output stringByAppendingString:card.contents];
        output = [output stringByAppendingString:@" "];
    }
    
    return output;
}

- (Deck *) createDeck{
    return [[PlayingCardDeck alloc]init];
}

- (CardMatchingGame*)game{
    if(!_game) _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                         usingDeck:[self createDeck]];
    return _game;
}

- (NSMutableArray *) gameplayMatchHistory{
    if(!_gameplayMatchHistory) _gameplayMatchHistory = [[NSMutableArray alloc] init];
    return _gameplayMatchHistory;
}

@end