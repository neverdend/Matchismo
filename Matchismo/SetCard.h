//
//  SetCard.h
//  Matchismo
//
//  Created by 陈超 on 14-10-5.
//  Copyright (c) 2014年 Chao Chen. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card

@property (nonatomic) NSUInteger number;    //1, 2, 3
@property (nonatomic, strong) NSString *symbol;     //▲, ●, ■
@property (nonatomic) double shading;       //used to set alpha: 0.3, 0.6, 1
@property (nonatomic, strong) NSString *color;       //red, green, blue (model中不能使用UIKit中的类，如UIColor)

- (instancetype)initWithNmuber:(NSUInteger)number
                     andSymbol:(NSString *)symbol
                    andShading:(double)shading
                      andColor:(NSString *)color;

+ (NSArray *)validNumber;   // of NSUInteger
+ (NSArray *)validSymbol;   // of NSString *
+ (NSArray *)validShading;  // of double
+ (NSArray *)validColor;    // of NSString *

@end
