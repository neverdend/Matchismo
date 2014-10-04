//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by 陈超 on 14-9-29.
//  Copyright (c) 2014年 Chao Chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Card.h"

@interface PlayingCardGame : NSObject
// designated initializer
- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck;
- (void)chooseCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;

@property (nonatomic, readonly) NSInteger score;
@property (nonatomic) int mode;
@property (nonatomic, strong, readonly) NSString *scoreMessage;
@end
