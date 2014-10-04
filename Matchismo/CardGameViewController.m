//
//  CardGameViewController.m
//  Matchismo
//
//  Created by 陈超 on 14-9-20.
//  Copyright (c) 2014年 Chao Chen. All rights reserved.
//

#import "CardGameViewController.h"
#import "Deck.h"
#import "PlayingCard.h"
#import "PlayingCardGame.h"

@interface CardGameViewController ()

@property (strong, nonatomic) PlayingCardGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gameModeControl;   //index: 0-2card, 1-3card
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UISlider *messageSlider;
@property (nonatomic) BOOL isFirstFlip; //第一张牌翻开后游戏开始，gameModeControl不能再选择，给game.mode赋值
@property (nonatomic, strong) NSMutableArray *messageLog;
@end

@implementation CardGameViewController

// setter of @property isFirstFlip, 在isFirstFlip的setter中控制gameModeControl的enable/disable
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

// getter of @property game, lazy instantiate
- (PlayingCardGame *)game
{
    if (!_game) {
        _game = [[PlayingCardGame alloc]initWithCardCount:[self.cardButtons count]
                                                 usingDeck:[self createDeck]];
        // lazy instantiate isFirstFlip
        _isFirstFlip = YES;
    }
    return _game;
}
// used to instantiate @property game
- (Deck *)createDeck    // abstract
{
    return nil;
}

// lazy instantiate @property messageLog
- (NSMutableArray *)messageLog
{
    if (!_messageLog)    _messageLog = [[NSMutableArray alloc]init];
    return _messageLog;
}

- (IBAction)touchCardButton:(UIButton *)sender
{
    int chooseButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chooseButtonIndex];
    if (self.isFirstFlip) {
        // 设置game mode
        self.game.mode = self.gameModeControl.selectedSegmentIndex;
        self.isFirstFlip = NO;
    }
    // updateUI中会用到isFirstFlip的值，所以先设置isFirstFlip
    [self updateUI];
}

- (void)updateUI    // messageLog的值也是在该方法中更新
{
    for (UIButton *cardButton in self.cardButtons) {
        int cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    
    if (self.isFirstFlip) {    //此时是在touchRestartGameButton:(id)sender中被调用
        self.messageLabel.text = @"";
    } else {    //此时是在touchCardButton:(UIButton *)sender中被调用
        // 更新messageLabel的值
        self.messageLabel.text = self.game.scoreMessage;
        // 更新messageLog的值
        [self.messageLog addObject:self.game.scoreMessage];
        // 更新messageSlider的值
        if (self.messageSlider.value != self.messageSlider.maximumValue)
            [self.messageSlider setValue:self.messageSlider.maximumValue animated:NO];  //setValue方法不会触发value changed事件
    }
}
- (NSString *)titleForCard:(Card *)card
{
    return card.isChosen?card.contents:@"";
}
- (UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.isChosen?@"cardfront":@"cardback"];
}

- (IBAction)touchRestartGameButton:(id)sender {
    // 重置self.game
    self.game = [[PlayingCardGame alloc]initWithCardCount:[self.cardButtons count]
                                                 usingDeck:[self createDeck]];
    // 重置self.isFirstFlip（从而重置self.gameModeControl，重置self.game.mode）
    self.isFirstFlip = YES;
    // 重置self.messageLog，在getter中会lazy instantiate为空数组
    self.messageLog = nil;
    // 刷新UI
    [self updateUI];
}

// messageLabel的显示由该action handler负责
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
