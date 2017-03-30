//
//  YListViewController.m
//  YStaticContentTableViewController
//
//  Created by 李遵源 on 2017/2/7.
//  Copyright © 2017年 LiZunYuan. All rights reserved.
//

#import "YListViewController.h"
#import "YStaticContentTableView.h"
#import "YCustomCell.h"

@interface YListViewController ()

@end

@implementation YListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView y_enableStaticTableView];
    
    __weak typeof(self) weakSelf = self;
    [self.tableView y_addSection:^(YStaticContentTableViewSection *section, NSUInteger sectionIndex) {
        for (NSInteger i = 1; i <= 999999; i++) {
            [section addCell:^(YStaticContentTableViewCellExtraInfo *staticContentCell, UITableViewCell *cell, NSIndexPath *indexPath) {
                staticContentCell.reuseIdentifier = @"UIControlCell";
                staticContentCell.tableViewCellSubclass = [YCustomCell class];
//                staticContentCell.cellHeight = 10;

                YCustomCell *customCell = (YCustomCell *) cell;
                [customCell.btn setTitle:[NSString stringWithFormat:@"cell - %zd", i] forState:UIControlStateNormal];
                [customCell.btn addTarget:weakSelf action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
                [customCell.btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

            }   whenSelected:^(NSIndexPath *indexPath) {
                [[[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"click - %zd", indexPath.row] delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil] show];
                [weakSelf.tableView deselectRowAtIndexPath:indexPath animated:YES];
            }];
        }
    }];
}


- (void)btnClick
{
    [[[UIAlertView alloc] initWithTitle:@"提示" message:@"点击了按钮" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil] show];
}

@end
