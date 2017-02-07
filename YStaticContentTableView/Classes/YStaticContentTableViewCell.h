//
//  JMStaticContentTableViewBlocks.h
//  Pods
//
//  Created by 李遵源 on 2017/2/7.
//
//

#import "YStaticContentTableViewBlocks.h"

@interface YStaticContentTableViewCell : NSObject

@property (nonatomic, strong) NSString *reuseIdentifier;
@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic) CGFloat cellHeight;
@property (nonatomic) UITableViewCellStyle cellStyle;
@property (nonatomic, strong) Class tableViewCellSubclass;
@property (nonatomic) UITableViewCellEditingStyle editingStyle; // Defaults to 'UITableViewCellEditingStyleNone'
@property (nonatomic) BOOL editable; // Defaults to 'NO'
@property (nonatomic) BOOL moveable; // Defaults to 'NO'

@property (nonatomic, copy) YStaticContentTableViewCellBlock configureBlock;
@property (nonatomic, copy) YStaticContentTableViewCellWhenSelectedBlock whenSelectedBlock;

- (void)setWhenSelectedBlock:(YStaticContentTableViewCellWhenSelectedBlock)whenSelectedBlock;

@end
