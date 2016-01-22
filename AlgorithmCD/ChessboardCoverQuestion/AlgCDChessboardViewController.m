//
//  AlgCDChessboardViewController.m
//  AlgorithmCD
//
//  Created by XingShihan on 16/1/12.
//  Copyright © 2016年 Chongqing Sanfu Technology. All rights reserved.
//

#import "AlgCDChessboardViewController.h"
#import "ChessCover.h"

@interface AlgCDChessboardViewController (){
    ChessCover *boardCover;
    CGFloat padding;
    CGFloat width;
    CGPoint point;
}

@end
/**
 *  棋盘覆盖问题
 */
@implementation AlgCDChessboardViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    UIImageView *bgImage = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [bgImage setImage:[UIImage imageNamed:@"chess_bg"]];
    [self.view addSubview:bgImage];
    [self.view sendSubviewToBack:bgImage];

    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(drawBoard:) name:@"ChessBoardNotification" object:nil];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [_chessboardView configBoard];
    [_chessboardView draw:ChessboardType];
}

-(void)drawBoard:(NSNotification*)notification{
    NSDictionary *dic = [notification userInfo];
    int style = [[dic objectForKey:@"style"] intValue];
    int row = [[dic objectForKey:@"row"] intValue];
    int col = [[dic objectForKey:@"col"] intValue];

    [_chessboardView setPointWithX:row AndY:col];
    
    switch (style) {
        case 1:
            [_chessboardView draw:AType];
            break;
        case 2:
            [_chessboardView draw:BType];
            break;
        case 3:
            [_chessboardView draw:CType];
            break;
        case 4:
            [_chessboardView draw:DType];
            break;
        default:
            break;
    }
    
}
- (IBAction)buttonTapped:(UIButton *)sender {
    switch (sender.tag) {
        case 1:{
            // 随机数字
            int value = (arc4random() % 4) + 1;
            _powerValueLabel.text = [NSString stringWithFormat:@"%d", value];
            _powerStepper.value = value;
            // 改变棋盘
            [_chessboardView configWithCellCount:pow(2, value)];
            [_chessboardView draw:ChessboardType];
            break;
        }
        default:
            break;
    }
}

#pragma mark - 值发生改变

- (IBAction)stepperChanged:(UIStepper *)sender {
    _powerValueLabel.text = [NSString stringWithFormat:@"%.0f", sender.value];
    // 改变棋盘
    [_chessboardView configWithCellCount:pow(2, sender.value)];
    [_chessboardView draw:ChessboardType];
    
}

@end
