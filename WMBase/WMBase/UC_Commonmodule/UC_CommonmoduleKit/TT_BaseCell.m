//
//  TT_BaseCell.m
//  破竹
//
//  Created by linlin dang on 2018/8/23.
//  Copyright © 2018年 米宅. All rights reserved.
//

#import "TT_BaseCell.h"
#import <objc/runtime.h>
@interface TT_BaseCell ()


@end

@implementation TT_BaseCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}


#pragma mark 生命周期
+ (instancetype)cellWithTableView:(UITableView *)tableview CellClass:(Class)cellClass {
    NSString *className = [NSString stringWithUTF8String:class_getName(cellClass)];
    TT_BaseCell* cell = (TT_BaseCell*)[tableview dequeueReusableCellWithIdentifier:className];
    if (cell == nil) {
       cell = [[cellClass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:className];
    }
    return cell;
}
+ (instancetype)extend_cellWithTableView:(UITableView *)tableview CellClass:(Class)cellClass {
    //wm_tip cell重用后样式无法变化，增加新的Identifier
    NSString *className = [NSString stringWithUTF8String:class_getName(cellClass)];
    NSString *extend_className = [NSString stringWithFormat:@"extend_%@",className];
    TT_BaseCell* cell = (TT_BaseCell*)[tableview dequeueReusableCellWithIdentifier:extend_className];
    if (cell == nil) {
       cell = [[cellClass alloc] initWithStyle_extend:UITableViewCellStyleDefault reuseIdentifier:extend_className];
    }
    return cell;
}

- (instancetype)initWithStyle_extend:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier  {
    self  = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self extend_setupSubViews];
    }
    return self;
}



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupSubviewS];
    }
    return self;
}



#pragma mark 触发方法

#pragma mark 公开方法

- (void)configData:(id)Data {
    
}

- (void)setupSubviewS {
    [self.contentView addSubview:self.lable];
}

-(void)extend_setupSubViews{
    [self.contentView addSubview:self.lable];
}


- (void)setupSubViewsFrame {
    
}

- (void)configtapclose:(NSInteger)num {
    if (self.currencyClose) {
        self.currencyClose(num);
    }
}

#pragma mark +类方法
+ (CGFloat)xxx_cellHight:(id)Data{
    return 44;
}

#pragma mark 私有方法


- (UILabel *)lable {
    if (!_lable) {
        _lable = [UILabel new];
        _lable.textColor = [UIColor blackColor];
        _lable.font = [UIFont systemFontOfSize:14];
    }
    return _lable;
}
@end
