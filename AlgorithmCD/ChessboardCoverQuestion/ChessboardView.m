//
//  ChessboardView.m
//  AlgorithmCD
//
//  Created by XingShihan on 16/1/14.
//  Copyright © 2016年 Chongqing Sanfu Technology. All rights reserved.
//

#import "ChessboardView.h"
#import <QuartzCore/QuartzCore.h>

#define kVIEW_HEIGHT self.frame.size.height
#define kVIEW_WIDTH self.frame.size.width

@implementation ChessboardView

-(void) draw:(BoardDrawType)drawType{
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0);
    switch (drawType) {
        case AType:{
            [self drawTypeA];
            break;
        }
        case BType:{
            [self drawTypeB];
            break;
        }
        case CType:{
            [self drawTypeC];
            break;
        }
        case DType:{
            [self drawTypeD];
            break;
        }
        case BlockType:{
            for (UIView *view in [self subviews]) {
                [view removeFromSuperview];
            }
            [self drawChessboard];
            [self drawBlock];
            break;
        }
        case ChessboardType:{
            for (UIView *view in [self subviews]) {
                [view removeFromSuperview];
            }
            [self drawChessboard];
            break;
        }
        default:
            break;
    }
    UIImageView *add = [[UIImageView alloc] initWithImage:UIGraphicsGetImageFromCurrentImageContext()];
    add.frame = self.bounds;
    [self addSubview:add];
    UIGraphicsEndImageContext();

}

/**
 *  绘制黑边棋盘
 *
 *  @param size 棋盘一边的格子数
 */
- (void)drawChessboard{
    if (cellCount < 2) {
        cellCount = 2;
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 1.0);
    
    // 画横
    for (int i = 0; i <= cellCount; i++) {
        CGContextMoveToPoint(context, padding, padding + width * i);
        CGContextAddLineToPoint(context, padding + totalWidth, padding + width * i);
        CGContextStrokePath(context);
    }
    // 画竖
    for (int i = 0; i <= cellCount; i++) {
        CGContextMoveToPoint(context, padding + width * i, padding);
        CGContextAddLineToPoint(context, padding + width * i, padding + totalWidth);
        CGContextStrokePath(context);
    }
}

/**
 *  绘制黑块
 */
-(void)drawBlock {

    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
    CGContextSetLineWidth(context, 1.0);
    CGContextMoveToPoint(context, point.x, point.y);
    CGContextAddLineToPoint(context, point.x + width, point.y);
    CGContextAddLineToPoint(context, point.x + width, point.y + width);
    CGContextAddLineToPoint(context, point.x, point.y + width);
    CGContextAddLineToPoint(context, point.x, point.y);
    CGContextDrawPath(context, kCGPathFillStroke);
}

/**
 *  A类型以红色填充，形状┛
 */
- (void)drawTypeA{

    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
    CGContextSetLineWidth(context, 1.0);
    CGContextMoveToPoint(context, point.x, point.y);
    CGContextAddLineToPoint(context, point.x + width, point.y);
    CGContextAddLineToPoint(context, point.x + width, point.y + width * 2);
    CGContextAddLineToPoint(context, point.x - width, point.y + width * 2);
    CGContextAddLineToPoint(context, point.x - width, point.y + width);
    CGContextAddLineToPoint(context, point.x, point.y + width);
    CGContextAddLineToPoint(context, point.x, point.y);
    CGContextDrawPath(context, kCGPathFillStroke);
}

/**
 *  B类型以黄色填充，形状┗
 */
- (void)drawTypeB{

    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor yellowColor].CGColor);
    CGContextSetLineWidth(context, 1.0);
    CGContextMoveToPoint(context, point.x, point.y);
    CGContextAddLineToPoint(context, point.x + width, point.y);
    CGContextAddLineToPoint(context, point.x + width, point.y + width);
    CGContextAddLineToPoint(context, point.x + width * 2, point.y + width);
    CGContextAddLineToPoint(context, point.x + width * 2, point.y + width * 2);
    CGContextAddLineToPoint(context, point.x, point.y + width * 2);
    CGContextAddLineToPoint(context, point.x, point.y);
    CGContextDrawPath(context, kCGPathFillStroke);
    
}

/**
 *  C类型以红色填充，形状┓
 */
- (void)drawTypeC{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor purpleColor].CGColor);
    CGContextSetLineWidth(context, 1.0);
    CGContextMoveToPoint(context, point.x, point.y);
    CGContextAddLineToPoint(context, point.x + width * 2, point.y);
    CGContextAddLineToPoint(context, point.x + width * 2, point.y + width * 2);
    CGContextAddLineToPoint(context, point.x + width, point.y + width * 2);
    CGContextAddLineToPoint(context, point.x + width, point.y + width);
    CGContextAddLineToPoint(context, point.x, point.y + width);
    CGContextAddLineToPoint(context, point.x, point.y);
    CGContextDrawPath(context, kCGPathFillStroke);
}

/**
 *  D类型以黄色填充，形状┏
 */
- (void)drawTypeD{

    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor cyanColor].CGColor);
    CGContextSetLineWidth(context, 1.0);
    CGContextMoveToPoint(context, point.x, point.y);
    CGContextAddLineToPoint(context, point.x + width * 2, point.y);
    CGContextAddLineToPoint(context, point.x + width * 2, point.y + width);
    CGContextAddLineToPoint(context, point.x + width, point.y + width);
    CGContextAddLineToPoint(context, point.x + width, point.y + width * 2);
    CGContextAddLineToPoint(context, point.x, point.y + width * 2);
    CGContextAddLineToPoint(context, point.x, point.y);
    CGContextDrawPath(context, kCGPathFillStroke);

}


-(void)configBoard{
    padding = 1.0 / 16 * kVIEW_WIDTH;
    cellCount = 2;
    width = (kVIEW_WIDTH - padding * 2) / cellCount;
    totalWidth = (kVIEW_WIDTH - padding * 2);
    point = CGPointMake(padding, padding);
    
    // 添加点击
    [self setUserInteractionEnabled:YES];
    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(calculatePoint:)];
    [self addGestureRecognizer:tapGesture];
}


-(void)configWithCellCount:(int)_count{
    cellCount = _count;
    padding = 1.0 / 16 * kVIEW_WIDTH;
    width = (kVIEW_WIDTH - padding * 2) / cellCount;
    totalWidth = (kVIEW_WIDTH - padding * 2);
    point = CGPointMake(padding, padding);
}


-(void)setPointWithX:(CGFloat)x AndY:(CGFloat)y {
    point = CGPointMake(padding + width * y, padding + width * x);
}

-(void)setPadding:(CGFloat)_padding {
    padding = _padding;
}

-(CGFloat)getPadding{
    return padding;
}

-(void)setWidth:(CGFloat)_width {
    width = _width;
    totalWidth = width * cellCount;
}

-(CGFloat)getWidth{
    return width;
}

#pragma mark - UITapGestureRecognizer点击事件

-(void)calculatePoint:(UITapGestureRecognizer*)sender{
    CGPoint tapPoint = [sender locationInView:self];
    //判断点击范围
    if(tapPoint.x >= padding && tapPoint.x <= (totalWidth + padding) &&
       tapPoint.y >= padding && tapPoint.y <= (totalWidth + padding)){
        CGFloat startX = (int)((tapPoint.x - padding) / width) * width + padding;
        CGFloat startY = (int)((tapPoint.y - padding) / width) * width + padding;
        point = CGPointMake(startX, startY);
        [self draw:BlockType];
        
        int blockX = (int)((tapPoint.y - padding) / width);
        int blockY = (int)((tapPoint.x - padding) / width);
        cover = [[ChessCover alloc] initWithSize:cellCount AndX:blockX AndY:blockY];
        [cover startCover];
    }
}

@end
