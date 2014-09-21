//
//  PlayingCard.m
//  Matchismo
//
//  Created by 陈超 on 14-9-21.
//  Copyright (c) 2014年 Chao Chen. All rights reserved.
//

#import "PlayingCard.h"

@interface PlayingCard()
@end

@implementation PlayingCard

- (instancetype)initWithSuit:(NSString *)suit andRank:(NSUInteger)rank
{
    self = [super init];
    if (self) {
        self.suit = suit;
        self.rank = rank;
    }
    return self;
}
//class method
+ (NSArray *)validSuits
{
    return @[@"♥︎",@"♦︎",@"♠︎",@"♣︎"];
}

+ (NSArray *)rankStrings
{
	return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];	//when index = 0, rank = "?"
}

+ (NSUInteger)maxRank
{
    return [[PlayingCard rankStrings] count] - 1;
}

//getter of @property contents (inherited from Card)
- (NSString *)contents
{
    return [[PlayingCard rankStrings][self.rank] stringByAppendingString:self.suit];
}

//getter and setter of @property suit
@synthesize suit = _suit;   //because we provide both setter and getter

- (void) setSuit:(NSString *)suit
{
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

- (NSString *) suit
{
    return _suit? _suit: @"?";
}

//setter of @property rank
- (void)setRank:(NSUInteger)rank
{
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}


@end
