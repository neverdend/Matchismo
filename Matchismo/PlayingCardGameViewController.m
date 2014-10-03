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

@interface PlayingCardGameViewController ()

@end

@implementation PlayingCardGameViewController

-(Deck *)createDeck
{
    return [[PlayingCardDeck alloc]init];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
