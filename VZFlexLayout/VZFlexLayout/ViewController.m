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

struct A
{

};

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

   [self testFlexHorizontal];

//    [self testLayout];

    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)testFlexHorizontal{
    
    VZFlexNode* parentNode = [VZFlexNode new];
    parentNode.flexDirection = VZFLEX_DIRECTION_ROW;
    parentNode.justifyContent= VZFLEX_JC_SPACE_AROUND;
    parentNode.position = CGPointMake(250, 250);
    parentNode.size = CGSizeMake(CGRectGetWidth(self.view.bounds), 120);
    VZFlexNode* childNode1 = [VZFlexNode new];
    childNode1.size = CGSizeMake(100, NAN);
//    childNode1.flexValue = 1;
    VZFlexNode* childNode2 = [VZFlexNode new];
        childNode2.size = CGSizeMake(100, NAN);
//    childNode2.flexValue = 1;
    VZFlexNode* childNode3 = [VZFlexNode new];
        childNode3.size = CGSizeMake(100, NAN);
//    childNode3.flexValue = 1;
    [parentNode addSubNode:childNode1];
    [parentNode addSubNode:childNode2];
    [parentNode addSubNode:childNode3];
    [parentNode layout:0];
    [parentNode renderRecursively];
    [self.view addSubview:parentNode.view];
}


- (void)testVertical{

    VZFlexNode* parentNode = [VZFlexNode new];
    parentNode.flexDirection = VZFLEX_DIRECTION_ROW;
    parentNode.justifyContent= VZFLEX_JC_SPACE_AROUND;
    parentNode.size = CGSizeMake(CGRectGetWidth(self.view.bounds), 120);
    VZFlexNode* childNode1 = [VZFlexNode new];
    childNode1.size = CGSizeMake(100, NAN);
    //    childNode1.flexValue = 1;
    VZFlexNode* childNode2 = [VZFlexNode new];
    childNode2.size = CGSizeMake(100, NAN);
    //    childNode2.flexValue = 1;
    VZFlexNode* childNode3 = [VZFlexNode new];
    childNode3.size = CGSizeMake(100, NAN);
    //    childNode3.flexValue = 1;
    [parentNode addSubNode:childNode1];
    [parentNode addSubNode:childNode2];
    [parentNode addSubNode:childNode3];
    [parentNode layout:0];
    [parentNode renderRecursively];
    [self.view addSubview:parentNode.view];
}

- (void)testLayout{

    
    VZFlexNode* containerNode = [VZFlexNode new];
    containerNode.name = @"0";
    containerNode.flexDirection = VZFLEX_DIRECTION_COLUMN;
    containerNode.margin = UIEdgeInsetsMake(0, 0, 10, 0);
    containerNode.size = CGSizeMake(CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds));
    
    
    //layout node1
    VZFlexNode* node1 = [VZFlexNode new];
    node1.name = @"1";
    node1.size = CGSizeMake(CGRectGetWidth(self.view.bounds), 100);
    node1.flexDirection = VZFLEX_DIRECTION_ROW;
    
    VZFlexNode* imageNode = [VZFlexNode new];
    imageNode.name = @"1-1";
    imageNode.size = CGSizeMake(100, 100);
    [node1 addSubNode:imageNode];
    
    VZFlexNode* rightParentNode = [VZFlexNode new];
    rightParentNode.name = @"1-2";
    rightParentNode.flexValue = 1;
    rightParentNode.flexDirection = VZFLEX_DIRECTION_COLUMN;
    
    [node1 addSubNode:rightParentNode];
    
    //layout node2
    VZFlexNode* rightSubNode1 = [VZFlexNode new];
    rightSubNode1.name = @"1-2-1";
    //    rightSubNode1.size = CGSizeMake(100, NAN);
    rightSubNode1.flexDirection = VZFLEX_DIRECTION_ROW;
    rightSubNode1.justifyContent = VZFLEX_JC_SPACE_BETWEEN;
    VZFlexNode* nameNode = [VZFlexNode new];
    nameNode.name = @"name";
    nameNode.flexValue = 1;
    [rightSubNode1 addSubNode:nameNode];
    VZFlexNode* timeNode = [VZFlexNode new];
    //    timeNode.size = CGSizeMake(100, NAN);
    timeNode.alignSelf = VZFLEX_ALIGN_SELF_STRETCH;
    timeNode.name = @"time";
    timeNode.flexValue = 1;
    [rightSubNode1 addSubNode:timeNode];
    [rightParentNode addSubNode:rightSubNode1];
    
    
    
    VZFlexNode* rightSubNode2 = [VZFlexNode new];
    rightSubNode2.name = @"1-2-2";
    rightParentNode.size = CGSizeMake(0, 30);
    [rightParentNode addSubNode:rightSubNode2];
    
    
    
    
    [containerNode addSubNode:node1];
    [containerNode layout:CGRectGetWidth(self.view.bounds)];
    [containerNode renderRecursively];
    [self.view addSubview:containerNode.view];
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

