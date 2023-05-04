//
//  ViewController.m
//  WMBase
//
//  Created by 王猛 on 2023/5/3.
//

#import "ViewController.h"
#import "UCMViewController.h"
@interface ViewController ()
@property (nonatomic, strong) UIButton *tempBtn;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view
    
    
}

-(void)buttonTap:(UIButton *)btn{
    
}
- (UIButton *)tempBtn {
    if (!_tempBtn) {
        _tempBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_tempBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _tempBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_tempBtn setTitle:@"test" forState:UIControlStateNormal];
         [_tempBtn addTarget:self action:@selector(buttonTap:) forControlEvents:UIControlEventTouchUpInside];
     }
    return _tempBtn;
}

@end
