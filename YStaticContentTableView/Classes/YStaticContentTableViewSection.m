//
//  YStaticContentTableViewSection.m
//  Pods
//
//  Created by 李遵源 on 2017/2/7.
//
//

#import "YStaticContentTableViewSection.h"

#import <objc/runtime.h>

@interface YStaticContentTableViewSection()

@property (nonatomic, strong) NSMutableSet<NSString *> *reuseIdentifiers;
@property (nonatomic, strong) NSMutableArray<YStaticContentTableViewCellExtraInfo *> *staticContentCells;

@property (nonatomic, strong) NSMutableArray<TTT> *ts;

@property (nonatomic, assign) BOOL statrt;

@property (nonatomic, assign) CFRunLoopObserverRef runLoopObserver;

@end

@implementation YStaticContentTableViewSection

- (YStaticContentTableViewCellExtraInfo *)addCell:(YStaticContentTableViewCellBlock)configurationBlock {
    return [self addCell:configurationBlock whenSelected:nil];
}

- (YStaticContentTableViewCellExtraInfo *)addCell:(YStaticContentTableViewCellBlock)configurationBlock whenSelected:(YStaticContentTableViewCellWhenSelectedBlock)whenSelectedBlock {
    return [self insertCell:configurationBlock whenSelected:whenSelectedBlock atIndexPath:[NSIndexPath indexPathForRow:self.staticContentCells.count inSection:0] animated:NO updateView:NO];
}

- (YStaticContentTableViewCellExtraInfo *)insertCell:(YStaticContentTableViewCellBlock)configurationBlock
       whenSelected:(YStaticContentTableViewCellWhenSelectedBlock)whenSelectedBlock
        atIndexPath:(NSIndexPath *)indexPath
           animated:(BOOL)animated {
    return [self insertCell:configurationBlock whenSelected:whenSelectedBlock atIndexPath:indexPath animated:animated updateView:YES];
}

- (YStaticContentTableViewCellExtraInfo *)insertCell:(YStaticContentTableViewCellBlock)configurationBlock
       whenSelected:(YStaticContentTableViewCellWhenSelectedBlock)whenSelectedBlock
        atIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated updateView:(BOOL)updateView {
    __weak typeof(self) weakSelf = self;
    
    [self.ts addObject:^(NSIndexPath *indexPath){
        
        NSIndexPath *cindexPath = [NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section];
        YStaticContentTableViewCellExtraInfo *staticContentCell = [[YStaticContentTableViewCellExtraInfo alloc] init];
        staticContentCell.configureBlock = configurationBlock;
        staticContentCell.whenSelectedBlock = whenSelectedBlock;
        configurationBlock(staticContentCell, nil, cindexPath);
        [weakSelf.staticContentCells insertObject:staticContentCell atIndex:cindexPath.row];
            if (![weakSelf.reuseIdentifiers containsObject:staticContentCell.reuseIdentifier]) {
                if (staticContentCell.tableViewCellNib) {
                    [weakSelf.tableView registerNib:staticContentCell.tableViewCellNib forCellReuseIdentifier:staticContentCell.reuseIdentifier];
                } else {
                    [weakSelf.tableView registerClass:staticContentCell.tableViewCellSubclass forCellReuseIdentifier:staticContentCell.reuseIdentifier];
                }
                [weakSelf.reuseIdentifiers addObject:staticContentCell.reuseIdentifier];
            }
        
        
        [UIView animateWithDuration:0 animations:^{
            //            [weakSelf.tableView reloadRowsAtIndexPaths:@[cindexPath] withRowAnimation:UITableViewRowAnimationNone];
            [weakSelf.tableView insertRowsAtIndexPaths:@[cindexPath] withRowAnimation:UITableViewRowAnimationNone];
        }];
    }];
    
    
    [self fd_precacheIfNeeded];
    return nil;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        _statrt = NO;
        _ts = [NSMutableArray array];
    }
    return self;
}

- (void)fd_precacheIfNeeded
{
    if (self.statrt) {
        return;
    }
    self.statrt = YES;
    
    CFRunLoopRef runLoop = CFRunLoopGetCurrent();
    CFRunLoopMode runLoopMode = kCFRunLoopCommonModes;
    
    __weak typeof(self) weakSelf = self;
    self.runLoopObserver = CFRunLoopObserverCreateWithHandler
    (kCFAllocatorDefault, kCFRunLoopBeforeWaiting, true, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity _) {
        if (weakSelf.ts.count == 0) {
            weakSelf.statrt = NO;
            CFRunLoopRemoveObserver(runLoop, observer, runLoopMode);
            CFRelease(observer);
            return;
        }
        
        if (weakSelf.tableView.contentOffset.y + weakSelf.tableView.contentInset.top < 0) {
            return;
        }
        
        if ((CFRunLoopCopyCurrentMode(CFRunLoopGetCurrent()) == kCFRunLoopDefaultMode) || (weakSelf.tableView.contentOffset.y + weakSelf.tableView.frame.size.height - weakSelf.tableView.contentInset.top - weakSelf.tableView.contentInset.bottom > weakSelf.tableView.contentSize.height)) {
            id obj = weakSelf.ts[0];
            [weakSelf.ts removeObject:obj];
            [weakSelf performSelector:@selector(fd_precacheIndexPathIfNeeded:)
                             onThread:[NSThread mainThread]
                           withObject:obj
                        waitUntilDone:NO
                                modes:@[NSRunLoopCommonModes]];
        }
    });
    
    CFRunLoopAddObserver(runLoop, self.runLoopObserver, runLoopMode);
}

- (void)fd_precacheIndexPathIfNeeded:(TTT)t
{
    t([NSIndexPath indexPathForRow:self.staticContentCells.count inSection:0]);
//    self.totalHeight += [self.tableView.delegate tableView:self.tableView heightForRowAtIndexPath:[NSIndexPath indexPathForRow:self.staticContentCells.count-1 inSection:0]];
}

- (YStaticContentTableViewCellExtraInfo *)addCell:(YStaticContentTableViewCellBlock)configurationBlock
        animated:(BOOL)animated {
    return [self insertCell:configurationBlock whenSelected:nil atIndexPath:[NSIndexPath indexPathForRow:self.staticContentCells.count inSection:0] animated:animated updateView:YES];
}

- (void)reloadCellAtIndex:(NSUInteger)rowIndex {
    [self reloadCellAtIndex:rowIndex animated:YES];
}

- (void)reloadCellAtIndex:(NSUInteger)rowIndex animated:(BOOL)animated {
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:rowIndex inSection:self.sectionIndex]]
                          withRowAnimation:animated ? UITableViewRowAnimationAutomatic : UITableViewRowAnimationNone];
}

- (void)removeCellAtIndex:(NSUInteger)rowIndex {
    [self removeCellAtIndex:rowIndex animated:NO];
}
- (void)removeCellAtIndex:(NSUInteger)rowIndex animated:(BOOL)animated {
    [self.staticContentCells removeObjectAtIndex:rowIndex];
    
    if(animated) {
        [self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:rowIndex inSection:self.sectionIndex]] withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.tableView performSelector:@selector(reloadData) withObject:nil afterDelay:0.4];
    } else {
        [self.tableView reloadData];
    }
}

- (void)removeAllCells {
    if(self.staticContentCells) {
        [self.staticContentCells removeAllObjects];
    }
}

- (NSString *)description {
    NSMutableString *str = [NSMutableString stringWithString:@"<YStaticContentTableViewSection"];
    
    [str appendFormat:@" sectionIndex='%ld'", (long)self.sectionIndex];
    if(self.headerTitle) [str appendFormat:@" headerTitle='%@'", self.headerTitle];
    if(self.footerTitle) [str appendFormat:@" footerTitle='%@'", self.footerTitle];
    
    for(YStaticContentTableViewCellExtraInfo *cell in self.staticContentCells) {
        [str appendFormat:@"\n      %@", [cell description]];
    }
    [str appendString:@"\n>"];
    
    return [NSString stringWithString:str];
}

- (NSInteger)numberOfRowInSection {
    return [self staticContentCells].count;
}

- (YStaticContentTableViewCellExtraInfo *)cellInfoForRow:(NSInteger)row
{
    return [self staticContentCells][row];
}

#pragma mark - lazyload
- (NSMutableArray<YStaticContentTableViewCellExtraInfo *> *)staticContentCells
{
    if (_staticContentCells == nil) {
        _staticContentCells = [NSMutableArray array];
    }
    return _staticContentCells;
}

- (NSMutableSet<NSString *> *)reuseIdentifiers
{
    if (_reuseIdentifiers == nil) {
        _reuseIdentifiers = [NSMutableSet set];
    }
    return _reuseIdentifiers;
}

- (void)dealloc
{
    if (self.statrt) {
        CFRunLoopRemoveObserver(CFRunLoopGetCurrent(), self.runLoopObserver, kCFRunLoopCommonModes);
        CFRelease(self.runLoopObserver);
    }
}

@end
