//
//  SetCardGame.m
//  Matchismo
//
//  Created by 陈超 on 14-10-5.
//  Copyright (c) 2014年 Chao Chen. All rights reserved.
//

#import "SetCardGame.h"
#import "SetCard.h"

@interface SetCardGame()

@end

@implementation SetCardGame

// const vars
static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;

- (void)chooseCardAtIndex:(NSUInteger)index
{
    SetCard *card = (SetCard *)[self cardAtIndex:index];
    self.scoreMessage = @"";
    
    if (!card.isMatched) {  // 如果card已经matched则不需要进行更多操作
        if (card.isChosen) {
            card.chosen = NO;
        } else {
            NSMutableArray *otherCards = [[NSMutableArray alloc]init];
            for (Card *otherCard in self.cards)
                if (otherCard.isChosen && !otherCard.isMatched)
                    [otherCards addObject:otherCard];
            if ([otherCards count] == 0 || [otherCards count] == 1) {
                // do not need to match
                card.chosen = YES;
            } else if ([otherCards count] == 2) {
                int matchScore = [card match:otherCards];
                if (matchScore) {
                    card.matched = YES;
                    card.chosen = NO;
                    for (Card *otherCard in otherCards) {
                        otherCard.matched = YES;
                        otherCard.chosen = NO;
                    }
                    self.score += matchScore * MATCH_BONUS;
                    self.scoreMessage = [self.scoreMessage stringByAppendingString:[NSString stringWithFormat:@"Matched %@ %@ %@ for %d points. ", card.fullContents, ((SetCard *)otherCards[0]).fullContents, ((SetCard *)otherCards[1]).fullContents, matchScore*MATCH_BONUS]];
                } else {
                    card.chosen = NO;
                    for (Card *otherCard in otherCards) {
                        otherCard.chosen = NO;
                    }
                    self.score -= MISMATCH_PENALTY;
                    self.scoreMessage = [self.scoreMessage stringByAppendingString:[NSString stringWithFormat:@"%@ %@ %@ don't match, Cost %d penalty! ", card.fullContents, ((SetCard *)otherCards[0]).fullContents, ((SetCard *)otherCards[1]).fullContents, MISMATCH_PENALTY]];
                }
            }
        }
    }
}

@end
