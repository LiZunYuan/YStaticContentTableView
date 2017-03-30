//
//  YCustomCell.m
//  YStaticContentTableViewController
//
//  Created by 李遵源 on 2017/2/7.
//  Copyright © 2017年 LiZunYuan. All rights reserved.
//

#import "YCustomCell.h"

@implementation YCustomCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self) {
        self.btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:self.btn];
    }
    return self;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    [self.btn setFrame:CGRectMake(0, 0, 200, self.frame.size.height)];
}

- (CGSize)sizeThatFits:(CGSize)size
{
    
//    sleep(1);
    
    
    
    return CGSizeMake(size.width, 44.5);
}

@end
