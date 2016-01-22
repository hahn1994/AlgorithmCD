//
//  DNACompare.m
//  AlgorithmCD
//
//  Created by XingShihan on 16/1/12.
//  Copyright © 2016年 Chongqing Sanfu Technology. All rights reserved.
//

#import "DNACompare.h"

@implementation DNACompare

-(instancetype)initWithDNA1:(NSString*)dna1 DNA2:(NSString*)dna2{
    self = [super init];
    if (self) {
        _dna1 = [dna1 mutableCopy];
        _dna2 = [dna2 mutableCopy];
        _dna1Changed = @"";
        _dna2Changed = @"";
        _dnaScore = [[NSMutableArray alloc] init];
        NSMutableArray *rowArray = [[NSMutableArray alloc] init];
        for (int j = 0; j <= dna2.length; j++) {
            [rowArray addObject:[NSNumber numberWithInt:0]];
        }
        for (int i = 0; i <= dna1.length; i++) {
            [_dnaScore addObject:[rowArray mutableCopy]];
        }
    }
    return self;
}


-(int)startCompare{
    [self completeDNAScore];
    [self completeDNA];
    return [self result];
}

-(void)completeDNA{
    int rowIndex = (int)[_dnaScore count] - 1;//行
    int colIndex = (int)[[_dnaScore objectAtIndex:0] count] - 1;//列
    while (rowIndex != 0 || colIndex != 0){
        
        //当行等于0时，dna1Changed已经匹配完成，dna2Changed前面的剩余基因与空格匹配
        if (rowIndex == 0) {
            for (int i = 0; i < colIndex; i++){
                //匹配后的dna1Changed
                _dna1Changed = [@"_" stringByAppendingString:_dna1Changed];
            }
            
            //匹配后的dna2Changed
            _dna2Changed = [[_dna2 substringWithRange:NSMakeRange(0, colIndex)] stringByAppendingString:_dna2Changed];
            return;
        }
        
        //列为dna2Changed 同行一样
        if (colIndex == 0) {
            for (int i = 0; i < rowIndex; i++) {
                _dna2Changed = [@"_" stringByAppendingString:_dna2Changed];
            }
            
            _dna1Changed = [[_dna1 substringWithRange:NSMakeRange(0, rowIndex)] stringByAppendingString:_dna1Changed];
            return;
        }
        
        //DNA1的最后一个基因和空格匹配
        int top = [[[_dnaScore objectAtIndex:rowIndex - 1] objectAtIndex:colIndex] intValue] + [self getScoreWithDNA1:[_dna1 characterAtIndex:rowIndex - 1] DNA2:'_'];
        
        //DNA2的最后一个基因和空格匹配
        int left = [[[_dnaScore objectAtIndex:rowIndex] objectAtIndex:colIndex - 1] intValue] + [self getScoreWithDNA1:[_dna2 characterAtIndex:colIndex - 1] DNA2:'_'];

        //DNA1的最后一个基因和DNA最后一个基因匹配
        //int both = [[[_dnaScore objectAtIndex:rowIndex - 1] objectAtIndex:colIndex - 1] intValue] + [self getScoreWithDNA1:[_dna1 characterAtIndex:rowIndex - 1] DNA2:[_dna2 characterAtIndex:colIndex - 1]];
        
        int value = [[[_dnaScore objectAtIndex:rowIndex] objectAtIndex:colIndex] intValue];
        
        if (value == top) {
            _dna1Changed = [[_dna1 substringWithRange:NSMakeRange(rowIndex - 1, 1)] stringByAppendingString:_dna1Changed];
            _dna2Changed = [@"_" stringByAppendingString:_dna2Changed];
            rowIndex--;
        }
        else if (value == left) {
            _dna1Changed = [@"_" stringByAppendingString:_dna1Changed];
            _dna2Changed = [[_dna2 substringWithRange:NSMakeRange(colIndex - 1, 1)] stringByAppendingString:_dna2Changed];
            colIndex--;
        }
        else {
            _dna1Changed = [[_dna1 substringWithRange:NSMakeRange(rowIndex - 1, 1)] stringByAppendingString:_dna1Changed];
            _dna2Changed = [[_dna2 substringWithRange:NSMakeRange(colIndex - 1, 1)] stringByAppendingString:_dna2Changed];
            rowIndex--;
            colIndex--;
        }
        NSLog(@"\n%@\n%@",_dna1Changed,_dna2Changed);
    }
    
    return;
}

/**
 *  填充DNA得分矩阵
 */
-(void)completeDNAScore {
    for (int i = 1; i < [_dnaScore count]; i++){
        int score = [[[_dnaScore objectAtIndex:(i - 1)] objectAtIndex:0] intValue] + [self getScoreWithDNA1:[_dna1 characterAtIndex:(i - 1)] DNA2:'_'];
        [[_dnaScore objectAtIndex:i] replaceObjectAtIndex:0 withObject:[NSNumber numberWithInt:score]];
    }
    for (int i = 1; i < [[_dnaScore objectAtIndex:0] count]; i++){
        int score = [[[_dnaScore objectAtIndex:0] objectAtIndex:(i - 1)] intValue] + [self getScoreWithDNA1:'_' DNA2:[_dna2 characterAtIndex:(i - 1)]];
        [[_dnaScore objectAtIndex:0] replaceObjectAtIndex:i withObject:[NSNumber numberWithInt:score]];
    }
    
    for (int i = 1; i < [_dnaScore count]; i++) {
        for (int j = 1; j < [[_dnaScore objectAtIndex:0] count]; j++) {
            int v1 = 0, v2 = 0, v3 = 0;
            //情况1：DNA1和"_"搭配
            v1 = [[[_dnaScore objectAtIndex:(i - 1)] objectAtIndex:j] intValue] + [self getScoreWithDNA1:[_dna1 characterAtIndex:(i - 1)] DNA2:'_'];
            
            //情况2：DNA1和DNA2搭配
            v2 = [[[_dnaScore objectAtIndex:(i - 1)] objectAtIndex:(j - 1)] intValue] + [self getScoreWithDNA1:[_dna1 characterAtIndex:(i - 1)] DNA2:[_dna2 characterAtIndex:(j - 1)]];
            
            //情况3："_"和DNA2搭配
            v3 = [[[_dnaScore objectAtIndex:i] objectAtIndex:(j - 1)] intValue] + [self getScoreWithDNA1:'_' DNA2:[_dna2 characterAtIndex:(j - 1)]];

            // 填写分数值
            int maxValue = v1 > v2 ? v1 : v2;
            maxValue = maxValue > v3 ? maxValue : v3;
            [[_dnaScore objectAtIndex:i] replaceObjectAtIndex:j withObject:[NSNumber numberWithInt:maxValue]];
        }
    }
}

- (int)result{
    return [[[_dnaScore lastObject] lastObject] intValue];;
}

+ (BOOL)checkDNA:(NSString*)dnaString{
    for (int i = 0; i < dnaString.length; i++) {
        // 获取核苷酸字符
        char nuc = [dnaString characterAtIndex:i];
        if (nuc != 'A' && nuc != 'C'&& nuc != 'G' && nuc != 'T') {
            return NO;
        }
    }
    return YES;
}


/**
 *  基因矩阵分值计算函数
 *
 *  @param dna1
 *  @param dna2
 *
 *  @return 基因对应分数
 */
-(int)getScoreWithDNA1:(char)dna1 DNA2:(char)dna2{
    if (dna1 == dna2)
        return 5;
    else if ((dna1 == 'A' && dna2 == 'C') || (dna1 == 'C' && dna2 == 'A'))
        return -1;
    else if ((dna1 == 'A' && dna2 == 'G') || (dna1 == 'G' && dna2 == 'A'))
        return -2;
    else if ((dna1 == 'A' && dna2 == 'T') || (dna1 == 'T' && dna2 == 'A'))
        return -1;
    else if ((dna1 == 'A' && dna2 == '_') || (dna1 == '_' && dna2 == 'A'))
        return -3;
    else if ((dna1 == 'C' && dna2 == 'G') || (dna1 == 'G' && dna2 == 'C'))
        return -3;
    else if ((dna1 == 'C' && dna2 == 'T') || (dna1 == 'T' && dna2 == 'C'))
        return -2;
    else if ((dna1 == 'C' && dna2 == '_') || (dna1 == '_' && dna2 == 'C'))
        return -4;
    else if ((dna1 == 'G' && dna2 == 'T') || (dna1 == 'T' && dna2 == 'G'))
        return -2;
    else if ((dna1 == 'G' && dna2 == '_') || (dna1 == '_' && dna2 == 'G'))
        return -2;
    else if ((dna1 == 'T' && dna2 == '_') || (dna1 == '_' && dna2 == 'T'))
        return -1;
    
    return 0;
}
@end
