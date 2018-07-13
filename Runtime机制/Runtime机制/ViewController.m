//
//  ViewController.m
//  Runtime机制
//
//  Created by mac on 2018/7/12.
//  Copyright © 2018年 Gooou. All rights reserved.
//

#import "ViewController.h"
#import "CustomClass.h"
#import "NSObject+RunTimeTest.h"
@interface ViewController ()
@property(nonatomic,strong)NSString *name;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _name=@"heh";
    CustomClass *tem=[self testRunTime:@"CustomClass" age:@"098"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
