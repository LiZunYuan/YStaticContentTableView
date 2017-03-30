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
@property (nonatomic, assign) BOOL statrt2;

@property (nonatomic, assign) CGFloat totalHeight;

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
    
    
    NSUInteger row = indexPath.row;
    NSUInteger section = indexPath.section;
    [self.ts addObject:^(){
    
    
    
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
    
//        dispatch_async(dispatch_get_main_queue(), ^{
        
        
        
        NSIndexPath *cindexPath = [NSIndexPath indexPathForRow:row inSection:section];
        YStaticContentTableViewCellExtraInfo *staticContentCell = [[YStaticContentTableViewCellExtraInfo alloc] init];
        staticContentCell.configureBlock = configurationBlock;
        staticContentCell.whenSelectedBlock = whenSelectedBlock;
        configurationBlock(staticContentCell, nil, cindexPath);
        [self.staticContentCells insertObject:staticContentCell atIndex:cindexPath.row];
            if (![self.reuseIdentifiers containsObject:staticContentCell.reuseIdentifier]) {
                if (staticContentCell.tableViewCellNib) {
                    [self.tableView registerNib:staticContentCell.tableViewCellNib forCellReuseIdentifier:staticContentCell.reuseIdentifier];
                } else {
                    [self.tableView registerClass:staticContentCell.tableViewCellSubclass forCellReuseIdentifier:staticContentCell.reuseIdentifier];
                }
                [self.reuseIdentifiers addObject:staticContentCell.reuseIdentifier];
            }
            
            if (YES) {
                if(animated) {
                    [self.tableView insertRowsAtIndexPaths:@[cindexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                } else {
                    [self.tableView reloadData];
                }
            }
            
//        });
        
//    });
        
    
    }];
    
    
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
        [self fd_precacheIfNeeded:^{
        }];
        
//    });
    return nil;
    
    
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.statrt = NO;
        self.statrt2 = NO;
        self.totalHeight = 0;
    }
    return self;
}

- (void)fd_precacheIfNeeded:(void (^)())block
{
    
    [self fd_precacheIfNeededDefault:block];
    
    if (self.statrt) {
        
        
        return;
    }
    self.statrt = YES;
    
    
//    if (!self.fd_precacheEnabled) {
//        return;
//    }
//    
//    // Delegate could use "rowHeight" rather than implements this method.
//    if (![self.delegate respondsToSelector:@selector(tableView:heightForRowAtIndexPath:)]) {
//        return;
//    }
    
    CFRunLoopRef runLoop = CFRunLoopGetCurrent();
    
    // This is a idle mode of RunLoop, when UIScrollView scrolls, it jumps into "UITrackingRunLoopMode"
    // and won't perform any cache task to keep a smooth scroll.
    CFStringRef runLoopMode = NSRunLoopCommonModes;
    
    // Collect all index paths to be precached.
//    NSMutableArray *mutableIndexPathsToBePrecached = self.fd_allIndexPathsToBePrecached.mutableCopy;
    
    // Setup a observer to get a perfect moment for precaching tasks.
    // We use a "kCFRunLoopBeforeWaiting" state to keep RunLoop has done everything and about to sleep
    // (mach_msg_trap), when all tasks finish, it will remove itself.
    CFRunLoopObserverRef observer = CFRunLoopObserverCreateWithHandler
    (kCFAllocatorDefault, kCFRunLoopBeforeWaiting, true, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity _) {
        // Remove observer when all precache tasks are done.
//        if (self.ts.count == 0) {
//            CFRunLoopRemoveObserver(runLoop, observer, runLoopMode);
//            CFRelease(observer);
//            return;
//        }
        // Pop first index path record as this RunLoop iteration's task.
//        NSIndexPath *indexPath = mutableIndexPathsToBePrecached.firstObject;
//        [mutableIndexPathsToBePrecached removeObject:indexPath];
        
        
        if (self.ts > 0 && self.tableView.contentOffset.y + self.tableView.frame.size.height*2 > self.tableView.contentSize.height ) {
            [self.ts removeObject:0];
            
            // This method creates a "source 0" task in "idle" mode of RunLoop, and will be
            // performed in a future RunLoop iteration only when user is not scrolling.
            [self performSelector:@selector(fd_precacheIndexPathIfNeeded:)
                         onThread:[NSThread mainThread]
                       withObject:self.ts[0]
                    waitUntilDone:NO
                            modes:@[NSRunLoopCommonModes]];
        }
    });
    
    CFRunLoopAddObserver(runLoop, observer, runLoopMode);
    
    
    
    
}



- (void)fd_precacheIfNeededDefault:(void (^)())block
{
    
    
    if (self.statrt2 ) {
        return;
    }
    
    self.statrt2 = YES;
    //    if (!self.fd_precacheEnabled) {
    //        return;
    //    }
    //
    //    // Delegate could use "rowHeight" rather than implements this method.
    //    if (![self.delegate respondsToSelector:@selector(tableView:heightForRowAtIndexPath:)]) {
    //        return;
    //    }
    
    CFRunLoopRef runLoop = CFRunLoopGetCurrent();
    
    // This is a idle mode of RunLoop, when UIScrollView scrolls, it jumps into "UITrackingRunLoopMode"
    // and won't perform any cache task to keep a smooth scroll.
    CFStringRef runLoopMode = NSDefaultRunLoopMode;
    
    // Collect all index paths to be precached.
    //    NSMutableArray *mutableIndexPathsToBePrecached = self.fd_allIndexPathsToBePrecached.mutableCopy;
    
    // Setup a observer to get a perfect moment for precaching tasks.
    // We use a "kCFRunLoopBeforeWaiting" state to keep RunLoop has done everything and about to sleep
    // (mach_msg_trap), when all tasks finish, it will remove itself.
    CFRunLoopObserverRef observer = CFRunLoopObserverCreateWithHandler
    (kCFAllocatorDefault, kCFRunLoopBeforeWaiting, true, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity _) {
        // Remove observer when all precache tasks are done.
//        if (self.ts.count == 0) {
//            CFRunLoopRemoveObserver(runLoop, observer, runLoopMode);
//            CFRelease(observer);
//            return;
//        }
        // Pop first index path record as this RunLoop iteration's task.
        //        NSIndexPath *indexPath = mutableIndexPathsToBePrecached.firstObject;
        //        [mutableIndexPathsToBePrecached removeObject:indexPath];
        
        
        if (self.statrt == NO && self.ts.count > 0) {
            [self.ts removeObject:0];
            // This method creates a "source 0" task in "idle" mode of RunLoop, and will be
            // performed in a future RunLoop iteration only when user is not scrolling.
            [self performSelector:@selector(fd_precacheIndexPathIfNeeded:)
                         onThread:[NSThread mainThread]
                       withObject:self.ts[0]
                    waitUntilDone:NO
                            modes:@[NSRunLoopCommonModes]];
        }
        
        
        
    });
    
    CFRunLoopAddObserver(runLoop, observer, runLoopMode);
}


- (void)fd_precacheIndexPathIfNeeded:(TTT)t
{
    t();
    self.totalHeight += [self.tableView.delegate tableView:self.tableView heightForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0 ]];
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

- (NSMutableArray<TTT> *)ts
{
    if (_ts == nil) {
        _ts = [NSMutableArray array];
    }
    return _ts;
}


static char emailAddressKey;
- (BOOL)statrt
{
    return [objc_getAssociatedObject(self, &emailAddressKey) boolValue];
}

- (void)setStatrt:(BOOL)s {
    objc_setAssociatedObject(self, &emailAddressKey, @(s), OBJC_ASSOCIATION_RETAIN);
}



static char emailAddressKey2;
- (BOOL)statrt2
{
    return [objc_getAssociatedObject(self, &emailAddressKey2) boolValue];
}

- (void)setStatrt2:(BOOL)s {
    objc_setAssociatedObject(self, &emailAddressKey2, @(s), OBJC_ASSOCIATION_RETAIN);
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

@end
