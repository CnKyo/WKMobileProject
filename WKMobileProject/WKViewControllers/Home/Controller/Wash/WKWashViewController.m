//
//  WKWashViewController.m
//  WKMobileProject
//
//  Created by mwi01 on 2017/5/10.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKWashViewController.h"
#import "WKWashHeaderView.h"
#import "WKWashTableHeaderView.h"
#import "WKWashTableCell.h"

#import "WKWashBookingViewController.h"
#import "WKMyWashBookingViewController.h"
#import "WKScanDeviceViewController.h"
@interface WKWashViewController ()<WKWashTableHeaderViewDelegate,WKWashHeaderViewDelegate>
{
    BOOL  Display[100];

}
@property (nonatomic,strong)NSMutableArray *questionArr;
@property (nonatomic,strong)NSMutableArray *answerArr;
@property(nonatomic,strong)NSMutableDictionary * dic;
@property(nonatomic,strong)WKWashTableHeaderView *mHeaderView;
@end

@implementation WKWashViewController
{
    WKWashHeaderView *mHeaderView;
    UITableView *mTableView;
    

}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navBarHairlineImageView.hidden = YES;

    //去除导航栏下方的横线
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}
//在页面消失的时候就让navigationbar还原样式
-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navBarHairlineImageView.hidden = NO;

    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"洗衣机";
    self.dic = [[NSMutableDictionary alloc]init];

    self.view.backgroundColor = M_CO;
    self.navBarHairlineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];

    
    mHeaderView = [WKWashHeaderView initView];
//    mHeaderView.frame = CGRectMake(0, 61, DEVICE_Width, 150);
    mHeaderView.delegate = self;
    [self.view addSubview:mHeaderView];
    
    [mHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(64);
        make.height.offset(150);
    }];
    
    mTableView = [UITableView new];
    mTableView.delegate = self;
    mTableView.dataSource = self;
    mTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.view addSubview:mTableView];
    [mTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(mHeaderView.mas_bottom);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    self.tableView = mTableView;
    self.tableView.estimatedRowHeight= 44;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self.tableView registerNib:[UINib nibWithNibName:@"WKWashTableCell" bundle:nil] forCellReuseIdentifier:@"cell"];

    [self addTableViewHeaderRefreshing];
    [self addTableViewFootererRefreshing];
}
- (void)WKWashHeaderViewBtnAction:(NSInteger)mTag{
    switch (mTag) {
        case 1:
        {
        MLLog(@"我要预约");
        
        WKWashBookingViewController *vc = [WKWashBookingViewController new];
        [self pushViewController:vc];

       
        }
            break;
        case 2:
        {
        MLLog(@"我的预约");
        WKMyWashBookingViewController *vc = [WKMyWashBookingViewController new];
        [self pushViewController:vc];
        }
            break;
        case 3:
        {
        UIStoryboard *board = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        WKScanDeviceViewController *vc = [board instantiateViewControllerWithIdentifier:@"scan"];;
        [self pushViewController:vc];
        MLLog(@"立即使用");
        }
            break;
            
        default:
            break;
    }
}
- (void)tableViewHeaderReloadData{
    NSString *answerText1 = @"当初尚未离家时，爷爷奶奶尚且在世，围绕爷爷奶奶周围形成一个大家庭。每年过端午的时候，爷爷会早早带着我们孙辈们较大的一位或二位，";
    NSString *answerText2 = @"当初尚未离家时，爷爷奶奶尚且在世，围绕爷爷奶奶周围形成一个大家庭。每年过端午的时候，爷爷会早早带着我们孙辈们较大的一位或二位，。";
    NSString *answerText3 = @"易连（智能总机）使用手机电信套餐。";
    NSString *answerText4 = @"离开家乡二十多年，从未在端午期间回过家，家乡粽子的味道离得越来越久远，但却又分明留存在难以抹灭的记忆中。浙江、江苏虽属邻省，第二故乡宁波离魂牵梦绕的高邮湖畔也不过五百公里，但粽子的味道却差别甚大。";
    NSString *answerText5 = @"又是一年粽飘香。自古，过端午便有很多的习俗，如悬挂菖蒲艾草、佩香袋、赛龙舟、荡秋千、给小孩涂雄黄、吃咸蛋、吃粽子等等。来自高邮湖畔的我，记忆里只留有吃咸蛋和吃粽子两样，尤其是每年只有一次的吃粽子。";
    NSString *answerText6 = @"嘉兴粽子闻名天下，五芳斋、诸老大等名牌产品出产的肉粽、蛋黄粽、豆沙粽，吃起来很是过瘾，每年过端午时总会吃上很多。可是，不管吃多吃少，每每吃的时候总会想起爷爷亲手包的粽子。";
    
    
    NSString *questionText1 = @"当初尚未离家时，爷爷奶奶尚且在世，围绕爷爷奶奶周围形成一个大家庭。";
    NSString *questionText2 = @"当初尚未离家时，爷爷奶奶尚且在世，围绕爷爷奶奶周围形成一个大家庭。";
    NSString *questionText3 = @"当初尚未离家时，爷爷奶奶尚且在世，围绕爷爷奶奶周围形成一个大家庭。";
    NSString *questionText4 = @"当初尚未离家时，爷爷奶奶尚且在世，围绕爷爷奶奶周围形成一个大家庭。";
    NSString *questionText5 = @"当初尚未离家时，爷爷奶奶尚且在世，围绕爷爷奶奶周围形成一个大家庭。";
    NSString *questionText6 = @"当初尚未离家时，爷爷奶奶尚且在世，围绕爷爷奶奶周围形成一个大家庭。？";
    
    self.questionArr = [[NSMutableArray alloc]initWithObjects:questionText1,questionText2,questionText3,questionText4,questionText5,questionText6, nil];
    
    self.answerArr = [[NSMutableArray alloc] initWithObjects:answerText1,answerText2,answerText3,answerText4,answerText5,answerText6, nil];
    [self.tableView reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return self.questionArr.count;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    if (Display[section] == YES)
        {
        NSLog(@"section----%ld",(long)section);
        return 1;
        }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WKWashTableCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (indexPath.section == 0)
        {
        
        cell.mContent.text = self.answerArr[0];
        
        
        } if (indexPath.section == 1)
            {
            cell.mContent.text = self.answerArr[1];
            }
    if (indexPath.section == 2)
        {
        cell.mContent.text = self.answerArr[2];
        }
    if (indexPath.section == 3)
        {
        cell.mContent.text = self.answerArr[3];
        }
    
    if (indexPath.section == 4)
        {
        cell.mContent.text = self.answerArr[4];
        }
    if (indexPath.section == 5)
        {
        cell.mContent.text = self.answerArr[5];
        }
    
    
    return cell;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 90;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    _mHeaderView = [WKWashTableHeaderView initView];
    _mHeaderView.frame = CGRectMake(0, 0, self.view.frame.size.width, 90);
    _mHeaderView.mContent.text = self.questionArr[section];
    _mHeaderView.mIndexPath = section;
    _mHeaderView.delegate = self;
    
    NSString *mT = Display[section]?@"收起":@"展开";
    UIImage *mImg = Display[section]?[UIImage imageNamed:@"icon_up"]:[UIImage imageNamed:@"icon_down"];
    [_mHeaderView.mExtBtn setImage:mImg forState:0];
    [_mHeaderView.mExtBtn setTitle:mT forState:0];
    [_mHeaderView.mExtBtn setTitleColor:[UIColor colorWithRed:0.81 green:0.81 blue:0.81 alpha:1] forState:0];
    
    
    return _mHeaderView;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)WKWashHeaderExtBtnAction:(NSInteger)mIndexPath{
    Display[mIndexPath] = !Display[mIndexPath];
    NSIndexSet * set = [NSIndexSet indexSetWithIndex:mIndexPath];
    [self.tableView reloadSections:set withRowAnimation:UITableViewRowAnimationFade];

}

@end
