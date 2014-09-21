//
//  PlayingCardDeck.m
//  Matchismo
//
//  Created by 陈超 on 14-9-21.
//  Copyright (c) 2014年 Chao Chen. All rights reserved.
//

#import "PlayingCardDeck.h"
#import "PlayingCard.h"

@interface PlayingCardDeck()
@end

@implementation PlayingCardDeck

- (instancetype) init
{
    self = [super init];
    
    if (self) { //[super init]失败则self == nil
        for (NSString *suit in [PlayingCard validSuits]) {
            for (int rank = 1; rank <= [PlayingCard maxRank]; rank++) {
                [self addCard:[[PlayingCard alloc]initWithSuit:suit andRank:rank]];
            }
        }
    }
    
    return self;
}
@end
