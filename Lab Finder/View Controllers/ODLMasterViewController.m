//
//  ODLMasterViewController.m
//  Lab Finder
//
//  Created by Daniel Tomlinson on 28/04/2014.
//  Copyright (c) 2014 We Are Base. All rights reserved.
//

#import "ODLMasterViewController.h"
#import "ODLMasterViewModel.h"

#import <UIView+AutoLayout/UIView+AutoLayout.h>

@interface ODLMasterViewController () <UITableViewDataSource>
@property (weak, nonatomic) UITableView *tableView;
@end

@implementation ODLMasterViewController

- (id)init
{
    self = [super init];
    if (self)
    {
        _viewModel = [ODLMasterViewModel new];
        [_viewModel updateContent];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[[_viewModel updatedContentSignal] deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(id x)
    {
        [self.tableView reloadData];
    }];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ODLDeviceLabTableViewCell" bundle:[NSBundle mainBundle]]
         forCellReuseIdentifier:@"cell"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.viewModel numberOfSections];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.viewModel numberOfItemsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 67;
}

#pragma mark - Private Methods

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    cell.textLabel.text = [self.viewModel titleAtIndexPath:indexPath];
    cell.detailTextLabel.text = [self.viewModel subtitleAtIndexPath:indexPath];
}

@end
