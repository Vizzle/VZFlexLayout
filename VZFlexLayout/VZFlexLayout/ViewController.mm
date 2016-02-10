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
#import "FNode.h"
#import "VZFNode.h"
#import "VZFStackNode.h"
#import "VZFNodeSubclass.h"
#import "VZFNodeViewManager.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView* tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    // Do any additional setup after loading the view, typically from a nib.
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 40, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds))];
    self.tableView.delegate = self;
    
    self.tableView.dataSource  = self;
   // [self.view addSubview:self.tableView];

    [self headerNodes];
    [self stackNodes];
    
//    void (^block)(id sender) = ^(id sender){};
    VZ::UISpecs specs(
        {
        
            .clz = {[UIView class]},
            .view = {
                .backgroundColor = [UIColor redColor],
                .layer = {
                    .cornerRadius = 50
                }
            },
        
        }
 );
    

    UIView* view = [VZFNodeViewManager viewForConfiguration:specs];
    view.frame = CGRectMake(0, 0, 100, 100);
    [self.view addSubview:view];
    
    
    

    


    
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

- (void)headerNodesCSS{

    
}


- (void)headerNodes{

    float w = CGRectGetWidth(self.view.bounds);
    
    VZFlexNode* parentNode = [VZFlexNode new];
    parentNode.flexDirection = VZFLEX_DIRECTION_HORIZONTAL;

    VZFlexNode* imageNode = [VZFlexNode new];
    imageNode.size = {40,40};
    [parentNode addSubNode:imageNode];

    
    
    VZFlexNode* rightNode = [VZFlexNode new];
    rightNode.flexDirection = VZFLEX_DIRECTION_VERTICAL;
    rightNode.flexGrow = 1;
    
    
    VZFlexNode* rightTopPlaceHolder = [VZFlexNode new];
    rightTopPlaceHolder.flexDirection = VZFLEX_DIRECTION_HORIZONTAL;
    rightTopPlaceHolder.justifyContent = VZFLEX_JC_SPACE_BETWEEN;
    rightTopPlaceHolder.flexGrow = 1;
    rightTopPlaceHolder.margin = UIEdgeInsetsMake(0, 10, 0, 10);
    
    VZFlexNode* nameNode = [VZFlexNode new];
    nameNode.name = @"name";
    nameNode.size = CGSizeMake(50, 14);
    nameNode.margin = UIEdgeInsetsMake(5, 0, 0, 0);
    [rightTopPlaceHolder addSubNode:nameNode];
    
    VZFlexNode* textNode = [VZFlexNode new];
    textNode.name = @"time";
    textNode.size = CGSizeMake(50, 14);
    textNode.margin = UIEdgeInsetsMake(5, 0, 0, 0);
    [rightTopPlaceHolder addSubNode:textNode];
    
    
    VZFlexNode* starNode = [VZFlexNode new];
    starNode.margin = UIEdgeInsetsMake(10, 10, 0, 0);
    starNode.size = CGSizeMake(100, 25);
    starNode.name = @"star";
  
    
    
    [rightNode addSubNode:rightTopPlaceHolder];
    [rightNode addSubNode:starNode];
    [parentNode addSubNode:rightNode];
    
    
    [parentNode layout: {float(w),VZFLEX_INFINITE}];
    CGRect rightNodeResult = [rightNode frame];
    CGRect result = [parentNode frame];
    int a = 0;
//    [parentNode renderRecursively];
//    [self.view addSubview:parentNode.view];
//    parentNode

}

- (void)stackNodes{

    VZFNode* imageNode = [VZFNode nodeWithSpecs:{
        {
            .clz = [UIImageView class],
            .view = {
                .backgroundColor = [UIColor redColor],
                .clipToBounds = YES,
                .layer = {
                
                    .cornerRadius = 10,
                    .borderColor = [UIColor whiteColor]
                }
            }
        }
    
    
    } FlexAttributes:{
        
        .width  = 100,
        .height = 100,
        .marginTop = 10,
        .marginLeft = 10
    
    }];
    
    VZFNode* textNode = [VZFNode nodeWithSpecs:{
        {
            .clz = [UILabel class],
            .view = {
                .backgroundColor = [UIColor yellowColor]
            }
        }
    
    } FlexAttributes:{
        .marginTop = 10,
        .marginLeft = 10,
        .height = 14,
        .flexGrow = 1
    
    }];
    
    VZFStackNode* stackNode = [VZFStackNode nodeWithStackLayout:{
        .direction = VZFStackLayoutDirectionHorizontal,
        
    } Children:{
        
        
        {.node = imageNode},
        {.node = textNode,.spacingBefore = 10},
        
    }];

    CGSize sz = CGSizeMake(self.view.bounds.size.width, 1000);
    VZFNodeLayout layout = [stackNode  computeLayoutThatFits:sz];
    NSLog(@"%s",layout.nodeDesc().c_str());
    

}

@end

