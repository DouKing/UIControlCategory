//
//  ViewController.m
//  UIControlCategory
//
//  Created by WuYikai on 15/9/11.
//  Copyright (c) 2015年 secoo. All rights reserved.
//

#import "ViewController.h"
#import "UIControl+SafeEvent.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  
  UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
  button.frame = CGRectMake(100, 100, 100, 100);
  button.backgroundColor = [UIColor redColor];
  [button addTarget:self action:@selector(aaa) forControlEvents:UIControlEventTouchUpInside];
  button.acceptEventInterval = 1;
  [self.view addSubview:button];
}

- (void)aaa {
  NSLog(@"hahahaha--");
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
