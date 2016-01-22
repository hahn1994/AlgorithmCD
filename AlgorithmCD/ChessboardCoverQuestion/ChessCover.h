//
//  ChessCover.h
//  AlgorithmCD
//
//  Created by XingShihan on 16/1/18.
//  Copyright © 2016年 Chongqing Sanfu Technology. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChessCover : NSObject
{
    int boardSize;
    NSMutableArray *board;// 棋盘的布局
    int team;// 用方块覆盖，相当于分组
    int loc;// key的方位
    int blockX;// 黑块位置X
    int blockY;// 黑块位置Y
}

-(void)startCover;

-(instancetype)initWithSize:(int)size AndX:(int)x AndY:(int)y;

@end
