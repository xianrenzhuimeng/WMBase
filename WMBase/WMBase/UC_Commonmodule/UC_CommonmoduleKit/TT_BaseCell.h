//
//  TT_BaseCell.h
//  破竹
//
//  Created by linlin dang on 2018/8/23.
//  Copyright © 2018年 米宅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TT_BaseCell : UITableViewCell

@property (nonatomic , strong) UILabel *lable;
/// 是否选中
@property (nonatomic , assign) BOOL is_select;
/// 通用回调
@property (nonatomic , copy) void(^currencyClose)(NSInteger num);

@property (nonatomic , copy) void(^currencyparameterClose) (NSInteger type, id Data);

+ (instancetype)cellWithTableView:(UITableView *)tableview CellClass:(Class)cellClass;
+ (instancetype)extend_cellWithTableView:(UITableView *)tableview CellClass:(Class)cellClass;
- (instancetype)initWithStyle_extend:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
- (void)configData:(id)Data;
- (void)setupSubviewS;
-(void)extend_setupSubViews;


- (void)setupSubViewsFrame;
- (void)configtapclose:(NSInteger)num;


+ (CGFloat)xxx_cellHight:(id)Data;


@end
