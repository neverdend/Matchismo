//
//  SetCardView.h
//  Matchismo
//
//  Created by 陈超 on 14-10-7.
//  Copyright (c) 2014年 Chao Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetCardView : UIView
@property (nonatomic) NSUInteger number;    //1, 2, 3
@property (nonatomic, strong) NSString *symbol;     //♦︎, ●, ■
@property (nonatomic) int shading;       //1, 2, 3
@property (nonatomic, strong) NSString *color;  //green, red, purple
@end
