//
//  ChessboardView.h
//  AlgorithmCD
//
//  Created by XingShihan on 16/1/14.
//  Copyright © 2016年 Chongqing Sanfu Technology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChessCover.h"

typedef NS_ENUM(NSUInteger, BoardDrawType){
    ChessboardType = 0, // 棋盘
    BlockType,          // 黑块
    AType,              // A类型骨牌
    BType,              // B类型骨牌
    CType,              // C类型骨牌
    DType               // D类型骨牌
};

@interface ChessboardView : UIView {
    CGFloat padding;// 间距
    CGFloat width;// 棋盘格子的边长
    CGPoint point;// 绘图的左上角点
    CGFloat totalWidth;// 棋盘总边长
    int cellCount;// 棋盘每列/行格子数
    ChessCover *cover;
    
}



/**
 *  初始化棋盘 （2x2）
 */
-(void)configBoard;

/**
 *  重新配置棋盘
 *
 *  @param _count 棋盘每行/列格子数
 */
-(void)configWithCellCount:(int)_count;

/**
 *  画指定图形
 *
 *  @param drawType 画图类型
 */
-(void) draw:(BoardDrawType)drawType;


/**
 *  设置画图起始位置，传入矩阵行列，自动计算出对应坐标
 *
 *  @param x 矩阵行
 *  @param y 矩阵列
 */
-(void)setPointWithX:(CGFloat)x AndY:(CGFloat)y;

/**
 *  设置棋盘格子宽，自动计算出棋盘总宽
 *
 *  @param _width 格子的宽度
 */
-(void)setWidth:(CGFloat)_width;

/**
 *  设置棋盘在View中的左间距和上间距
 *
 *  @param _padding 间距大小
 */
-(void)setPadding:(CGFloat)_padding;

/**
 *  获取棋盘在View中的左间距
 *
 *  @return 左间距
 */
-(CGFloat)getPadding;

/**
 *  获取棋盘格子的宽度
 *
 *  @return 宽度
 */
-(CGFloat)getWidth;

@end
