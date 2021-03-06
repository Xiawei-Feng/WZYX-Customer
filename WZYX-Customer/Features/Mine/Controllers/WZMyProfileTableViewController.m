//
//  WZMyProfileTableViewController.m
//  WZYX-Customer
//
//  Created by 冯夏巍 on 2018/11/23.
//  Copyright © 2018年 WZYX. All rights reserved.
//

#import "WZMyProfileTableViewController.h"
#import "WZUserPortraitTableViewCell.h"
#import "WZAvatarViewController.h"
#import "WZNameTableViewController.h"
#import "WZGenderTableViewController.h"
#import "WZUserInfoManager.h"
#import "WZUser.h"

@interface WZMyProfileTableViewController ()

@end

@implementation WZMyProfileTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"个人资料";
}

- (void)viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else {
        return 2;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        WZUserPortraitTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kWZUserPortraitTableViewCellRight];
        if (!cell) {
            cell = [[WZUserPortraitTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kWZUserPortraitTableViewCellRight];
        }
        cell.textLabel.text = @"头像";
        cell.avatarImageView.image = [WZUserInfoManager userPortrait];
        return cell;
    } else if (indexPath.section == 1) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ItemCell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"ItemCell"];
        }
        if (indexPath.row == 0) {
            cell.textLabel.text = @"昵称";
            cell.detailTextLabel.text = [WZUser sharedUser].userName;
        } else if (indexPath.row == 1) {
            cell.textLabel.text = @"手机号";
            cell.detailTextLabel.text = [WZUser sharedUser].phoneNumber;
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ItemCell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"ItemCell"];
        }
        if (indexPath.row == 0) {
            cell.textLabel.text = @"性别";
            cell.detailTextLabel.text = [WZUser sharedUser].gender;
        } else if (indexPath.row == 1) {
            cell.textLabel.text = @"地区";
            cell.detailTextLabel.text = @"上海 杨浦";
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            WZAvatarViewController *avatorVC = [[WZAvatarViewController alloc] init];
            [self.navigationController pushViewController:avatorVC animated:YES];
        }
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            WZNameTableViewController *nameVC = [[WZNameTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
            [self.navigationController pushViewController:nameVC animated:YES];
        }
    } else if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            WZGenderTableViewController *genderVC = [[WZGenderTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
            [self.navigationController pushViewController:genderVC animated:YES];
        }
    }
}

@end
