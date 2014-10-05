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
    SetCard *setCard = (SetCard *)card;
    
    UIColor *color = nil;
    if ([setCard.color isEqualToString:@"red"])
        color = [UIColor redColor];
    else if ([setCard.color isEqualToString:@"black"])
        color = [UIColor blackColor];
    else if ([setCard.color isEqualToString:@"blue"])
        color = [UIColor blueColor];
    
    double shadingToAlpha = 0;
    NSArray *validShading = [SetCard validShading];
    if (setCard.shading == [(NSNumber *)validShading[0] intValue])
        shadingToAlpha = 0.1;
    else if (setCard.shading == [(NSNumber *)validShading[1] intValue])
        shadingToAlpha = 0.4;
    else if (setCard.shading == [(NSNumber *)validShading[2] intValue])
        shadingToAlpha = 1;
    
    color = [color colorWithAlphaComponent:shadingToAlpha];
    
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc]initWithString:card.contents attributes:@{NSForegroundColorAttributeName:color}];
    
    [cardButton setAttributedTitle:title forState:UIControlStateNormal];
    
    cardButton.enabled = !card.isMatched;
}

@end
