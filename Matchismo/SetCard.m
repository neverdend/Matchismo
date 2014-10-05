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
                    andShading:(double)shading
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
        if ([[SetCard validShading]containsObject:[NSNumber numberWithDouble:shading]]) {
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

+ (NSArray *)validNumber
{
    return @[@1, @2, @3];
}

+ (NSArray *)validSymbol
{
    return @[@"▲", @"●", @"■"];
}

+ (NSArray *)validShading
{
    return @[@0.3, @0.6, @1];
}

+ (NSArray *)validColor
{
    return @[@"red", @"green", @"blue"];
}
@end