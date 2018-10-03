  
//
//  ContactManagerListViewController.m
//  
//
//  Created by moxin on 2018-10-02 23:25:02 -0400.
//  Copyright (c) 2018年 . All rights reserved.
//



#import "ContactManagerListViewController.h"
 
#import "ContactManagerListModel.h" 
#import "ContactManagerListViewDataSource.h"
#import "ContactManagerListViewDelegate.h"

@interface ContactManagerListViewController()

 
@property(nonatomic,strong)ContactManagerListModel *contactManagerListModel; 
@property(nonatomic,strong)ContactManagerListViewDataSource *ds;
@property(nonatomic,strong)ContactManagerListViewDelegate *dl;

@end

@implementation ContactManagerListViewController

//////////////////////////////////////////////////////////// 
#pragma mark - setters 



//////////////////////////////////////////////////////////// 
#pragma mark - getters 

   
- (ContactManagerListModel *)contactManagerListModel
{
    if (!_contactManagerListModel) {
        _contactManagerListModel = [ContactManagerListModel new];
        _contactManagerListModel.key = @"__ContactManagerListModel__";
    }
    return _contactManagerListModel;
}


- (ContactManagerListViewDataSource *)ds{

  if (!_ds) {
      _ds = [ContactManagerListViewDataSource new];
   }
   return _ds;
}

 
- (ContactManagerListViewDelegate *)dl{

  if (!_dl) {
      _dl = [ContactManagerListViewDelegate new];
   }
   return _dl;
}


////////////////////////////////////////////////////////////////////////////////////
#pragma mark - life cycle methods

- (void)loadView
{
    [super loadView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //1,config your tableview
    self.tableView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.showsVerticalScrollIndicator = YES;
    self.tableView.separatorStyle = YES;
    
    //2,set some properties:下拉刷新，自动翻页
    self.needLoadMore = NO;
    self.needPullRefresh = NO;

    
    //3，bind your delegate and datasource to tableview
    self.dataSource = self.ds;
    self.delegate = self.dl;
    

    //4,@REQUIRED:YOU MUST SET A KEY MODEL!
    //self.keyModel = self.model;
    
    //5,REQUIRED:register model to parent view controller
    //[self registerModel:self.keyModel];

    //6,Load Data
    //[self load];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //todo..
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    //todo..
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    //todo..
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    //todo..
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}

-(void)dealloc {
    
    //todo..
}

////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - @override methods - VZViewController


////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - @override methods - VZListViewController

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  
  //todo...
  
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath component:(NSDictionary *)bundle{

  //todo:... 

}

//////////////////////////////////////////////////////////// 
#pragma mark - public method 



//////////////////////////////////////////////////////////// 
#pragma mark - private callback method 



@end
 
