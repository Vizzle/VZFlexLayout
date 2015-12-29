//
//  ViewController.m
//  VZFlexLayout
//
//  Created by moxin on 15/12/25.
//  Copyright © 2015年 Vizlab. All rights reserved.
//

#import "ViewController.h"
#import "VZFlexCell.h"
#import "VZFlexNode.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView* tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 40, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds))];
    self.tableView.delegate = self;
    self.tableView.dataSource  = self;
   // [self.view addSubview:self.tableView];
    
    VZFlexNode* parentNode = [VZFlexNode new];
    parentNode.flexDirection = VZFLEX_DIRECTION_ROW;
    parentNode.size = CGSizeMake(120, 40);
    VZFlexNode* childNode1 = [VZFlexNode new];
    childNode1.flexValue = 1;
    VZFlexNode* childNode2 = [VZFlexNode new];
    childNode2.flexValue = 1;
    VZFlexNode* childNode3 = [VZFlexNode new];
    childNode3.flexValue = 1;
    [parentNode addSubNode:childNode1];
    [parentNode addSubNode:childNode2];
    [parentNode addSubNode:childNode3];
    [parentNode layout:CGRectGetWidth(self.view.bounds)];
    
    NSLog(@"[Parent Node]:{%.1f,%.1f,%.1f,%.1f}",parentNode.frame.origin.x,parentNode.frame.origin.y,parentNode.frame.size.width,parentNode.size.height);
    NSLog(@"[Child Node1]:{%.1f,%.1f,%.1f,%.1f}",childNode1.frame.origin.x,childNode1.frame.origin.y,childNode1.frame.size.width,childNode1.size.height);
    NSLog(@"[Child Node2]:{%.1f,%.1f,%.1f,%.1f}",childNode2.frame.origin.x,childNode2.frame.origin.y,childNode2.frame.size.width,childNode2.size.height);
    NSLog(@"[Child Node3]:{%.1f,%.1f,%.1f,%.1f}",childNode3.frame.origin.x,childNode3.frame.origin.y,childNode3.frame.size.width,childNode3.size.height);
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell* )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    VZFlexCell* cell = [tableView dequeueReusableCellWithIdentifier:@"flex-cell"];
    if (!cell) {
        cell = [[VZFlexCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"flex-cell"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    return cell;

}

@end

