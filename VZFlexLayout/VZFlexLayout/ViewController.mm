//
//  ViewController.m
//  VZFlexLayout
//
//  Created by moxin on 16/4/13.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "ViewController.h"
#import "FBViewController.h"
#import "FBTableViewController.h"
#import "FBTextListViewController.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(go:)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)go:(id)sender
{
    FBViewController* v = [FBViewController new];
   // FBTableViewController* v = [FBTableViewController new];
   // FBTextListViewController* v = [FBTextListViewController new];
    [self.navigationController pushViewController:v animated:YES];
}


@end
