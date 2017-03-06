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


@implementation UITableView (YStaticContentTableView) 

- (void)enableStaticTableView
{
    self.dataSource = self.staticTableViewDataSource;
    self.delegate = self.staticTableViewDelegate;
}

- (void)enableMixStaticTableView:(id<UITableViewDelegate>)delegate dataSource:(id<UITableViewDataSource>)dataSource
{
    self.dataSource = dataSource;
    self.delegate = delegate;
}


#pragma mark - Static Content

- (void)_updateSectionIndexes {
    NSInteger updatedIndex = 0;
    for(YStaticContentTableViewSection *section in self.staticContentSections) {
        section.sectionIndex = updatedIndex;
        updatedIndex++;
    }
}

- (void)removeAllSections {
    if(self.staticContentSections) {
        [self.staticContentSections removeAllObjects];
    }
}

- (YStaticContentTableViewSection *)addSection:(YStaticContentTableViewControllerAddSectionBlock)b {
    
    YStaticContentTableViewSection *section = [[YStaticContentTableViewSection alloc] init];
    section.tableView = self;
    section.sectionIndex = [self.staticContentSections count];
    
    b(section, section.sectionIndex);
    
    [self.staticContentSections addObject:section];
    
    [self _updateSectionIndexes];
    return section;
}

- (YStaticContentTableViewSection *)insertSection:(YStaticContentTableViewControllerAddSectionBlock)b atIndex:(NSUInteger)sectionIndex {
    return [self insertSection:b atIndex:sectionIndex animated:YES];
}
- (YStaticContentTableViewSection *)insertSection:(YStaticContentTableViewControllerAddSectionBlock)b atIndex:(NSUInteger)sectionIndex animated:(BOOL)animated {
    return [self insertSection:b atIndex:sectionIndex animated:YES updateView:YES];
}

- (YStaticContentTableViewSection *)insertSection:(YStaticContentTableViewControllerAddSectionBlock)b atIndex:(NSUInteger)sectionIndex animated:(BOOL)animated updateView:(BOOL)updateView {
    YStaticContentTableViewSection *section = [[YStaticContentTableViewSection alloc] init];
    b(section, sectionIndex);
    [self.staticContentSections insertObject:section atIndex:sectionIndex];
    
    [self _updateSectionIndexes];
    
    if (updateView) {
        if(animated) {
            [self insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationAutomatic];
        } else {
            [self reloadData];
        }
    }
    return section;
}

- (void)removeSectionAtIndex:(NSUInteger)sectionIndex {
    [self removeSectionAtIndex:sectionIndex animated:YES];
}
- (void)removeSectionAtIndex:(NSUInteger)sectionIndex animated:(BOOL)animated {
    [self.staticContentSections removeObjectAtIndex:sectionIndex];
    
    [self _updateSectionIndexes];
    
    if(animated) {
        [self beginUpdates];
        
        [self deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationAutomatic];
        
        [self endUpdates];
    } else {
        [self reloadData];
    }
}

- (void)reloadSectionAtIndex:(NSUInteger)sectionIndex {
    [self reloadSectionAtIndex:sectionIndex animated:YES];
}
- (void)reloadSectionAtIndex:(NSUInteger)sectionIndex animated:(BOOL)animated {
    [self reloadSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:animated ? UITableViewRowAnimationAutomatic : UITableViewRowAnimationNone];
}

- (YStaticContentTableViewSection *)sectionAtIndex:(NSUInteger)sectionIndex {
    return [self.staticContentSections objectAtIndex:sectionIndex];
}

- (YStaticContentTableViewCellExtraInfo *)insertCell:(YStaticContentTableViewCellBlock)configurationBlock
        atIndexPath:(NSIndexPath *)indexPath
           animated:(BOOL)animated {
    
    [self insertCell:configurationBlock
        whenSelected:nil
         atIndexPath:indexPath
            animated:YES];
}

- (YStaticContentTableViewCellExtraInfo *)insertCell:(YStaticContentTableViewCellBlock)configurationBlock
       whenSelected:(YStaticContentTableViewCellWhenSelectedBlock)whenSelectedBlock
        atIndexPath:(NSIndexPath *)indexPath
           animated:(BOOL)animated {
    
    YStaticContentTableViewSection *section = [self sectionAtIndex:indexPath.section];
    
    [section insertCell:configurationBlock 
           whenSelected:whenSelectedBlock 
            atIndexPath:indexPath
               animated:animated];
}


#pragma mark - Headers & Footers
static void *headerTextKey;
- (void)setHeaderText:(NSString *)headerTextValue {
    objc_setAssociatedObject(self, &headerTextKey, headerTextValue, OBJC_ASSOCIATION_COPY);
    
    if(!headerTextValue) {
        self.tableFooterView = nil;
        return;
    }
    
    UIView *headerLabelContainerView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 0.0)];
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0, 10.0, 280.0, 0.0)];
    
    headerLabel.backgroundColor = [UIColor clearColor];
    headerLabel.font = [UIFont systemFontOfSize:15.0];
    headerLabel.textColor = [UIColor colorWithRed:61.0/255.0 green:77.0/255.0 blue:99.0/255.0 alpha:1.0];
    headerLabel.shadowColor = [UIColor colorWithWhite:1.0 alpha:0.65];
    headerLabel.shadowOffset = CGSizeMake(0.0, 1.0);
    headerLabel.textAlignment = NSTextAlignmentCenter;
    headerLabel.numberOfLines = 0;
    
    headerLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    headerLabel.text = self.headerText;
    
    [headerLabel sizeToFit];
    
    CGRect headerLabelContainerViewRect = headerLabelContainerView.frame;
    headerLabelContainerViewRect.size.height = headerLabel.frame.size.height + 10.0;
    headerLabel.frame = headerLabelContainerViewRect;
    
    [headerLabelContainerView addSubview:headerLabel];
    
    CGRect headerLabelFrame = headerLabel.frame;
    headerLabelFrame.size.width = 280.0;
    headerLabelFrame.origin.x = 20.0;
    headerLabelFrame.origin.y = 10.0;
    headerLabelFrame.size.height += 10.0;
    headerLabel.frame = headerLabelFrame;
    
    CGRect containerFrame = headerLabelContainerView.frame;
    containerFrame.size.height = headerLabel.frame.size.height + 10.0;
    headerLabelContainerView.frame = containerFrame;
    
    self.tableHeaderView = headerLabelContainerView;
    
}

- (NSString *)headerText
{
    return objc_getAssociatedObject(self, &headerTextKey);
}


static void *footerTextKey;
- (void)setFooterText:(NSString *)footerTextValue {
    objc_setAssociatedObject(self, &footerTextKey, footerTextValue, OBJC_ASSOCIATION_COPY);
    
    if(!footerTextValue) {
        self.tableFooterView = nil;
        return;
    }
    
    UIView *footerLabelContainerView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 0.0)];
    UILabel *footerLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0, 10.0, 280.0, 0.0)];
    
    footerLabel.backgroundColor = [UIColor clearColor];
    footerLabel.font = [UIFont systemFontOfSize:15.0];
    footerLabel.textColor = [UIColor colorWithRed:61.0/255.0 green:77.0/255.0 blue:99.0/255.0 alpha:1.0];
    footerLabel.shadowColor = [UIColor colorWithWhite:1.0 alpha:0.65];
    footerLabel.shadowOffset = CGSizeMake(0.0, 1.0);
    footerLabel.textAlignment = NSTextAlignmentCenter;
    footerLabel.numberOfLines = 0;
    
    footerLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    footerLabel.text = self.footerText;
    
    [footerLabel sizeToFit];
    
    CGRect footerLabelContainerViewRect = footerLabelContainerView.frame;
    footerLabelContainerViewRect.size.height = footerLabel.frame.size.height + 10.0;
    footerLabel.frame = footerLabelContainerViewRect;
    
    [footerLabelContainerView addSubview:footerLabel];
    
    CGRect footerLabelFrame = footerLabel.frame;
    footerLabelFrame.size.width = 260.0;
    footerLabelFrame.origin.x = 30.0;
    footerLabelFrame.origin.y = 0.0;	
    footerLabel.frame = footerLabelFrame;
    
    CGRect containerFrame = footerLabelContainerView.frame;
    containerFrame.size.height = footerLabel.frame.size.height + 10.0;
    footerLabelContainerView.frame = containerFrame;
    
    self.tableFooterView = footerLabelContainerView;
    
}

- (NSString *)footerText
{
    return objc_getAssociatedObject(self, &footerTextKey);
}

#pragma mark - set get
- (NSMutableArray *)staticContentSections {
    static void *staticContentSectionsKey;
    NSMutableArray *_staticContentSections = objc_getAssociatedObject(self, &staticContentSectionsKey);
    if (!_staticContentSections) {
        objc_setAssociatedObject(self, &staticContentSectionsKey, [NSMutableArray array], OBJC_ASSOCIATION_RETAIN);
    }
    return _staticContentSections;
}

static void *oriTableViewDelegateKey;
- (void)setOriTableViewDelegate:(id<UITableViewDelegate,UITableViewDataSource>)delegate{
    objc_setAssociatedObject(self, &oriTableViewDelegateKey, delegate, OBJC_ASSOCIATION_RETAIN);
}

- (id<UITableViewDelegate,UITableViewDataSource>)oriTableViewDelegate {
    return objc_getAssociatedObject(self, &oriTableViewDelegateKey);
}

- (id<UITableViewDataSource>)staticTableViewDataSource
{
    static void *staticTableViewDataSource;
    id<UITableViewDataSource> _dataSource = objc_getAssociatedObject(self, &staticTableViewDataSource);
    if (!_dataSource) {
        _dataSource = [YStaticContentTableViewDataSource new];
        objc_setAssociatedObject(self, &staticTableViewDataSource, _dataSource, OBJC_ASSOCIATION_RETAIN);
    }
    return _dataSource;
}

- (id<UITableViewDelegate>)staticTableViewDelegate
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
