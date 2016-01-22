//
//  ChessCover.m
//  AlgorithmCD
//
//  Created by XingShihan on 16/1/18.
//  Copyright © 2016年 Chongqing Sanfu Technology. All rights reserved.
//

#import "ChessCover.h"

@implementation ChessCover

-(instancetype)initWithSize:(int)_size AndX:(int)_x AndY:(int)_y{
    self = [super init];
    if (self) {
        if (_size < 1) {
            boardSize = 2;
        } else {
            boardSize = _size;
        }
        board = [[NSMutableArray alloc] initWithCapacity:boardSize];
        NSMutableArray *eachRow = [[NSMutableArray alloc] initWithCapacity:boardSize];
        for (int i = 0; i < boardSize; i++) {
            [eachRow addObject:@-1];
        }
        for (int i = 0; i < boardSize; i++) {
            [board addObject:[eachRow mutableCopy]];
        }
        if (_x >= 0 && _x < boardSize &&
            _y >= 0 && _y < boardSize) {
            blockX = _x;
            blockY = _y;
        } else {
            blockX = 0;
            blockY = 0;
        }
        
        [[board objectAtIndex:blockX] replaceObjectAtIndex:blockY withObject:@0];
        team = 1;
    }
    return self;
}

-(void)startCover{
    [self coverWithSize:boardSize AndSX:0 AndSY:0];
    NSLog(@"%@",board);
}

/**
 *  获取key的方位
 *
 *  @param size   棋盘边长
 *  @param x      黑块坐标X
 *  @param y      黑块坐标Y
 *  @param startX 棋盘左上角坐标X
 *  @param startY 棋盘左上角坐标Y
 *
 *  @return 1、2、3、4，分别指1、2、3、4象限
 */
-(int)keyLocationWithSize:(int)size AndBX:(int)x AndBY:(int)y AndSX:(int)startX AndSY:(int)startY {
    
    int n = size / 2;
    
    if(x < (n + startX) && y >= (n + startY))
        return 1;
    else if(x < (n + startX) && y < (n + startY))
        return 2;
    else if(x >= (n + startX) && y < (n + startY))
        return 3;
    else
        return 4;
}

/**
 *  覆盖棋盘-递归方法
 *
 *  @param size   棋盘大小
 *  @param startX 棋盘左上角坐标X
 *  @param startY 棋盘左上角坐标Y
 */
-(void)coverWithSize:(int)size AndSX:(int)startX AndSY:(int)startY {

    if(size==2){//若m==2，直接覆盖
        int tag = 0;
        int cover1stX = startX;// 骨牌第一个点X
        int cover1stY = startY;// 骨牌第一个点Y
        int cover2ndX = startX;// 骨牌第二个点X
        int cover2ndY = startY;// 骨牌第二个点Y
        for(int i = startX;i < (size + startX);i++)
            for(int j = startY;j < (size + startY);j++)
                if([[[board objectAtIndex:i] objectAtIndex:j] intValue] == -1) {
                    tag++;
                    if (tag == 1) {
                        cover1stX = i;
                        cover1stY = j;
                    } else if (tag == 2) {
                        cover2ndX = i;
                        cover2ndY = j;
                    } else if (tag == 3){
                        if (cover1stX == startX && cover1stY == (startY + 1) &&
                            cover2ndX == (startX + 1) && cover2ndY == startY &&
                            i == (startX + 1) && j == (startY + 1)) {
                            // style = 1;
                            [self coverNotifyWithX:cover1stX AndY:cover1stY AndStyle:1];
                        } else if (cover1stX == startX && cover1stY == startY &&
                                   cover2ndX == (startX + 1) && cover2ndY == startY &&
                                   i == (startX + 1) && j == (startY + 1))  {
                            // style = 2;
                            [self coverNotifyWithX:cover1stX AndY:cover1stY AndStyle:2];
                        } else if (cover1stX == startX && cover1stY == startY &&
                                   cover2ndX == startX && cover2ndY == (startY + 1) &&
                                   i == (startX + 1) && j == (startY + 1))  {
                            // style = 3;
                            [self coverNotifyWithX:cover1stX AndY:cover1stY AndStyle:3];
                        } else if (cover1stX == startX && cover1stY == startY &&
                                   cover2ndX == startX && cover2ndY == (startY + 1) &&
                                   i == (startX + 1) && j == startY)  {
                            // style = 4;
                            [self coverNotifyWithX:cover1stX AndY:cover1stY AndStyle:4];
                        }
                    }
                    
                    [[board objectAtIndex:i] replaceObjectAtIndex:j withObject:[NSNumber numberWithInt:team]];
                }
        team++;
        return;
    } else{//m>2
        int x = 0,y = 0;
        for(int i = startX;i < (size + startX);i++){//找出黑点的位置x，y
            for(int j = startY;j < (size + startY);j++)
                if([[[board objectAtIndex:i] objectAtIndex:j] intValue] != -1){
                    x = i;
                    y = j;
                }
        }
        
        int n = size/2;
        
        loc = [self keyLocationWithSize:size AndBX:x AndBY:y AndSX:startX AndSY:startY];
        
        //遍历棋盘中部四个格，判断其方位，若不和黑点在同一个方位则将其覆盖
        int tag = 0;
        int cover1stX = startX;// 骨牌第一个点X
        int cover1stY = startY;// 骨牌第一个点Y
        int cover2ndX = startX;// 骨牌第二个点X
        int cover2ndY = startY;// 骨牌第二个点Y
        for(int i = (startX + n - 1);i <= (startX + n);i++)
            for(int j = (startY + n - 1);j <= (startY + n);j++)
                if(loc != [self keyLocationWithSize:size AndBX:i AndBY:j AndSX:startX AndSY:startY]){
                    tag++;
                    if (tag == 1) {
                        cover1stX = i;
                        cover1stY = j;
                    } else if (tag == 2) {
                        cover2ndX = i;
                        cover2ndY = j;
                    } else if (tag == 3){
                        if (cover1stX == (startX + n - 1) && cover1stY == (startY + n) &&
                            cover2ndX == (startX + n) && cover2ndY == (startY + n - 1) &&
                            i == (startX + n) && j == (startY + n)) {
                            // style = 1;
                            [self coverNotifyWithX:cover1stX AndY:cover1stY AndStyle:1];
                            
                        } else if (cover1stX == (startX + n - 1) && cover1stY == (startY + n - 1) &&
                                   cover2ndX == (startX + n) && cover2ndY == (startY + n - 1) &&
                                   i == (startX + n) && j == (startY + n))  {
                            // style = 2;
                            [self coverNotifyWithX:cover1stX AndY:cover1stY AndStyle:2];
                            
                        } else if (cover1stX == (startX + n - 1) && cover1stY == (startY + n - 1) &&
                                   cover2ndX == (startX + n - 1) && cover2ndY == (startY + n) &&
                                   i == (startX + n) && j == (startY + n))  {
                            // style = 3;
                            [self coverNotifyWithX:cover1stX AndY:cover1stY AndStyle:3];
                            
                        } else if (cover1stX == (startX + n - 1) && cover1stY == (startY + n - 1) &&
                                   cover2ndX == (startX + n - 1) && cover2ndY == (startY + n) &&
                                   i == (startX + n) && j == (startY + n - 1))  {
                            // style = 4;
                            [self coverNotifyWithX:cover1stX AndY:cover1stY AndStyle:4];
                        }
                    }
                    
                    [[board objectAtIndex:i] replaceObjectAtIndex:j withObject:[NSNumber numberWithInt:team]];
                }
        team++;
        //覆盖四个分区域，递归调用
        [self coverWithSize:n AndSX:startX AndSY:startY];
        [self coverWithSize:n AndSX:startX AndSY:startY + n];
        [self coverWithSize:n AndSX:startX + n AndSY:startY];
        [self coverWithSize:n AndSX:startX + n AndSY:startY + n];
    }
}

#pragma mark - Notification 通知

-(void)coverNotifyWithX:(int)x AndY:(int)y AndStyle:(int)style {
    // 通知传值字典
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:style], @"style",[NSNumber numberWithInt:x], @"row", [NSNumber numberWithInt:y], @"col", nil];
    // 创建通知
    NSNotification *notification =[NSNotification notificationWithName:@"ChessBoardNotification" object:nil userInfo:dic];
    // 通过通知中心发送通知
    [[NSNotificationCenter defaultCenter] postNotification:notification];
}
@end
