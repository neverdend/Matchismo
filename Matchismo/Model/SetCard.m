//
//  SetCard.m
//  Matchismo
//
//  Created by 陈超 on 14-10-5.
//  Copyright (c) 2014年 Chao Chen. All rights reserved.
//

#import "SetCard.h"

@interface SetCard ()

@end

@implementation SetCard

- (instancetype)initWithNmuber:(NSUInteger)number
                     andSymbol:(NSString *)symbol
                    andShading:(int)shading
                      andColor:(NSString *)color
{
    self = [super init];
    if (self) {
        if ([[SetCard validNumber]containsObject:[NSNumber numberWithInt:number ]]) {
            self.number = number;
        } else {
            return nil;
        }
        if ([[SetCard validSymbol]containsObject:symbol]) {
            self.symbol = symbol;
        } else {
            return nil;
        }
        if ([[SetCard validShading]containsObject:[NSNumber numberWithInt:shading]]) {
            self.shading = shading;
        } else {
            return nil;
        }
        if ([[SetCard validColor]containsObject:color]) {
            self.color = color;
        } else {
            return nil;
        }
    }
    return self;
}

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    
    if ([otherCards count] != 2)
        return score;   // score为0说明匹配失败
    
    SetCard *card1 = (SetCard *)otherCards[0];
    SetCard *card2 = (SetCard *)otherCards[1];
    if (
        (
            (self.shading == card1.shading && self.shading == card2.shading) ||
            (self.shading != card1.shading && self.shading != card2.shading && card1.shading != card2.shading)
        )
        &&
        (
            (self.number == card1.number && self.number == card2.number) ||
            (self.number != card1.number && self.number != card2.number && card1.number != card2.number)
        )
        &&
        (
            ([self.color isEqualToString:card1.color] && [self.color isEqualToString:card2.color]) ||
            ((![self.color isEqualToString:card1.color]) && (![self.color isEqualToString:card2.color]) && (![card1.color isEqualToString:card2.color]))
        )
        &&
        (
            ([self.symbol isEqualToString:card1.symbol] && [self.symbol isEqualToString:card2.symbol]) ||
            ((![self.symbol isEqualToString:card1.symbol]) && (![self.symbol isEqualToString:card2.symbol]) && (![card1.symbol isEqualToString:card2.symbol]))
        )
       )
        score = 1;
    return score;
}

+ (NSArray *)validNumber
{
    return @[@1, @2, @3];
}

+ (NSArray *)validSymbol
{
    return @[@"♦︎", @"●", @"■"];
}

+ (NSArray *)validShading   // 除以10作为alpha的值
{
    return @[@1, @2, @3];
}

+ (NSArray *)validColor
{
    return @[@"green", @"red", @"purple"];
}

// getter of property contents (inherited from Card)
- (NSString *)contents
{
    NSString *str = @"";
    for (int i = 0; i < self.number; i++)
        str = [str stringByAppendingString:self.symbol];
    return str;
}

- (NSString *)fullContents
{
    return [self.contents stringByAppendingString:[NSString stringWithFormat:@"(c:%@,sh:%d)", self.color, self.shading]];
}

@end