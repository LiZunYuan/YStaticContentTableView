//
//  JMStaticContentTableViewBlocks.h
//  Pods
//
//  Created by 李遵源 on 2017/2/7.
//
//

#import "YStaticContentTableViewBlocks.h"

typedef NS_ENUM(NSInteger, YStaticContentLayoutType) { // 布局方式
    YStaticContentLayoutTypeUnknow,//未知
    YStaticContentLayoutTypeFrame,
    YStaticContentLayoutTypeAutoLayout
};

typedef NS_ENUM(NSInteger, YStaticContentHeightCacheType) { // 高度缓存策略
    YStaticContentHeightCacheTypeIndexPath,//高度对应 indexPath
    YStaticContentHeightCacheTypeReuseIdentifier //高度对应 reuseIdentifier
};

@interface YStaticContentTableViewCellExtraInfo : NSObject

//二选一
@property (nonatomic, strong) Class tableViewCellSubclass;
@property (nonatomic, strong) UINib *tableViewCellNib; // 如果使用nib  则必须写reuseIdentifier

@property (nonatomic, strong, readonly) NSIndexPath *indexPath; // only read

@property (nonatomic, assign) CGFloat cellHeight;// 默认不用填
@property (nonatomic, assign) UITableViewCellEditingStyle editingStyle; // Defaults to 'UITableViewCellEditingStyleNone'
@property (nonatomic, strong) NSString *reuseIdentifier; // Defaults to 'YStaticContentTableViewCellExtraInfo-' + tableViewCellSubclass
@property (nonatomic) BOOL editable; // Defaults to 'NO'
@property (nonatomic) BOOL moveable; // Defaults to 'NO'
@property (nonatomic, assign) YStaticContentLayoutType layoutType; // Defaults to 'YStaticContentLayoutTypeFrame'
@property (nonatomic, assign) YStaticContentHeightCacheType heightCacheType; // Defaults to 'YStaticContentHeightCacheTypeIndexPath'
@property (nonatomic, assign) UITableViewCellStyle cellStyle; // Defaults to 'UITableViewCellEditingStyleNone'

@property (nonatomic, copy) YStaticContentTableViewCellBlock configureBlock;
@property (nonatomic, copy) YStaticContentTableViewCellWhenSelectedBlock whenSelectedBlock;

- (void)setWhenSelectedBlock:(YStaticContentTableViewCellWhenSelectedBlock)whenSelectedBlock;


@end
