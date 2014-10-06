//
//  PlayingCardGame.m
//  Matchismo
//
//  Created by 陈超 on 14-10-5.
//  Copyright (c) 2014年 Chao Chen. All rights reserved.
//

#import "PlayingCardGame.h"

@interface PlayingCardGame()

@end

@implementation PlayingCardGame

// const vars
static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

- (void)chooseCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    
    self.scoreMessage = @"";    //generate the score message
    
    if (self.mode == 0) {   // 2-card mode
        if (!card.isMatched) {  // 如果card已经matched则不需要进行更多操作
            if (card.isChosen) {    //点击翻开的牌，则让牌翻回
                card.chosen = NO;
                self.scoreMessage = [self.scoreMessage stringByAppendingString:[NSString stringWithFormat:@"Flip back %@. ", card.contents]];
            }
            else {  //点击未翻开的牌，如果有其他翻开的牌则与翻开的牌比较
                // generate the score message
                self.scoreMessage = [self.scoreMessage stringByAppendingString:[NSString stringWithFormat:@"Flip up %@, cost %d. ", card.contents, COST_TO_CHOOSE]];
                // 寻找其他翻开的牌
                for (Card* otherCard in self.cards) {
                    if (otherCard.isChosen && !otherCard.isMatched) {   //该条件不会匹配到card自己！
                        int matchScore = [card match:@[otherCard]];
                        if (matchScore) {   //matchScore不为0说明match成功
                            self.score += matchScore * MATCH_BONUS;
                            otherCard.matched = YES;
                            card.matched = YES;
                            //generate the score message
                            self.scoreMessage = [self.scoreMessage stringByAppendingString:[NSString stringWithFormat:@"Matched %@ %@ for %d points. ", card.contents, otherCard.contents, matchScore*MATCH_BONUS]];
                        } else {    //matchScore为0说明match失败
                            self.score -= MISMATCH_PENALTY;
                            otherCard.chosen = NO;
                            // generate the score message
                            self.scoreMessage = [self.scoreMessage stringByAppendingString:[NSString stringWithFormat:@"%@ %@ don't match, Cost %d penalty! ", card.contents, otherCard.contents, MISMATCH_PENALTY]];
                        }
                        break;
                    }
                }
                self.score -= COST_TO_CHOOSE;
                card.chosen = YES;
            }
        }
    } else if (self.mode == 1) {    // 3-card mode
        if (!card.isMatched) {
            if (card.isChosen) {    //点击翻开的牌，则让牌翻回
                card.chosen = NO;
                self.scoreMessage = [self.scoreMessage stringByAppendingString:[NSString stringWithFormat:@"Flip back %@. ", card.contents]];
            }
            else {  //点开未翻开的牌
                // generate the score message
                self.scoreMessage = [self.scoreMessage stringByAppendingString:[NSString stringWithFormat:@"Flip up %@, cost %d. ", card.contents, COST_TO_CHOOSE]];
                NSMutableArray *otherCards = [[NSMutableArray alloc]init];
                for (Card *otherCard in self.cards) {
                    if (otherCard.isChosen && !otherCard.isMatched) {   //不会匹配到card自己
                        [otherCards addObject:otherCard];
                    }
                }
                if ([otherCards count] == 2) {  //只有翻开3张牌才会去看是否match
                    int matchScore = [card match:otherCards];
                    if (matchScore) {       //匹配成功
                        self.score += matchScore * MATCH_BONUS;
                        for (Card *otherCard in otherCards) {
                            otherCard.matched = YES;
                        }
                        card.matched = YES;
                        //generate the score message
                        self.scoreMessage = [self.scoreMessage stringByAppendingString:[NSString stringWithFormat:@"Matched %@ %@ %@ for %d points. ", card.contents, ((Card *)otherCards[0]).contents, ((Card *)otherCards[1]).contents, matchScore*MATCH_BONUS]];
                    } else {    //匹配失败
                        self.score -= MISMATCH_PENALTY;
                        for (Card *otherCard in otherCards) {
                            otherCard.chosen = NO;
                        }
                        // generate the score message
                        self.scoreMessage = [self.scoreMessage stringByAppendingString:[NSString stringWithFormat:@"%@ %@ %@ don't match, Cost %d penalty! ", card.contents, ((Card *)otherCards[0]).contents, ((Card *)otherCards[1]).contents, MISMATCH_PENALTY]];
                    }
                }
                card.chosen = YES;
                self.score -= COST_TO_CHOOSE;
            }
        }
    }
}
@end
