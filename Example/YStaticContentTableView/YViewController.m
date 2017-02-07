//
//  YViewController.m
//  YStaticContentTableView
//
//  Created by LiZunYuan on 02/07/2017.
//  Copyright (c) 2017 LiZunYuan. All rights reserved.
//

#import "YViewController.h"
#import "YMixListViewController.h"
#import "YListViewController.h"

@interface YViewController ()

@end

@implementation YViewController

- (IBAction)doClickTableViewDemo:(id)sender {
    [self.navigationController pushViewController:[YListViewController new] animated:YES];
}
- (IBAction)doClickMixTableViewDemo:(id)sender {
    [self.navigationController pushViewController:[YMixListViewController new] animated:YES];
}

@end
