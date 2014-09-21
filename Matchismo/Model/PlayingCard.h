//
//  PlayingCard.h
//  Matchismo
//
//  Created by 陈超 on 14-9-21.
//  Copyright (c) 2014年 Chao Chen. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;   //花色
@property (nonatomic) NSUInteger rank;  //大小

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;

- (instancetype)initWithSuit:(NSString *)suit andRank:(NSUInteger)rank;

@end
