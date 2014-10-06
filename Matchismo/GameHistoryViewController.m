//
//  GameHistoryViewController.m
//  Matchismo
//
//  Created by 陈超 on 14-10-6.
//  Copyright (c) 2014年 Chao Chen. All rights reserved.
//

#import "GameHistoryViewController.h"

@interface GameHistoryViewController ()
@property (weak, nonatomic) IBOutlet UITextView *historyTextView;
@end

@implementation GameHistoryViewController

// 在viewDidLoad中设置UITextView的显示内容
- (void)viewDidLoad
{
    if ([self.messageLog count] == 0)   // 没有记录则用灰色显示No history yet
        self.historyTextView.attributedText = [[NSAttributedString alloc]initWithString:@"No history yet." attributes:@{NSForegroundColorAttributeName:[UIColor grayColor]}];
    else {  // 有记录，则最新一条记录是黑色，后面的记录是灰色
        int lengthOfLatestMessage = [self.messageLog.lastObject length];
        NSString *messages = @"";
        for (int i = [self.messageLog count]-1; i >= 0; i--) {
            NSString *message = self.messageLog[i];
            messages = [messages stringByAppendingString:[NSString stringWithFormat:@"%@\n", message]];
        }
        // 给所有记录设置灰色
        NSMutableAttributedString *messagesWithAtt = [[NSMutableAttributedString alloc]initWithString:messages attributes:@{NSForegroundColorAttributeName:[[UIColor blackColor] colorWithAlphaComponent:0.5]}];
        // 给最新的一条记录设置黑色
        [messagesWithAtt setAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} range:NSMakeRange(0, lengthOfLatestMessage)];
        self.historyTextView.attributedText = messagesWithAtt;
    }
    
}

@end
