//
//  TestSetCardViewController.m
//  Matchismo
//
//  Created by 陈超 on 14-10-7.
//  Copyright (c) 2014年 Chao Chen. All rights reserved.
//

#import "TestSetCardViewController.h"
#import "SetCardView.h"

@interface TestSetCardViewController ()
@property (weak, nonatomic) IBOutlet SetCardView *setCardView;

@end

@implementation TestSetCardViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.setCardView.number = 3;
    self.setCardView.color = @"purple";
    self.setCardView.symbol = @"■";
    self.setCardView.shading = 3;
}

@end
