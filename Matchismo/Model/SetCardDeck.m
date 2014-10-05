//
//  SetCardDeck.m
//  Matchismo
//
//  Created by 陈超 on 14-10-5.
//  Copyright (c) 2014年 Chao Chen. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"

@interface SetCardDeck()
@end

@implementation SetCardDeck
- (instancetype)init
{
    self = [super init];
    if (self) {
        for (NSNumber *number in [SetCard validNumber])
            for (NSString *symbol in [SetCard validSymbol])
                for (NSNumber *shading in [SetCard validShading])
                    for (NSString *color in [SetCard validColor])
                        [self addCard:[[SetCard alloc]initWithNmuber:[number intValue]
                                                           andSymbol:symbol
                                                          andShading:[shading doubleValue]
                                                            andColor:color]];
    }
    return self;
}
@end
