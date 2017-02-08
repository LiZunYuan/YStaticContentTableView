# YStaticContentTableView

[![CI Status](http://img.shields.io/travis/LiZunYuan/YStaticContentTableView.svg?style=flat)](https://travis-ci.org/LiZunYuan/YStaticContentTableView)
[![Version](https://img.shields.io/cocoapods/v/YStaticContentTableView.svg?style=flat)](http://cocoapods.org/pods/YStaticContentTableView)
[![License](https://img.shields.io/cocoapods/l/YStaticContentTableView.svg?style=flat)](http://cocoapods.org/pods/YStaticContentTableView)
[![Platform](https://img.shields.io/cocoapods/p/YStaticContentTableView.svg?style=flat)](http://cocoapods.org/pods/YStaticContentTableView)



## Requirements
`YStaticContentTableView` supports iOS 6 and up.


## Install

YStaticContentTableView is available through [CocoaPods]()(http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "YStaticContentTableView"
```


## 示例
### 添加section和cell
这个一个添加section和cell到你的UITableView上的简单例子，需要把你的代码写在控制器的，`viewDidLoad`方法里。把tableView开启静态表格模式`[self.tableView enableStaticTableView]`,
这里你可能需要引入头文件`YStaticContentTableView.h `。你可以和平时一样配置`UITableViewCell`，当然我们也提供`YStaticContentTableViewCell`对象来设置Cell的样式和复用ID。

`YStaticContentTableViewSection`允许你来设置诸如Section标题等。

正如你看到的我们还有一个不错的`whenSelected`block，这允许去写一些代码当我们点击cell时去运行，一个好的例子比如：push 一个 `UIViewController`

```
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView enableStaticTableView];
    
    __weak typeof(self) weakSelf = self;
    [self.tableView addSection:^(YStaticContentTableViewSection *section, NSUInteger sectionIndex) {
        [section addCell:^(YStaticContentTableViewCell *staticContentCell, UITableViewCell *cell, NSIndexPath *indexPath) {
            staticContentCell.reuseIdentifier = @"UIControlCell";
            staticContentCell.tableViewCellSubclass = [YCustomCell class];
            
            YCustomCell *customCell = (YCustomCell *)cell;
            [customCell.btn setTitle:[NSString stringWithFormat:@"cell - %zd",i] forState:UIControlStateNormal];
            [customCell.btn addTarget:weakSelf action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
            [customCell.btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];\
        } whenSelected:^(NSIndexPath *indexPath) {
            [[[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"click - %zd",indexPath.row] delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil] show];
            [weakSelf.tableView deselectRowAtIndexPath:indexPath animated:YES];
        }];
    }];
}
```

### 运行时，插入一个Cell
这个行为就像`addCell:`除了这些，你还可以加上是否需要动画的设置

```
[self.tableView insertCell:^(YStaticContentTableViewCell *staticContentCell, UITableViewCell *cell, NSIndexPath *indexPath) {
	//config cell
} whenSelected:^(NSIndexPath *indexPath) {
	//TODO
} atIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES];
```

### 运行时，插入多个Cell
和上面一样，除了这些我们需要把我们的代码放在`beginUpdates`和`endUpdates`,然后保留我们所有`UITableView`的构建方式，而且还是使用不错，方便的语法。

```
[self.tableView beginUpdates];

for (NSInteger i = 0; i < 99; i++) {
	[self.tableView insertCell:^(YStaticContentTableViewCell *staticContentCell, UITableViewCell *cell, NSIndexPath *indexPath) {
		//config cell
	} whenSelected:^(NSIndexPath *indexPath) {
		//TODO
	} atIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES];
}

[self.tableView endUpdates];
```





## Author

Leal, codekami@qq.com

## License

YStaticContentTableView is available under the MIT license. See the LICENSE file for more info.

