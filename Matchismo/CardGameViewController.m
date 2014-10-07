//
//  CardGameViewController.m
//  Matchismo
//
//  Created by 陈超 on 14-9-20.
//  Copyright (c) 2014年 Chao Chen. All rights reserved.
//

#import "CardGameViewController.h"
#import "Deck.h"
#import "GameHistoryViewController.h"

@interface CardGameViewController ()

@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *cardViews;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UISlider *messageSlider;
@property (nonatomic, strong) NSMutableArray *messageLog;
@end

@implementation CardGameViewController

// 初始化property game，并准备UI
- (void)viewDidLoad
{
    // 设置card的gesture recognizer
    for (UIView *cardView in self.cardViews) {
        [cardView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapCardView:)]];
    }
    
    self.game = [self createGame];
    [self updateUI];
}

// used to initiate @property game. ABSTRACT!
- (CardGame *)createGame
{
    return nil;
}
// used by subclass to implement createGame
- (NSUInteger)getCardCount
{
    return [self.cardViews count];
}

// lazy instantiate @property messageLog
- (NSMutableArray *)messageLog
{
    if (!_messageLog)    _messageLog = [[NSMutableArray alloc]init];
    return _messageLog;
}

- (IBAction)tapCardView:(UITapGestureRecognizer *)gesture
{
    int chooseCardIndex = [self.cardViews indexOfObject:gesture.view];
    [self.game chooseCardAtIndex:chooseCardIndex];
    [self updateUI];
    [self updateMessageLog];
}


// 更新所有牌、scoreLabel、messageLabel的显示
- (void)updateUI
{
    for (UIView *cardView in self.cardViews) {
        int cardIndex = [self.cardViews indexOfObject:cardView];
        Card *card = [self.game cardAtIndex:cardIndex];
        [self updateCardView:cardView using:card];
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    self.messageLabel.alpha = 1;
    self.messageLabel.text = self.game.scoreMessage;
    [self.messageSlider setValue:self.messageSlider.maximumValue animated:NO];
}
// used by updateUI, 更新每张牌的显示. ABSTRACT!
- (void)updateCardView:(UIView *)cardView using:(Card *)card
{
    // ABSTRACT!
}

// 更新messageLog
- (void)updateMessageLog
{
    if (![self.game.scoreMessage isEqualToString:@""])
        [self.messageLog addObject:self.game.scoreMessage];
}

- (IBAction)touchRestartGameButton:(UIButton *)sender {
    // 重置self.game
    self.game = [self createGame];
    // 重置self.messageLog，在getter中会lazy instantiate为空数组
    self.messageLog = nil;
    // 刷新UI
    [self updateUI];
}

// 当messageSlider的值变化时，更改messageLabel的内容
- (IBAction)slideMessageSlider:(id)sender {
    // messageLog为空时直接退出
    if ([self.messageLog count] == 0) {
        self.messageLabel.text = @"";
        return;
    }
    
    //计算对应第几条log
    int index = (int)(self.messageSlider.value * [self.messageLog count]);
    if (index == [self.messageLog count])   index -= 1; //messageSlider.value == 1的情况
    // 设置scoreLabel透明度
    if (index == [self.messageLog count] - 1) {
        self.messageLabel.alpha = 1;
    } else {
        self.messageLabel.alpha = 0.5;
    }
    // 设置scoreLabel内容
    self.messageLabel.text = self.messageLog[index];
}

// prepare for segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Show History"]) {
        if ([segue.destinationViewController isKindOfClass:[GameHistoryViewController class]]) {
            GameHistoryViewController *ghvc = (GameHistoryViewController *)segue.destinationViewController;
            ghvc.messageLog = self.messageLog;
            
        }
    }
}
@end
