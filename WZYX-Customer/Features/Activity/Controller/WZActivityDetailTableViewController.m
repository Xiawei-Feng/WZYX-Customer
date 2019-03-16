//
//  WZActivityDetailTableViewController.m
//  WZYX-Customer
//
//  Created by 冯夏巍 on 2018/12/19.
//  Copyright © 2018 WZYX. All rights reserved.
//

#import "WZActivityDetailTableViewController.h"
#import "WZActivityDetailImageCell.h"
#import "WZActivitySubmitOrderButton.h"
#import "DWQSelectAttributes.h"
#import "DWQSelectView.h"
#import <Masonry.h>

#define screen_Width    [UIScreen mainScreen].bounds.size.width
#define screen_Height   [UIScreen mainScreen].bounds.size.height

@interface WZActivityDetailTableViewController () <SelectAttributesDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (nonatomic,strong) DWQSelectView *selectView;//规格属性选择控件
@property (nonatomic,strong) DWQSelectAttributes *selectAttributes;
@property (nonatomic,strong) NSMutableArray *attributesArray;//属性数组

@property (nonatomic,strong) UIView *backgroundView;
@property (nonatomic,strong) NSArray *standardList;
@property (nonatomic,strong) NSArray *standardValueList;
@property (nonatomic,strong) WZActivitySubmitOrderButton *submitButton;
@end

@implementation WZActivityDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"活动详情";
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.dataSource = self;
    self.tableView.delegate =self;
    [self.view addSubview:self.tableView];
    
    [self.view addSubview:self.submitButton];
    
    self.standardList = @[@"日期",@"场次"];
    self.standardValueList = @[@[@"2019-2-25"],@[@"早上",@"下午",@"晚上"]];
    [self initSelectView];
}

#pragma mark - UITableViewDatasource

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    CGRect frame = CGRectMake(0, 0, 0, 0.01);
    UIView *view  = [[UIView alloc] initWithFrame:frame];
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    CGRect frame = CGRectMake(0, 0, 0, 0.01);
    UIView *view  = [[UIView alloc] initWithFrame:frame];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 3) {
        return 10;
    }
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 3) {
        return 20;
    }
    return 0.01;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        return 4;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {//detail image
        WZActivityDetailImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ImageCell"];
        if (!cell) {
            cell = [[WZActivityDetailImageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ImageCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.textLabel.text = @"假装这是一张图片";
        return cell;
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {//价格
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PriceCell"];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PriceCell"];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            cell.textLabel.text = @"$XXX";
            cell.textLabel.font = [UIFont systemFontOfSize:22];
            cell.textLabel.textColor = [UIColor redColor];
            return cell;
        } else if (indexPath.row == 1) {//活动名称
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ActivityNameCell"];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ActivityNameCell"];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            cell.textLabel.text = @"这是一个测试活动";
            cell.textLabel.font = [UIFont boldSystemFontOfSize:18];
            return cell;
        } else if (indexPath.row == 2) {//活动时间
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TimeCell"];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"TimeCell"];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            cell.textLabel.text = @"活动时间";
            cell.detailTextLabel.text = @"2018.12.19";
            cell.detailTextLabel.textColor = [UIColor blackColor];
            return cell;
        } else if (indexPath.row == 3){
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PlaceCell"];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"PlaceCell"];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            cell.textLabel.text = @"活动地点";
            cell.detailTextLabel.text = @"上海世博展览馆";
            cell.detailTextLabel.textColor = [UIColor blackColor];
            return cell;
        }
    } else if (indexPath.section == 2) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SelectDateCell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"SelectDateCell"];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.textLabel.text = @"选择时间";
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        return cell;
    } else {
        WZActivityDetailImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ImageCell"];
        if (!cell) {
            cell = [[WZActivityDetailImageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ImageCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.textLabel.text = @"假装这是一张图片";
        return cell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(indexPath.section == 2) {
        [self chooseViewClick];
    }
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 || indexPath.section == 3) {
        return self.view.bounds.size.width;
    }
    return UITableViewAutomaticDimension;
}

#pragma mark - SelectView

- (void)initSelectView {
    self.selectView = [[DWQSelectView alloc] initWithFrame:CGRectMake(0, screen_Height, screen_Width, screen_Height)];
    self.selectView.headImage.image = [UIImage imageNamed:@"duwenquan"];
    self.selectView.LB_price.text = @"￥121.00";
    self.selectView.LB_stock.text = [NSString stringWithFormat:@"库存%@件",@999];
    self.selectView.LB_showSales.text=@"已销售40件";
    self.selectView.LB_detail.text = @"请选择日期与场次";
    [self.view addSubview:self.selectView];
    
    CGFloat maxY = 0;
    CGFloat height = 0;
    for (int i = 0; i < self.standardList.count; i ++) {
        self.selectAttributes = [[DWQSelectAttributes alloc] initWithTitle:self.standardList[i] titleArr:self.standardValueList[i] andFrame:CGRectMake(0, maxY, screen_Width, 40)];
        maxY = CGRectGetMaxY(self.selectAttributes.frame);
        height += self.selectAttributes.dwq_height;
        self.selectAttributes.tag = 8000+i;
        self.selectAttributes.delegate = self;
        
        [self.selectView.mainscrollview addSubview:self.selectAttributes];
    }
    self.selectView.mainscrollview.contentSize = CGSizeMake(0, height);
    
    //加入购物车按钮
    //[self.selectView.addBtn addTarget:self action:@selector(addGoodsCartBtnClick) forControlEvents:UIControlEventTouchUpInside];
    //立即购买
    [self.selectView.buyBtn addTarget:self action:@selector(addGoodsCartBtnClick) forControlEvents:UIControlEventTouchUpInside];
    //取消按钮
    [self.selectView.cancelBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    //点击黑色透明视图choseView会消失
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    [self.selectView.alphaView addGestureRecognizer:tap];
}

- (void)selectBtnTitle:(NSString *)title andBtn:(UIButton *)btn {
    //NSLog(@"%@", title);
}

- (void)dismiss {
    //    center.y = center.y+self.view.frame.size.height;
    [UIView animateWithDuration: 0.35 animations: ^{
        self.selectView.frame =CGRectMake(0, screen_Height, screen_Width, screen_Height);
        self.backgroundView.transform = CGAffineTransformIdentity;
    } completion: nil];
}

- (void)addGoodsCartBtnClick {
    [self enableSubmitButton];
    [self.attributesArray removeAllObjects];
    for (int i=0; i < _standardList.count; i++) {
        DWQSelectAttributes *view = [self.view viewWithTag:8000+i];
        for (UIButton *obj in  view.btnView.subviews) {
            if(obj.selected) {
                for (NSArray *arr in self.standardValueList) {
                    for (NSString *title in arr) {
                        if ([view.selectBtn.titleLabel.text isEqualToString:title]) {
                            [self.attributesArray addObject:view.selectBtn.titleLabel.text];
                        }
                    }
                }
            }
        }
    }
    
    NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:2];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:path];
    cell.detailTextLabel.text = self.attributesArray[0];
    
    [self.submitButton setTitle:@"参加活动" forState:UIControlStateNormal];
    [self.submitButton layoutIfNeeded];
    [self dismiss];
}

- (void)chooseViewClick {
    [UIView animateWithDuration: 0.35 animations: ^{
        self.backgroundView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9);
        self.selectView.frame =CGRectMake(0, 0, screen_Width, screen_Height);
    } completion: nil];
}

#pragma mark - SubmitButton

- (void)enableSubmitButton {
    self.submitButton.backgroundColor = [UIColor redColor];
    self.submitButton.titleLabel.text = @"参加活动";
    self.submitButton.enabled = YES;
}

# pragma mark - LazyLoad

- (UITableView *)tableView {
    if(!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
    }
    return _tableView;
}

- (WZActivitySubmitOrderButton *)submitButton {
    if (!_submitButton) {
        _submitButton = [[WZActivitySubmitOrderButton alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height-80, self.view.bounds.size.width, 80)];
        [_submitButton setTitle:@"请选择参加时间" forState:UIControlStateNormal];
        [_submitButton.titleLabel setTextColor:[UIColor whiteColor]];
        _submitButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        _submitButton.enabled = NO;
        _submitButton.backgroundColor = [UIColor grayColor];
    }
    return _submitButton;
}

- (NSMutableArray *)attributesArray {
    if (!_attributesArray) {
        _attributesArray = [[NSMutableArray alloc] init];
    }
    return _attributesArray;
}

@end