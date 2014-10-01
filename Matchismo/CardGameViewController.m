//
//  CardGameViewController.m
//  Matchismo
//
//  Created by 陈超 on 14-9-20.
//  Copyright (c) 2014年 Chao Chen. All rights reserved.
//

#import "CardGameViewController.h"
#import "Deck.h"
#import "PlayingCardDeck.h"
#import "PlayingCard.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()

@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gameModeControl;   //index: 0-2card, 1-3card
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (nonatomic) BOOL isFirstFlip;

@end

@implementation CardGameViewController

// setter of @property isFirstFlip, which will enable/disable gameModeControl
- (void) setIsFirstFlip:(BOOL)isFirstFlip
{
    if (isFirstFlip == YES) {   // set isFisrtFlip to YES means game starts
        [self.gameModeControl setEnabled:YES forSegmentAtIndex:0];
        [self.gameModeControl setEnabled:YES forSegmentAtIndex:1];
        self.gameModeControl.selectedSegmentIndex = 0;
        
    } else {
        [self.gameModeControl setEnabled:NO forSegmentAtIndex:0];
        [self.gameModeControl setEnabled:NO forSegmentAtIndex:1];
    }
        _isFirstFlip = isFirstFlip;
}

// getter of @property game, lazy instantiate
- (CardMatchingGame *)game
{
    if (!_game) {
        _game = [[CardMatchingGame alloc]initWithCardCount:[self.cardButtons count]
                                                 usingDeck:[[PlayingCardDeck alloc]init]];
        // lazy instantiate isFirstFlip
        _isFirstFlip = YES;
    }
    return _game;
}

- (IBAction)touchCardButton:(UIButton *)sender
{
    int chooseButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chooseButtonIndex];
    [self updateUI];
    if (self.isFirstFlip) {
        // 设置game mode
        self.game.mode = self.gameModeControl.selectedSegmentIndex;
        self.isFirstFlip = NO;
    }
}

- (void)updateUI
{
    for (UIButton *cardButton in self.cardButtons) {
        int cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score is: %d", self.game.score];
    self.messageLabel.text = self.game.scoreMessage;
}
- (NSString *)titleForCard:(Card *)card
{
    return card.isChosen?card.contents:@"";
}
- (UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.isChosen?@"cardfront":@"cardback"];
}

- (IBAction)restartGameButton:(id)sender {
    self.game = [[CardMatchingGame alloc]initWithCardCount:[self.cardButtons count]
                                                 usingDeck:[[PlayingCardDeck alloc] init]];
    self.isFirstFlip = YES;
    [self updateUI];
}


/*
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
*/
@end
