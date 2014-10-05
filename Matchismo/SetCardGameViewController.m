//
//  SetCardGameViewController.m
//  Matchismo
//
//  Created by 陈超 on 14-10-5.
//  Copyright (c) 2014年 Chao Chen. All rights reserved.
//

#import "SetCardGameViewController.h"
#import "SetCardGame.h"
#import "SetCardDeck.h"
#import "SetCard.h"

@interface SetCardGameViewController ()

@end

@implementation SetCardGameViewController

// implement abstract methods in super calss
- (CardGame *)createGame
{
    return [[SetCardGame alloc]initWithCardCount:[self getCardCount] usingDeck:[[SetCardDeck alloc]init]];
}

- (void)updateCardButton:(UIButton *)cardButton using:(Card *)card
{
    // 更新牌面上的信息
    SetCard *setCard = (SetCard *)card;
    
    UIColor *color = nil;
    if ([setCard.color isEqualToString:@"red"])
        color = [UIColor redColor];
    else if ([setCard.color isEqualToString:@"black"])
        color = [UIColor blackColor];
    else if ([setCard.color isEqualToString:@"blue"])
        color = [UIColor blueColor];
    
    NSMutableAttributedString *title = nil;
    
    NSArray *validShading = [SetCard validShading];
    if (setCard.shading == [(NSNumber *)validShading[0] intValue]) {    //用外轮廓线（无填充色）表示
        title = [[NSMutableAttributedString alloc]initWithString:card.contents attributes:@{NSStrokeWidthAttributeName:@3, NSStrokeColorAttributeName:color}];
    }
    else if (setCard.shading == [(NSNumber *)validShading[1] intValue]) {   //用alpha=0.4显示
        double shadingToAlpha = 0.4;
        color = [color colorWithAlphaComponent:shadingToAlpha];
        title = [[NSMutableAttributedString alloc]initWithString:card.contents attributes:@{NSForegroundColorAttributeName:color}];
    }
    else if (setCard.shading == [(NSNumber *)validShading[2] intValue]) {   //普通显示
        title = [[NSMutableAttributedString alloc]initWithString:card.contents attributes:@{NSForegroundColorAttributeName:color}];
    }
    
    [cardButton setAttributedTitle:title forState:UIControlStateNormal];
    
    // 选中的牌大小为44*64，未选中的牌大小为40*60
    CGPoint origin = cardButton.bounds.origin;
    CGSize size;
    if (card.isChosen) {
        size.width = 48;
        size.height = 68;
    }
    else {
        size.width = 40;
        size.height = 60;
    }
    CGRect bounds = {origin, size};
    cardButton.bounds = bounds;     // 在viewDidLoad中执行此语句无效，可能是因为viewDidLoad执行后又被storyboard里设定的值覆盖了
    
    // 设置button是否enable
    cardButton.enabled = !card.isMatched;
}

@end
