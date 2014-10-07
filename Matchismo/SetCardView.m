//
//  SetCardView.m
//  Matchismo
//
//  Created by 陈超 on 14-10-7.
//  Copyright (c) 2014年 Chao Chen. All rights reserved.
//

#import "SetCardView.h"

@interface SetCardView()
@end

@implementation SetCardView

#pragma mark - Draw

// 画椭圆背景时需要用到的常量和方法
#define CORNER_FONT_STANDARD_HEIGHT 180.0
#define CORNER_RADIUS 12.0

- (CGFloat)cornerRadius { return CORNER_RADIUS * (self.bounds.size.height / CORNER_FONT_STANDARD_HEIGHT); }
- (CGFloat)cornerOffset { return [self cornerRadius] / 3.0; }

- (void)drawRect:(CGRect)rect
{
    // 画出椭圆背景
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:[self cornerRadius]];
    [roundedRect addClip];
    [[UIColor whiteColor]setFill];
    [[UIColor blackColor]setStroke];
    [roundedRect fill];
    [roundedRect stroke];
    
    [self drawContentsInRect:self.bounds];
    
}

// 在给定的rect中画出图形。rect中会留出周围的空白。
- (void)drawContentsInRect:(CGRect)rect
{
    // 设置path
    UIBezierPath *path;
    if ([self.symbol isEqualToString:@"♦︎"]) {
        // 留出周围的空白
        rect = CGRectInset(rect, rect.size.width*0.1, rect.size.height*0.1);
        // 菱形的宽是高的两倍。取rect的宽为菱形的宽，或者rect的高为菱形的高
        if (rect.size.width >= 2*rect.size.height) { // 取rect的高为菱形的高
            CGPoint point1 = CGPointMake(rect.origin.x + rect.size.width/2, rect.origin.y);
            CGPoint point2 = CGPointMake(rect.origin.x + rect.size.height, rect.origin.y + rect.size.height/2);
            CGPoint point3 = CGPointMake(point1.x, point1.y + rect.size.height);
            CGPoint point4 = CGPointMake(point2.x - rect.size.height*2, point2.y);
            path = [[UIBezierPath alloc]init];
            [path moveToPoint:point1];
            [path addLineToPoint:point2];
            [path addLineToPoint:point3];
            [path addLineToPoint:point4];
            [path closePath];
        } else { // 取rect的宽为菱形的宽
            CGPoint point1 = CGPointMake(rect.origin.x, rect.origin.y + rect.size.height/2);
            CGPoint point2 = CGPointMake(rect.origin.x + rect.size.width/2, rect.origin.y + rect.size.height/2 - rect.size.width/4);    // 菱形的宽是高的两倍
            CGPoint point3 = CGPointMake(point1.x + rect.size.width, point1.y);
            CGPoint point4 = CGPointMake(point2.x, point2.y + rect.size.width/2);
            path = [[UIBezierPath alloc]init];
            [path moveToPoint:point1];
            [path addLineToPoint:point2];
            [path addLineToPoint:point3];
            [path addLineToPoint:point4];
            [path closePath];
        }
    } else if ([self.symbol isEqualToString:@"●"]) {
        // 留出周围的空白
        rect = CGRectInset(rect, rect.size.width*0.1, rect.size.height*0.1);
        // 椭圆的宽是高的两倍
        CGRect ovalBound;
        if (rect.size.width/2 <= rect.size.height) { // 取rect的宽为oval的宽
            ovalBound = CGRectMake(rect.origin.x, rect.origin.y + rect.size.height/2 - rect.size.width/4, rect.size.width, rect.size.width/2);
        } else { // 取rect的高为oval的高
            ovalBound = CGRectMake(rect.origin.x + rect.size.width/2 - rect.size.height, rect.origin.y, rect.size.height*2, rect.size.height);
        }
        path = [UIBezierPath bezierPathWithOvalInRect:ovalBound];
    } else if ([self.symbol isEqualToString:@"■"]) {
        // squiggle形状画出来的图形本来周围就有空白，所以不用调整rect
        // 设置点
        CGPoint bezierCurve1StartPoint = CGPointMake(rect.origin.x + rect.size.width*1/5, rect.origin.y + rect.size.height*2/5);
        CGPoint bezierCurve2StartPoint = CGPointMake(rect.origin.x + rect.size.width*1/5, rect.origin.y + rect.size.height*4/5);
        CGPoint bezierCurve1EndPoint = CGPointMake(rect.origin.x + rect.size.width - rect.size.width*1/5, rect.origin.y + rect.size.height*1/5);
        CGPoint bezierCurve2EndPoint = CGPointMake(rect.origin.x + rect.size.width - rect.size.width*1/5, rect.origin.y + rect.size.height*3/5);
        CGPoint bezierCurve1ControlPoint1 = CGPointMake(bezierCurve1StartPoint.x + rect.size.width/6, rect.origin.y);
        CGPoint bezierCurve2ControlPoint1 = CGPointMake(bezierCurve2StartPoint.x + rect.size.width/6, rect.origin.y + rect.size.height/5);
        CGPoint bezierCurve1ControlPoint2 = CGPointMake(bezierCurve1EndPoint.x - rect.size.width/6, rect.origin.y + rect.size.height);
        CGPoint bezierCurve2ControlPoint2 = CGPointMake(bezierCurve2EndPoint.x - rect.size.width/6, rect.origin.y + rect.size.height + rect.size.height/5);
        CGPoint quadraticCurve1ControlPoint = CGPointMake(rect.origin.x + rect.size.width - rect.size.width/10, rect.origin.y + rect.size.height/5);
        CGPoint quadraticCurve2ControlPoint = CGPointMake(rect.origin.x + rect.size.width/10, rect.origin.y + rect.size.height - rect.size.height/5);
        // 实例化path
        path = [[UIBezierPath alloc]init];
        // 设置连接处属性
        path.lineCapStyle = kCGLineCapRound;    // 线条连接处处理
        path.lineJoinStyle = kCGLineCapRound;   // 终点处理
        // 连接点
        [path moveToPoint:bezierCurve1StartPoint];
        [path addCurveToPoint:bezierCurve1EndPoint controlPoint1:bezierCurve1ControlPoint1 controlPoint2:bezierCurve1ControlPoint2];
        [path addQuadCurveToPoint:bezierCurve2EndPoint controlPoint:quadraticCurve1ControlPoint];
        [path addCurveToPoint:bezierCurve2StartPoint controlPoint1:bezierCurve2ControlPoint2 controlPoint2:bezierCurve2ControlPoint1];
        [path addQuadCurveToPoint:bezierCurve1StartPoint controlPoint:quadraticCurve2ControlPoint];
    }
    // 设置颜色
    if ([self.color isEqualToString:@"green"])
        [[UIColor greenColor] set];
    else if ([self.color isEqualToString:@"red"])
        [[UIColor redColor] set];
    else if ([self.color isEqualToString:@"purple"])
        [[UIColor purpleColor] set];
    // 绘制
    if (self.shading == 1) { // 只有轮廓 unfilled
        [path setLineWidth:3];
        [path stroke];
    } else if (self.shading == 2) { // 斜线填充 striped
        // 设置strips
        UIBezierPath *strips = [[UIBezierPath alloc]init];
        CGRect stripsBounds = path.bounds;
        for (int x = 0; x <= stripsBounds.size.width; x += 4) {
            [strips moveToPoint:CGPointMake(stripsBounds.origin.x + x, stripsBounds.origin.y)];
            [strips addLineToPoint:CGPointMake(stripsBounds.origin.x + x, stripsBounds.origin.y + stripsBounds.size.height)];
        }
        // 绘制strips
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSaveGState(context);
        [path addClip]; // 将path作为clip这样strips就不会出界
        [strips stroke];
        CGContextRestoreGState(context);    // 保存并恢复context就能将path这个clip去除掉，不影响后面的绘图
        // 绘制轮廓
        [path stroke];
    } else if (self.shading == 3) { // 颜色填满 solid
        [path fill];
    }
}

#pragma mark - Initialization

// 设置@property backgroundColor为nil，@property opaque为NO，这样才能显示背景颜色为透明
- (void)setup
{
    self.backgroundColor = nil;
    self.opaque = NO;
    self.contentMode = UIViewContentModeRedraw;
}

// 同时在awakeFromNib和initWithFrame:中设置
- (void)awakeFromNib
{
    [self setup];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
        [self setup];
    return self;
}

@end
