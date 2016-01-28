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
    
//    [self testFlexLayout];
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)testFlexLayout{

    flex::FlexLayout layout = {
    
        .content = flex::TextNode{
            
            .text = ""
        
        },
        .direction = flex::FlexDirection::Horizontal,
        .backColor = "yellow",
        .children = {
            
            {
                .content = flex::ImageNode{
                
                
                },
                .width = 100,
//                .height = 100,
                .backColor = "red"
            },
            {
                .width = 100,
                .height = 100,
                .backColor = "aqua"
            },
            {
                .width = 100,
//                .height = 100,
                .backColor = "green"
            },
        
        },
  
    };
    
    flex::layout(layout, {CGRectGetWidth(self.view.bounds),flex::Infinite});

    UIView* view = [self childrenView:layout];
    
    [self.view addSubview:view];

    
    
}

- (UIView* )childrenView:(const flex::FlexLayout&)layout
{
    
    OSView *view;
    
    if (layout.content.node) {
        view = layout.content.node->createView();
    } else {
        view = layout.viewClass.cls ? [[layout.viewClass.cls alloc] init] : [[OSView alloc] init];
    }
    
    view.frame = CGRectMake(layout.result.left, layout.result.top, layout.result.width, layout.result.height);
    view.layer.borderColor = ((OSColor*)layout.borderColor).CGColor;
    view.layer.borderWidth = layout.borderWidth;
    view.layer.cornerRadius = layout.cornerRadius;
    view.backgroundColor = layout.backColor;
    view.clipsToBounds = layout.cornerRadius > 0;
#if FLEX_OSX
    view.flipped = YES;
#endif
    
    for (const auto& child : layout.children) {
        OSView *subview = [self childrenView:child];
        subview.frame = CGRectMake(subview.frame.origin.x + layout.result.paddingLeft + layout.borderWidth, subview.frame.origin.y + layout.result.paddingTop + layout.borderWidth, subview.frame.size.width, subview.frame.size.height);
        [view addSubview:subview];
    }
    
    for (const auto& attr : layout.attrs) {
        attr.first.setter(view, attr.second);
    }
    
    return view;

}


- (void)testFlexHorizontal{
    
    VZFlexNode* parentNode = [VZFlexNode new];
    parentNode.flexDirection = VZFLEX_DIRECTION_ROW;
//    parentNode.justifyContent= VZFLEX_JC_SPACE_BETWEEN;
    parentNode.alignContent = VZFLEX_ALIGN_CONTENT_START;
//    parentNode.position = CGPointMake(250, 250);
    parentNode.size = CGSizeMake(CGRectGetWidth(self.view.bounds), 400);
    VZFlexNode* childNode1 = [VZFlexNode new];
    childNode1.size = CGSizeMake(50, 100);

//    childNode1.flexValue = 1;
    VZFlexNode* childNode2 = [VZFlexNode new];
    childNode2.size = CGSizeMake(80, 100);

//    childNode2.flexValue = 1;
    VZFlexNode* childNode3 = [VZFlexNode new];
    childNode3.size = CGSizeMake(100, 100);
   
    VZFlexNode* childNode4 = [VZFlexNode new];
    childNode4.size = CGSizeMake(60, 80);
    
    VZFlexNode* childNode5 = [VZFlexNode new];
    childNode5.size = CGSizeMake(70, 120);
    VZFlexNode* childNode6 = [VZFlexNode new];
    childNode6.size = CGSizeMake(80, 100);
//    childNode3.flexValue = 1;
    [parentNode addSubNode:childNode1];
    [parentNode addSubNode:childNode2];
    [parentNode addSubNode:childNode3];
    [parentNode addSubNode:childNode4];
    [parentNode addSubNode:childNode5];
    [parentNode addSubNode:childNode6];
    [parentNode layout:0];
    [parentNode renderRecursively];
    [self.view addSubview:parentNode.view];
}


- (void)testVertical{

    VZFlexNode* parentNode = [VZFlexNode new];
    parentNode.flexDirection = VZFLEX_DIRECTION_ROW;
//    parentNode.justifyContent= VZFLEX_JC_SPACE_BETWEEN;
//    parentNode.alignContent = VZFLEX_ALIGN_CONTENT_START;
//    parentNode.margin = UIEdgeInsetsMake(10, 10, 10, 10);
    parentNode.size = CGSizeMake(CGRectGetWidth(self.view.bounds), 120);
    VZFlexNode* childNode1 = [VZFlexNode new];
    childNode1.size = CGSizeMake(50, NAN);
    //    childNode1.flexValue = 1;
    VZFlexNode* childNode2 = [VZFlexNode new];
    childNode2.size = CGSizeMake(60, NAN);
    //    childNode2.flexValue = 1;
    VZFlexNode* childNode3 = [VZFlexNode new];
    childNode3.size = CGSizeMake(30, NAN);
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

