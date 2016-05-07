//
//  ViewController.m
//  FDTemplateLayoutCellStudy
//
//  Created by 曹学亮 on 16/4/30.
//  Copyright © 2016年 xueliang cao. All rights reserved.
//

#import "ViewController.h"
#import <Masonry/Masonry.h>
#import "UITableView+FDTemplateLayoutCell.h"
#import "TemplateCell.h"
#import "TemplateEntity.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *autoLayoutTableView;
@property (nonatomic,strong) NSMutableArray *prototypeEntitiesFromJSON;

@end

@implementation ViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.autoLayoutTableView.fd_debugLogEnabled = YES;//允许log输出
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"cell自动布局";
    [self.view addSubview:self.autoLayoutTableView];
    [self layoutTableView];
    [self.autoLayoutTableView registerClass:[TemplateCell class] forCellReuseIdentifier:@"autoCell"];
    self.autoLayoutTableView.delegate = self;
    self.autoLayoutTableView.dataSource = self;
    //必须设置 estimatedRowHeight
    self.autoLayoutTableView.estimatedRowHeight = 170;
    //加载数据
    [self getData];
}

- (void)layoutTableView{
  [self.autoLayoutTableView mas_makeConstraints:^(MASConstraintMaker *make) {
      make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 0, 0));
  }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)getData{
    //模仿一个异步请求
//   dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
       //从json.data获取数据
       NSString *dataFilePath = [[NSBundle mainBundle]pathForResource:@"data" ofType:@"json"];
       NSData *data = [NSData dataWithContentsOfFile:dataFilePath];
        NSDictionary *rootDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
       NSArray *feedArray = rootDict[@"feed"];
       
       //将数据装换为entity
       self.prototypeEntitiesFromJSON = @[].mutableCopy;
       [feedArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
           NSDictionary * tmp = obj;
           TemplateEntity *entity = [[TemplateEntity alloc]initWithDictionary:tmp];
           [self.prototypeEntitiesFromJSON addObject:entity];
       }];
    
       [self.autoLayoutTableView reloadData];
       //(在主线程中更新界面)
//       dispatch_sync(dispatch_get_main_queue(), ^{
//           !then ?: then();
//       });
//   });
}

#pragma mark - UITableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.prototypeEntitiesFromJSON.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TemplateCell *cell = [tableView dequeueReusableCellWithIdentifier:@"autoCell"];
    [self configCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)configCell:(TemplateCell *)cell atIndexPath:(NSIndexPath *)indexPath{
    TemplateEntity * entity = self.prototypeEntitiesFromJSON[indexPath.row];
    //cell.fd_enforceFrameLayout = YES;// Enable to use "-sizeThatFits:"
    if (indexPath.row % 2 == 0) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else{
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    //为cell赋值
    cell.entity = entity;
}

#pragma mark - UITableView Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
  //按索引缓存高度
  return [tableView fd_heightForCellWithIdentifier:@"autoCell" cacheByIndexPath:indexPath configuration:^(id cell) {
    [self configCell:cell atIndexPath:indexPath];
}];
}

#pragma mark - setter && getter
- (UITableView *)autoLayoutTableView{
    if (!_autoLayoutTableView) {
        _autoLayoutTableView = [[UITableView alloc]init];
        _autoLayoutTableView.backgroundColor = [UIColor clearColor];
    }
    return _autoLayoutTableView;
}
@end
