//
//  YStaticContentTableViewSection.h
//  Pods
//
//  Created by 李遵源 on 2017/2/7.
//
//

#import <Foundation/Foundation.h>
#import "YStaticContentTableViewCellExtraInfo.h"

@interface YStaticContentTableViewSection : NSObject

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSString *headerTitle;
@property (nonatomic, strong) NSString *footerTitle;
@property (nonatomic, strong) UIView *footerView;
@property (nonatomic, strong) UIView *headerView;

@property (nonatomic, assign) NSInteger sectionIndex;

- (YStaticContentTableViewCellExtraInfo *)addCell:(YStaticContentTableViewCellBlock)configurationBlock;
- (YStaticContentTableViewCellExtraInfo *)addCell:(YStaticContentTableViewCellBlock)configurationBlock whenSelected:(YStaticContentTableViewCellWhenSelectedBlock)whenSelectedBlock;

- (YStaticContentTableViewCellExtraInfo *)addCell:(YStaticContentTableViewCellBlock)configurationBlock animated:(BOOL)animated;

- (YStaticContentTableViewCellExtraInfo *)insertCell:(YStaticContentTableViewCellBlock)configurationBlock whenSelected:(YStaticContentTableViewCellWhenSelectedBlock)whenSelectedBlock atIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated;

- (YStaticContentTableViewCellExtraInfo *)insertCell:(YStaticContentTableViewCellBlock)configurationBlock whenSelected:(YStaticContentTableViewCellWhenSelectedBlock)whenSelectedBlock atIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated updateView:(BOOL)updateView;

- (void)reloadCellAtIndex:(NSUInteger)rowIndex;
- (void)reloadCellAtIndex:(NSUInteger)rowIndex animated:(BOOL)animated;

- (void)removeAllCells;
- (void)removeCellAtIndex:(NSUInteger)rowIndex;
- (void)removeCellAtIndex:(NSUInteger)rowIndex animated:(BOOL)animated;

- (NSInteger)numberOfRowInSection;
- (YStaticContentTableViewCellExtraInfo *)cellForRow:(NSInteger)row;

@end
