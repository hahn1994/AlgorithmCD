//
//  AlgCDChessboardViewController.h
//  AlgorithmCD
//
//  Created by XingShihan on 16/1/12.
//  Copyright © 2016年 Chongqing Sanfu Technology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChessboardView.h"

@interface AlgCDChessboardViewController : UIViewController
@property (weak, nonatomic) IBOutlet ChessboardView *chessboardView;
@property (weak, nonatomic) IBOutlet UILabel *powerValueLabel;// 乘方值
@property (weak, nonatomic) IBOutlet UIStepper *powerStepper;

@end
