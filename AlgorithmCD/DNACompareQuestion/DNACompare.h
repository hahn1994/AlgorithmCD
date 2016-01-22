//
//  DNACompare.h
//  AlgorithmCD
//
//  Created by XingShihan on 16/1/12.
//  Copyright © 2016年 Chongqing Sanfu Technology. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DNACompare : NSObject

@property (nonatomic,strong) NSString *dna1;
@property (nonatomic,strong) NSString *dna2;
@property (nonatomic,strong) NSMutableArray *dnaScore;
@property (nonatomic,strong) NSString *dna1Changed;
@property (nonatomic,strong) NSString *dna2Changed;

/**
 *  检测DNA字符串是否规范（由ACGT组成）
 *
 *  @param dnaString 被监测的DNA字符串
 *
 *  @return YES合法 NO非法
 */
+ (BOOL)checkDNA:(NSString*)dnaString;

/**
 *  初始化方法，实例化DNA比较对象
 *
 *  @param dna1 用于比较的第一个DNA串
 *  @param dna2 用于比较的第二个DNA串
 *
 *  @return 实例化对象
 */
- (instancetype)initWithDNA1:(NSString*)dna1 DNA2:(NSString*)dna2;

/**
 *  初始化完成后，调用的方法
 *  开始比较DNA序列
 *
 *  @return 相似度得分
 */
- (int)startCompare;
@end
