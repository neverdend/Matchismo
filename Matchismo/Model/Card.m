//
//  Card.m
//  Matchismo
//
//  Created by 陈超 on 14-9-21.
//  Copyright (c) 2014年 Chao Chen. All rights reserved.
//

#import "Card.h"

@implementation Card

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    for (Card *card in otherCards) {
        if ([self.contents isEqualToString:card.contents]) {
            score = 1;
        }
    }
    
    return score;
}

@end
