//
//  CardGame.m
//  Matchismo
//
//  Created by 陈超 on 14-9-29.
//  Copyright (c) 2014年 Chao Chen. All rights reserved.
//

#import "CardGame.h"

@interface CardGame ()
@property (nonatomic, strong, readwrite) NSMutableArray *cards;    //of card
@end

@implementation CardGame

// getter of cards, lazy instantiate
- (NSMutableArray *)cards
{
    if (!_cards) {
        _cards = [[NSMutableArray alloc] init];
    }
    return _cards;
}

// init
- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck
{
    self = [super init];
    if (self) {
        for (int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
            }
            else {
                self = nil;
                break;
            }
        }
        self.score = 0; //默认是0，不初始化也行
        self.scoreMessage = @"";
    }
    return self;
}

// peek the card corresponding to the given index
- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count])?self.cards[index]:nil;
}

// user choose the card corresponding to the given index. ABSTRACT!
- (void)chooseCardAtIndex:(NSUInteger)index
{
    // abstract, implemented in subclass
}

@end
