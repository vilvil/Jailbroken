//
//  ViewController.m
//  EscapeCheck
//
//  Created by vivi on 16/6/19.
//  Copyright © 2016年 vivi. All rights reserved.
//

#import "ViewController.h"
#import "EscapeCheckTool.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

   
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{

    if ([EscapeCheckTool isJailbroken7]
        ||[EscapeCheckTool isJailbroken6]
        ||[EscapeCheckTool isJailbroken5]
        ||[EscapeCheckTool isJailbroken4]
        ||[EscapeCheckTool isJailbroken3]
        ||[EscapeCheckTool isJailbroken2]
        ||[EscapeCheckTool isJailbroken]) {
        NSLog(@"已经越狱");
    }else{
        NSLog(@"没越狱");
    }
}



@end
