//
//  GJTabBarController.m
//  LGJ
//
//  Created by LGJ on 2018/3/16.
//  Copyright © 2018年 LGJ. All rights reserved.
//

#import "GJTabBarController.h"
#import "GJTabBar.h"
#import "GJBaseNavigationController.h"
#import "UIColor+Extension.h"
#import "GJConfigureManager.h"
#import "GJFunctionManager.h"

//#import "GJHomePageVC.h"

@interface GJTabBarController () <UITabBarControllerDelegate>
@property (nonatomic, strong) GJTabBar *tabbarV;
//@property (nonatomic, strong) GJHomePageVC *homeVC;

@end

@implementation GJTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = self;
    
    // Create owner-tabbar, use KVC repleace system-tabbar  with owner-tabbar.
    _tabbarV = [[GJTabBar alloc] init];
    [self setValue:_tabbarV forKeyPath:@"tabBar"];
    
//    _homeVC = [[GJHomePageVC alloc] init];
    
//    GJBaseNavigationController *firstTab = [self createTabItemVC:_homeVC norImg:@"tabbar_home" selectImg:@"tabbar_home_p" Title:@"首页"];
//    GJBaseNavigationController *secondTab = [self createTabItemVC:_discoverVC norImg:@"tabbar_discover" selectImg:@"tabbar_discover_p" Title:@"发现"];
//    GJBaseNavigationController *thirdTab = [self createTabItemVC:_tabCenterVC norImg:@"" selectImg:@"" Title:@""];
//    GJBaseNavigationController *fourthTab = [self createTabItemVC:_msgVC norImg:@"tabbar_msg" selectImg:@"tabbar_msg_p" Title:@"消息"];
//    GJBaseNavigationController *fifthTab = [self createTabItemVC:_mineVC norImg:@"tabbar_mine" selectImg:@"tabbar_mine_p" Title:@"我的"];
    
//    self.viewControllers = @[firstTab, secondTab, thirdTab, fourthTab, fifthTab];
    [self setBartitleColor];
}

- (void)setBartitleColor{
    [[UITabBar appearance] setTranslucent:NO];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexRGB:@"999999"]} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:APP_CONFIG.darkTextColor} forState:UIControlStateSelected];
    [[UITabBarItem appearance] setTitlePositionAdjustment:UIOffsetMake(0, -3)];
    [self.tabBar setBackgroundImage:CreatImageWithColor([UIColor whiteColor])];
    [self.tabBar setShadowImage:CreatImageWithColor([UIColor colorWithRGB:220 g:220 b:220])];
}

- (GJBaseNavigationController *)createTabItemVC:(UIViewController *)vc norImg:(NSString *)norImg selectImg:(NSString *)selectImg  Title:(NSString *)title {
    GJBaseNavigationController *tab = [[GJBaseNavigationController alloc] initWithRootViewController:vc];
    tab.tabBarItem.image = [[UIImage imageNamed:norImg] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    tab.tabBarItem.selectedImage = [[UIImage imageNamed:selectImg] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    tab.tabBarItem.title = title;
    return tab;
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    return YES;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
