//
//  CardGameViewController.h
//  Matchismo
//
//  Created by 陈超 on 14-9-20.
//  Copyright (c) 2014年 Chao Chen. All rights reserved.
//
// Abstract class, must implement createGame and updateCardButton:using:

#import <UIKit/UIKit.h>
#import "Deck.h"
#import "CardGame.h"

@interface CardGameViewController : UIViewController

- (CardGame *)createGame;   //abstract
- (void)updateCardView:(UIView *)cardView using:(Card *)card; //abstract

- (NSUInteger)getCardCount; //accessed by subclass
- (IBAction)tapCardView:(UITapGestureRecognizer *)gesture; //accessed by subclass
- (IBAction)touchRestartGameButton:(UIButton *)sender;  //accessed by subclass

@property (strong, nonatomic) CardGame *game;   //accessed by subclass

@end
