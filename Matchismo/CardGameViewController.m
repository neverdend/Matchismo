//
//  CardGameViewController.m
//  Matchismo
//
//  Created by 陈超 on 14-9-20.
//  Copyright (c) 2014年 Chao Chen. All rights reserved.
//

#import "CardGameViewController.h"
#import "Deck.h"
#import "PlayingCardDeck.h"
#import "PlayingCard.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) Deck *cardGameDeck;
@end

@implementation CardGameViewController

//getter of property cardGameDeck, lazy instantiation
- (Deck *)cardGameDeck
{
    if (!_cardGameDeck) {
        _cardGameDeck = [[PlayingCardDeck alloc]init];
    }
    
    return _cardGameDeck;
}

- (void)setFlipCount:(int)flipCount
{
    //basic function of getter
    _flipCount = flipCount;
    //update the outlet to the UILabel
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
    NSLog(@"FlipCount changes to %d", self.flipCount);
}

- (IBAction)touchCardButton:(UIButton *)sender
{
    PlayingCard *card = nil;
    
    if ([sender.currentTitle length]) {
        [sender setBackgroundImage:[UIImage imageNamed:@"cardback"]
                          forState:UIControlStateNormal];
        [sender setTitle:@"" forState:UIControlStateNormal];
    } else {
        card = (PlayingCard *)[self.cardGameDeck drawRandomCard];
        NSString *content = card.contents?card.contents:@"None";
        [sender setBackgroundImage:[UIImage imageNamed:@"cardfront"]
                          forState:UIControlStateNormal];
        [sender setTitle:content forState:UIControlStateNormal];
        NSLog(@"Card %@ was flipped", content);
    }
    
    self.flipCount++;
}


/*
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
*/
@end
