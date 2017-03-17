//
//  ViewController.m
//  TestStringPropertyDemo
//
//  Created by CYH on 2017/3/17.
//  Copyright © 2017年 Lianxi.com. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) NSString *strongString;
@property (nonatomic, copy)   NSString *copyedString;
@property (weak, nonatomic) IBOutlet UILabel *originLabel;
@property (weak, nonatomic) IBOutlet UILabel *strongLabel;
@property (weak, nonatomic) IBOutlet UILabel *copyedLabel;

@end

@implementation ViewController

- (void)setValue:(id)value forUndefinedKey:(nonnull NSString *)key
{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self test];
}

- (void)test {
    
#warning 第一步
    NSString *string = [NSString stringWithFormat:@"Chaiyh"];
    
#warning 第二步
//    NSMutableString *string = [NSMutableString stringWithFormat:@"Chaiyh"];
    
    self.strongString = string;
    self.copyedString = string;
    
    _originLabel.text = [NSString stringWithFormat:@"origin string: %p, &string : %p", string, &string];
    _strongLabel.text = [NSString stringWithFormat:@"strong string: %p, &_strongString : %p", _strongString, &_strongString];
    _copyedLabel.text = [NSString stringWithFormat:@"copy string: %p, &_copyedString : %p", _copyedString, &_copyedString];
    
    NSLog(@"origin string: %p, &string : %p", string, &string);
    NSLog(@"strong string: %p, &_strongString : %p", _strongString, &_strongString);
    NSLog(@"copy string: %p, &_copyedString : %p", _copyedString, &_copyedString);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    [self test];
}


@end
