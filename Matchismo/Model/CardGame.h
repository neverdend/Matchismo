//
//  CardGame.h
//  Matchismo
//
//  Created by 陈超 on 14-9-29.
//  Copyright (c) 2014年 Chao Chen. All rights reserved.
//
// Abstract class, must implement chooseCardAtIndex:

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Card.h"

@interface CardGame : NSObject
// designated initializer
- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck;
- (Card *)cardAtIndex:(NSUInteger)index;
- (void)chooseCardAtIndex:(NSUInteger)index;    //abstract

@property (nonatomic, readwrite) NSInteger score;   // accessed by controller
@property (nonatomic, strong, readwrite) NSString *scoreMessage;    // accessed by controller
@property (nonatomic, strong, readonly) NSMutableArray *cards;    //accessed by subclass
@end
