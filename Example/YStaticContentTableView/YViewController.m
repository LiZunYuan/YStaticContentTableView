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
#import "YStaticContentTableViewCellExtraInfo.h"

@interface YViewController ()

@end

@implementation YViewController

- (IBAction)doClickTableViewDemo:(id)sender {
    [self.navigationController pushViewController:[YListViewController new] animated:YES];
}
- (IBAction)doClickMixTableViewDemo:(id)sender {
    [self.navigationController pushViewController:[YMixListViewController new] animated:YES];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:99999];
    
    NSDate *preDate = [NSDate date];
    for (int i = 0 ; i < 99999; i++) {
        YStaticContentTableViewCellExtraInfo *staticContentCell = [[YStaticContentTableViewCellExtraInfo alloc] init];
        [staticContentCell setWhenSelectedBlock:^(NSIndexPath *indexPath) {
            int a = 2;
            a = a + 4;
            int b = 2;
            b++;
            int c =34;
            c++;
        }];
        [arr addObject:staticContentCell];
    }
    NSDate *nowDate = [NSDate date];
    
    NSLog(@"%lf",nowDate.timeIntervalSinceNow - preDate.timeIntervalSinceNow);
}

@end
