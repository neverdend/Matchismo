//
//  PlayingCardGameViewController.m
//  Matchismo
//
//  Created by 陈超 on 14-10-3.
//  Copyright (c) 2014年 Chao Chen. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "Deck.h"
#import "PlayingCardDeck.h"
#import "PlayingCardGame.h"

@interface PlayingCardGameViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *gameModeControl;   //index: 0-2card, 1-3card
@property (nonatomic) BOOL isFirstFlip; //第一张牌翻开后游戏开始，gameModeControl不能再选择，给game.mode赋值
@end

@implementation PlayingCardGameViewController

// implement abstact methods in super class
- (CardGame *)createGame
{
    return [[PlayingCardGame alloc]initWithCardCount:[self getCardCount] usingDeck:[[PlayingCardDeck alloc]init]];
}

- (void)updateCardButton:(UIButton *)cardButton using:(Card *)card
{
    [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
    [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
    cardButton.enabled = !card.isMatched;
}
- (NSString *)titleForCard:(Card *)card
{
    return card.isChosen?card.contents:@"";
}
- (UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.isChosen?@"cardfront":@"cardback"];
}

//end implement abstract methods in super class

// initialize isFirstFlip in viewDidLoad
- (void)viewDidLoad
{
    self.isFirstFlip = YES;
}

// 在isFirstFlip的setter中控制gameModeControl的enable/disable
- (void) setIsFirstFlip:(BOOL)isFirstFlip
{
    if (isFirstFlip == YES) {   // set isFisrtFlip to YES means game starts
        [self.gameModeControl setEnabled:YES forSegmentAtIndex:0];
        [self.gameModeControl setEnabled:YES forSegmentAtIndex:1];
        self.gameModeControl.selectedSegmentIndex = 0;
        
    } else {
        // 未被选中的segment会被disable掉（选中的不会被disable，为了提示玩家选中的是哪一个）
        [self.gameModeControl setEnabled:NO forSegmentAtIndex:1-self.gameModeControl.selectedSegmentIndex];
    }
    _isFirstFlip = isFirstFlip;
}

// override touchCardButton，设置isFirstFlip和game.mode的值
- (IBAction)touchCardButton:(UIButton *)sender
{
    [super touchCardButton:sender];
    // set isFirstFlip and game.mode
    if (self.isFirstFlip) {
        // 设置game mode
        ((PlayingCardGame *)self.game).mode = self.gameModeControl.selectedSegmentIndex;
        self.isFirstFlip = NO;
    }
}

// override touchRestartCardButton，设置isFirstFlip的值
- (IBAction)touchRestartGameButton:(UIButton *)sender
{
    [super touchRestartGameButton:sender];
    // 重置self.isFirstFlip（从而重置self.gameModeControl，重置self.game.mode）
    self.isFirstFlip = YES;
    
}

@end
