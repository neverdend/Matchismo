//
//  CardGameViewController.h
//  Matchismo
//
//  Created by 陈超 on 14-9-20.
//  Copyright (c) 2014年 Chao Chen. All rights reserved.
//
// Abstract class, must implement (Deck*) createDeck

#import <UIKit/UIKit.h>
#import "Deck.h"

@interface CardGameViewController : UIViewController

- (Deck *)createDeck;   //abstract

@end
