//
//  AlgCDDNAViewController.h
//  AlgorithmCD
//
//  Created by XingShihan on 16/1/12.
//  Copyright © 2016年 Chongqing Sanfu Technology. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlgCDDNAViewController : UIViewController<UITextFieldDelegate>{
}
@property (weak, nonatomic) IBOutlet UITextField *dna1Field;
@property (weak, nonatomic) IBOutlet UITextField *dna2Field;

@property (weak, nonatomic) IBOutlet UILabel *dnaAdditionLabel;
@property (weak, nonatomic) IBOutlet UILabel *dna1CompleteLabel;
@property (weak, nonatomic) IBOutlet UILabel *dna2CompleteLabel;

@property (weak, nonatomic) IBOutlet UILabel *simlarLabel;
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;

@property (weak, nonatomic) IBOutlet UIButton *randomButton;
@property (weak, nonatomic) IBOutlet UIButton *compareButton;
@end
