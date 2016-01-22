//
//  AlgCDDNAViewController.m
//  AlgorithmCD
//
//  Created by XingShihan on 16/1/12.
//  Copyright © 2016年 Chongqing Sanfu Technology. All rights reserved.
//

#import "AlgCDDNAViewController.h"
#import "DNACompare.h"
#import "SVProgressHUD.h"

@interface AlgCDDNAViewController ()

@end
/**
 *  DNA序列比较
 */
@implementation AlgCDDNAViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    UIImageView *bgImage = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [bgImage setImage:[UIImage imageNamed:@"dna_bg"]];
    [self.view addSubview:bgImage];
    [self.view sendSubviewToBack:bgImage];
    _dna1Field.delegate = self;
    _dna2Field.delegate = self;
    [_dnaAdditionLabel setHidden:YES];
    [_dna1CompleteLabel setHidden:YES];
    [_dna2CompleteLabel setHidden:YES];
    [_simlarLabel setHidden:YES];
    [_valueLabel setHidden:YES];
}

#pragma mark - 监听事件
- (IBAction)buttonTapped:(UIButton *)sender {
    switch (sender.tag) {
        case 1:{
            // 生成随机序列
            _dna1Field.text = [self randomDNA];
            _dna2Field.text = [self randomDNA];
            break;
        }
        case 2:{
            // 检查DNA序列是否符合规范
            if (![_dna1Field.text isEqualToString:@""] && ![_dna2Field.text isEqualToString:@""]){
                if (![DNACompare checkDNA:_dna1Field.text] && ![DNACompare checkDNA:_dna2Field.text]) {
                    //不符合规范
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"DNA不合法" message:@"只能填写ACGT"preferredStyle:UIAlertControllerStyleAlert];
                    // Create the actions.
                    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleDefault handler:^(UIAlertAction*action) {}];
                    
                    // Add the actions.
                    [alertController addAction:okAction];
                    
                    [self presentViewController:alertController animated:YES completion:nil];
                } else {
                    // 滚轮
                    [SVProgressHUD show];
                    // 比较DNA序列
                    DNACompare *compared = [[DNACompare alloc] initWithDNA1:_dna1Field.text DNA2:_dna2Field.text];
                    int score = [compared startCompare];
                    //展示结果
                    [_dnaAdditionLabel setHidden:NO];
                    
                    [_dna1CompleteLabel setText:compared.dna1Changed];
                    [_dna1CompleteLabel setHidden:NO];
                    
                    [_dna2CompleteLabel setText:compared.dna2Changed];
                    [_dna2CompleteLabel setHidden:NO];
                    
                    [_simlarLabel setHidden:NO];
                    
                    [_valueLabel setText:[NSString stringWithFormat:@"%d",score]];
                    [_valueLabel setHidden:NO];
                    [SVProgressHUD dismissWithSuccess:@"比对完成!"];
                }
            } else {
                // 请输入DNA序列！
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"请填写DNA！" message:@"DNA不能为空"preferredStyle:UIAlertControllerStyleAlert];
                // Create the actions.
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleDefault handler:^(UIAlertAction*action) {}];
                
                // Add the actions.
                [alertController addAction:okAction];
                
                [self presentViewController:alertController animated:YES completion:nil];
            }
            break;
        }
        default:
            break;
    }
}

-(NSString*)randomDNA{
    int length = (arc4random() % 15) + 1;
    NSString *dna = @"";
    for (int i = 0; i < length; i++) {
        switch ((arc4random() % 4)) {
            case 0:{
                dna = [dna stringByAppendingString:@"A"];
                break;
            }
            case 1:{
                dna = [dna stringByAppendingString:@"C"];
                break;
            }
            case 2:{
                dna = [dna stringByAppendingString:@"G"];
                break;
            }
            case 3:{
                dna = [dna stringByAppendingString:@"T"];
                break;
            }
            default:
                break;
        }
    }
    return dna;
}

#pragma mark - TextFieldDelegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.view endEditing:YES];
    return YES;
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    textField.text = [textField.text uppercaseString];
    return YES;
}


@end
