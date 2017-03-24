//
//  YMixListViewController.m
//  YStaticContentTableViewController
//
//  Created by 李遵源 on 2017/2/7.
//  Copyright © 2017年 LiZunYuan. All rights reserved.
//

#import "YMixListViewController.h"
#import "YStaticContentTableView.h"
#import "YCustomCell.h"

@interface YMixListViewController ()

@end

@implementation YMixListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[YCustomCell class] forCellReuseIdentifier:@"customCell"];

    [self.tableView y_enableMixStaticTableView:self dataSource:self];
    
    __weak typeof(self) weakSelf = self;
    [self.tableView y_addSection:^(YStaticContentTableViewSection *section, NSUInteger sectionIndex) {
        for (NSInteger i = 1; i <= 10; i++) {
            [section addCell:^(YStaticContentTableViewCellExtraInfo *staticContentCell, UITableViewCell *cell, NSIndexPath *indexPath) {
                staticContentCell.reuseIdentifier = @"UIControlCell";
                staticContentCell.tableViewCellSubclass = [YCustomCell class];

                YCustomCell *customCell = (YCustomCell *) cell;
                [customCell.btn setTitle:[NSString stringWithFormat:@"static tableview cell - %zd", i] forState:UIControlStateNormal];
                [customCell.btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            }   whenSelected:^(NSIndexPath *indexPath) {
                [[[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"static tableview cell - %zd", indexPath.row] delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil] show];
                [weakSelf.tableView deselectRowAtIndexPath:indexPath animated:YES];
            }];
        }
    }];

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        //使用静态表格
        return [tableView.y_staticTableViewDataSource tableView:tableView numberOfRowsInSection:section];
    }
    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        //使用静态表格
        return [tableView.y_staticTableViewDataSource tableView:tableView cellForRowAtIndexPath:indexPath];
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"customCell" forIndexPath:indexPath];
    cell.textLabel.text = @"原始cell";
    return cell;
}



@end
