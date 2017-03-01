//
//  YStaticContentTableViewSection.h
//  Pods
//
//  Created by 李遵源 on 2017/2/7.
//
//

#import <Foundation/Foundation.h>
#import "YStaticContentTableViewCell.h"

@interface YStaticContentTableViewSection : NSObject

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSString *headerTitle;
@property (nonatomic, strong) NSString *footerTitle;
@property (nonatomic, strong) UIView *footerView;
@property (nonatomic, strong) UIView *headerView;

@property (nonatomic, assign) NSInteger sectionIndex;

- (YStaticContentTableViewCell *)addCell:(YStaticContentTableViewCellBlock)configurationBlock;
- (YStaticContentTableViewCell *)addCell:(YStaticContentTableViewCellBlock)configurationBlock whenSelected:(YStaticContentTableViewCellWhenSelectedBlock)whenSelectedBlock;

- (YStaticContentTableViewCell *)addCell:(YStaticContentTableViewCellBlock)configurationBlock animated:(BOOL)animated;

- (YStaticContentTableViewCell *)insertCell:(YStaticContentTableViewCellBlock)configurationBlock whenSelected:(YStaticContentTableViewCellWhenSelectedBlock)whenSelectedBlock atIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated;

- (YStaticContentTableViewCell *)insertCell:(YStaticContentTableViewCellBlock)configurationBlock whenSelected:(YStaticContentTableViewCellWhenSelectedBlock)whenSelectedBlock atIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated updateView:(BOOL)updateView;

- (void)reloadCellAtIndex:(NSUInteger)rowIndex;
- (void)reloadCellAtIndex:(NSUInteger)rowIndex animated:(BOOL)animated;

- (void)removeAllCells;
- (void)removeCellAtIndex:(NSUInteger)rowIndex;
- (void)removeCellAtIndex:(NSUInteger)rowIndex animated:(BOOL)animated;

- (NSInteger)numberOfRowInSection;
- (YStaticContentTableViewCell *)cellForRow:(NSInteger)row;

@end
