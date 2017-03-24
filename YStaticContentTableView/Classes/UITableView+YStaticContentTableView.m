//
//  UITableView+YStaticContentTableView.m
//  Pods
//
//  Created by 李遵源 on 2017/2/7.
//
//

#import "UITableView+YStaticContentTableView.h"
#import <Objc/runtime.h>
#import "YStaticContentTableViewDelegate.h"
#import "YStaticContentTableViewDataSource.h"
#import "UITableView+YStaticContentTableViewPrivate.m"


@implementation UITableView (YStaticContentTableView) 

- (void)y_enableStaticTableView
{
    self.dataSource = self.y_staticTableViewDataSource;
    self.delegate = self.y_staticTableViewDelegate;
}

- (void)y_enableMixStaticTableView:(id <UITableViewDelegate>)delegate dataSource:(id<UITableViewDataSource>)dataSource
{
    [self y_enableStaticTableView];
    if (dataSource) {
        self.dataSource = dataSource;
    }
    if (delegate) {
        self.delegate = delegate;
    }
}

#pragma mark - Static Content
- (void)y_updateSectionIndexes {
    NSInteger updatedIndex = 0;
    for(YStaticContentTableViewSection *section in self.y_staticContentSections) {
        section.sectionIndex = updatedIndex;
        updatedIndex++;
    }
}

- (void)y_removeAllSections {
    if(self.y_staticContentSections) {
        [self.y_staticContentSections removeAllObjects];
    }
}

- (YStaticContentTableViewSection *)y_addSection:(YStaticContentTableViewControllerAddSectionBlock)b {
    YStaticContentTableViewSection *section = [[YStaticContentTableViewSection alloc] init];
    section.tableView = self;
    section.sectionIndex = [self.y_staticContentSections count];
    b(section, section.sectionIndex);
    [self.y_staticContentSections addObject:section];
    [self y_updateSectionIndexes];
    return section;
}

- (YStaticContentTableViewSection *)y_insertSection:(YStaticContentTableViewControllerAddSectionBlock)b atIndex:(NSUInteger)sectionIndex {
    return [self y_insertSection:b atIndex:sectionIndex animated:YES];
}
- (YStaticContentTableViewSection *)y_insertSection:(YStaticContentTableViewControllerAddSectionBlock)b atIndex:(NSUInteger)sectionIndex animated:(BOOL)animated {
    return [self y_insertSection:b atIndex:sectionIndex animated:YES updateView:YES];
}

- (YStaticContentTableViewSection *)y_insertSection:(YStaticContentTableViewControllerAddSectionBlock)b atIndex:(NSUInteger)sectionIndex animated:(BOOL)animated updateView:(BOOL)updateView {
    YStaticContentTableViewSection *section = [[YStaticContentTableViewSection alloc] init];
    b(section, sectionIndex);
    [self.y_staticContentSections insertObject:section atIndex:sectionIndex];
    [self y_updateSectionIndexes];
    if (updateView) {
        if(animated) {
            [self insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationAutomatic];
        } else {
            [self reloadData];
        }
    }
    return section;
}

- (void)y_removeSectionAtIndex:(NSUInteger)sectionIndex {
    [self y_removeSectionAtIndex:sectionIndex animated:YES];
}

- (void)y_removeSectionAtIndex:(NSUInteger)sectionIndex animated:(BOOL)animated {
    [self.y_staticContentSections removeObjectAtIndex:sectionIndex];

    [self y_updateSectionIndexes];
    
    if(animated) {
        [self beginUpdates];
        
        [self deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationAutomatic];
        
        [self endUpdates];
    } else {
        [self reloadData];
    }
}

- (void)y_reloadSectionAtIndex:(NSUInteger)sectionIndex {
    [self y_reloadSectionAtIndex:sectionIndex animated:YES];
}

- (void)y_reloadSectionAtIndex:(NSUInteger)sectionIndex animated:(BOOL)animated {
    [self reloadSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:animated ? UITableViewRowAnimationAutomatic : UITableViewRowAnimationNone];
}

- (YStaticContentTableViewSection *)y_sectionAtIndex:(NSUInteger)sectionIndex {
    return self.y_staticContentSections[sectionIndex];
}

- (YStaticContentTableViewCellExtraInfo *)y_insertCell:(YStaticContentTableViewCellBlock)configurationBlock
                                           atIndexPath:(NSIndexPath *)indexPath
                                              animated:(BOOL)animated {
    return [self y_insertCell:configurationBlock
                 whenSelected:nil
                  atIndexPath:indexPath
                     animated:YES];
}

- (YStaticContentTableViewCellExtraInfo *)y_insertCell:(YStaticContentTableViewCellBlock)configurationBlock
                                          whenSelected:(YStaticContentTableViewCellWhenSelectedBlock)whenSelectedBlock
                                           atIndexPath:(NSIndexPath *)indexPath
                                              animated:(BOOL)animated {
    YStaticContentTableViewSection *section = [self y_sectionAtIndex:indexPath.section];
    return [section insertCell:configurationBlock
           whenSelected:whenSelectedBlock 
            atIndexPath:indexPath
               animated:animated];
}

#pragma mark - set get
static void *y_oriTableViewDelegateKey;
- (void)setOriTableViewDelegate:(id<UITableViewDelegate,UITableViewDataSource>)y_oriTableViewDelegate {
    objc_setAssociatedObject(self, &y_oriTableViewDelegateKey, y_oriTableViewDelegate, OBJC_ASSOCIATION_RETAIN);
}

- (id<UITableViewDelegate,UITableViewDataSource>)y_oriTableViewDelegate {
    return objc_getAssociatedObject(self, &y_oriTableViewDelegateKey);
}

- (id<UITableViewDataSource>)y_staticTableViewDataSource
{
    static void *staticTableViewDataSource;
    id<UITableViewDataSource> _dataSource = objc_getAssociatedObject(self, &staticTableViewDataSource);
    if (!_dataSource) {
        _dataSource = [YStaticContentTableViewDataSource new];
        objc_setAssociatedObject(self, &staticTableViewDataSource, _dataSource, OBJC_ASSOCIATION_RETAIN);
    }
    return _dataSource;
}

- (id<UITableViewDelegate>)y_staticTableViewDelegate
{
    static void *staticTableViewDelegate;
    id<UITableViewDelegate> _delegate = objc_getAssociatedObject(self, &staticTableViewDelegate);
    if (!_delegate) {
        _delegate = [YStaticContentTableViewDelegate new];
        objc_setAssociatedObject(self, &staticTableViewDelegate, _delegate, OBJC_ASSOCIATION_RETAIN);
    }
    return _delegate;
}

@end
