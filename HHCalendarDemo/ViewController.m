//
//  ViewController.m
//  HHCalendarDemo
//
//  Created by huxuewei on 2022/8/23.
//

#import "ViewController.h"
#import "HHCalendarView.h"
#import <HHCommon/HHCommon.h>
#import "HHCalendarCustomCellModel.h"
#import "HHCalendarCustomCell.h"

@interface ViewController ()

@property (nonatomic, strong) HHCalendarView *defaultCalendar;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *styleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:styleButton];
    [styleButton setTitle:@"change Style" forState:UIControlStateNormal];
    [styleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [styleButton sizeToFit];
    styleButton.left_.top_.offset_(mAdapter(50)).on_();
    [styleButton addTarget:self action:@selector(styleButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:backButton];
    [backButton setTitle:@"today" forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [backButton sizeToFit];
    backButton.righ_.offset_(-mAdapter(50)).on_();
    backButton.top_.offset_(mAdapter(50)).on_();
    [backButton addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.defaultCalendar = [HHCalendarView createCalendarView:nil];
    [self.view addSubview:self.defaultCalendar];
    self.defaultCalendar.top_.equalTo(backButton.bott_).offset_(10).on_();
    self.defaultCalendar.centX_.equalTo(self.view).on_();
    
    HHCalendarView *customCalendar = [HHCalendarView createCalendarView:^(HHCalendarConfig * _Nonnull config) {
        config.contentConfig.lineSpacing = 0;
        config.contentConfig.columnSpacing = 0;
        config.contentConfig.cellModelClass = HHCalendarCustomCellModel.class;
        config.contentConfig.cellClassArray = @[HHCalendarCustomCell.class];
        config.headerConfig.shouldShowNextMonthAfterToday = NO;
    }];
    [self.view addSubview:customCalendar];
    customCalendar.top_.equalTo( self.defaultCalendar.bott_).offset_(20).on_();
    customCalendar.centX_.equalTo(self.view).on_();
}

- (void)styleButtonAction {
    [self.defaultCalendar toggleCalenderStyle];
}

- (void)backButtonAction {
    [self.defaultCalendar backToToday];
}

@end
