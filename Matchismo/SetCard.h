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
@property (nonatomic) int shading;       //1, 2, 3
@property (nonatomic, strong) NSString *color;       //red, green, blue (model中不能使用UIKit中的类，如UIColor)

- (instancetype)initWithNmuber:(NSUInteger)number
                     andSymbol:(NSString *)symbol
                    andShading:(int)shading
                      andColor:(NSString *)color;

+ (NSArray *)validNumber;   // of NSUInteger
+ (NSArray *)validSymbol;   // of NSString *
+ (NSArray *)validShading;  // of double
+ (NSArray *)validColor;    // of NSString *

- (NSString *)fullContents; // property contents的getter会返回number和symbol信息，本方法则返回所有number、symbol、shading、color信息

@end
