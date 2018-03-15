//
//  ViewController.m
//  ChatDemo
//
//  Created by Jerry on 2018/3/12.
//  Copyright © 2018年 xuPeng. All rights reserved.
//

#import "FriendsViewController.h"

@interface FriendsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *friendTableView;

@property (nonatomic, strong) NSMutableArray *friendArray;
@end

@implementation FriendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self GetFriends];
    [self setRightBarButtonItem];
    self.friendTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH) style:UITableViewStylePlain];
    self.friendTableView.delegate = self;
    self.friendTableView.dataSource = self;
    [self.view addSubview:self.friendTableView];
}

- (void)setRightBarButtonItem{
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [btn addTarget:self action:@selector(addFriend:) forControlEvents:UIControlEventTouchUpInside];
    [btn setBackgroundImage:[UIImage imageNamed:@"group_creategroup"] forState:UIControlStateNormal];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = rightItem;
}
//添加好友
- (void)addFriend:(UIButton *)sender{
    [[EMClient sharedClient].contactManager addContact:@"8001"
                                               message:@"我想加您为好友"
                                            completion:^(NSString *aUsername, EMError *aError) {
                                                if (!aError) {
                                                    NSLog(@"邀请发送成功");
                                                }
                                            }];
}

//获取好友
- (void)GetFriends{
    //从服务器获取所有的好友
    [[EMClient sharedClient].contactManager getContactsFromServerWithCompletion:^(NSArray *aList, EMError *aError) {
        if (!aError) {
            NSLog(@"获取成功");
            //从数据库获取所有的好友
            NSArray *userlist = [[EMClient sharedClient].contactManager getContacts];
            self.friendArray = [[NSMutableArray alloc] initWithArray:userlist];
        }
    }];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    static NSString *identifier = @"CELL";
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    if (!cell) {
        cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    }
    cell.textLabel.text = @"8002";
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _friendArray.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    EaseMessageViewController *chatController = [[EaseMessageViewController alloc] initWithConversationChatter:@"8001" conversationType:EMConversationTypeChat];
    [self.navigationController pushViewController:chatController animated:YES];
}
- (void)friendRequestDidReceiveFromUser:(NSString *)aUsername
                                message:(NSString *)aMessage;{
    EMError *error = [[EMClient sharedClient].contactManager acceptInvitationForUsername:@"8001"];
    if (!error) {
        NSLog(@"发送同意成功");
    }
}

@end
