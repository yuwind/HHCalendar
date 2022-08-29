//
//  HHCalendarView.m
//  HHCalendarDemo
//
//  Created by huxuewei on 2022/8/23.
//

#import "HHCalendarView.h"
#import "HHCalendarWeekView.h"
#import "HHCalendarContentView.h"
#import "HHCalendarHeaderView.h"
#import <HHCommon/HHCommon.h>

@interface HHCalendarView ()

@property (nonatomic, strong) HHCalendarConfig *config;
@property (nonatomic, strong) HHCalendarDataProvider *dataProvider;
@property (nonatomic, strong) HHCalendarHeaderView *headerView;
@property (nonatomic, strong) HHCalendarWeekView *weekView;
@property (nonatomic, strong) HHCalendarContentView *contentView;

@end

@implementation HHCalendarView

+ (instancetype)createCalendarView:(void (^)(HHCalendarConfig * _Nonnull))configBlock {
    HHCalendarConfig *config = [HHCalendarConfig new];
    if (configBlock) {
        configBlock(config);
    }
    return [[self alloc] initWithFrame:CGRectZero config:config];
}

- (instancetype)initWithFrame:(CGRect)frame config:(HHCalendarConfig *)config {
    if (self = [super initWithFrame:frame]) {
        _config = config;
        _dataProvider = [[HHCalendarDataProvider alloc] initWithConfig:config.contentConfig];
        self.backgroundColor = [UIColor whiteColor];
        [self setupSubviews];
        [self setupConstraints];
        [self bindingBlockInfo];
    }
    return self;
}

- (void)setupSubviews {
    self.headerView = [[HHCalendarHeaderView alloc] initWithFrame:CGRectZero config:self.config.headerConfig];
    [self addSubview:self.headerView];
    self.headerView.layer.masksToBounds = YES;
    @weakly(self);
    self.headerView.previousBlock = ^{
        @strongly(self);
        [self previousAction];
    };
    self.headerView.nextBlock = ^{
        @strongly(self);
        [self nextAction];
    };
    self.headerView.clickDateBlock = ^(NSDate * _Nonnull date) {
        @strongly(self);
        [self clickHeaderDateActionWithDate:date];
    };
    self.headerView.setDateBlock(self.dataProvider.triggerDate);
    
    self.weekView = [[HHCalendarWeekView alloc] initWithFrame:CGRectZero config:self.config.weekConfig];
    [self addSubview:self.weekView];
    self.weekView.layer.masksToBounds = YES;
    
    self.contentView = [[HHCalendarContentView alloc] initWithFrame:CGRectZero config:self.config.contentConfig dataProvider:self.dataProvider];
    [self addSubview:self.contentView];
    self.contentView.styleChangedBlock = ^{
        @strongly(self);
        [self resizeContentView];
    };
    self.contentView.dateChangedBlock = ^{
        @strongly(self);
        self.headerView.setDateBlock(self.dataProvider.triggerDate);
        [self resizeContentView];
    };
    self.contentView.didSelectItemBlock = ^(HHCalendarBaseCell * _Nonnull cell) {
        @strongly(self);
        if (self.didSelectItemBlock) {
            self.didSelectItemBlock(cell);
        }
    };
}

- (void)setupConstraints {
    self.headerView.left_.top_.righ_.equalTo(self).on_();
    if (self.config.shouldShowHeaderView) {
        self.headerView.heit_.offset_(self.config.headerHeight).on_();
        self.weekView.top_.equalTo(self.headerView.bott_).offset_(self.config.headerWeekViewMargin).on_();
    } else {
        self.headerView.heit_.offset_(0).on_();
        self.weekView.top_.equalTo(0).on_();
    }

    self.weekView.left_.righ_.equalTo(self).on_();
    self.weekView.heit_.offset_(self.config.weekViewHeight).on_();
    if (self.config.shouldShowWeekView) {
        self.weekView.heit_.offset_(self.config.weekViewHeight).on_();
        self.contentView.top_.equalTo(self.weekView.bott_).offset_(self.config.weekContentViewMargin).on_();
    } else {
        self.weekView.heit_.offset_(0).on_();
        self.contentView.top_.equalTo(self.weekView.bott_).offset_(0).on_();
    }
    
    CGSize contentSize = [self.contentView contentViewSize];
    self.contentView.left_.righ_.centX_.equalTo(self).on_();
    self.contentView.bott_.equalTo(self).on_();
    self.contentView.size_.offsets_(@(contentSize.width),@(contentSize.height),nil).on_();
}

- (void)bindingBlockInfo {
    @weakly(self);
    self.config.binding(@selector(setShouldShowHeaderView:), ^{
        @strongly(self);
        if (self.config.shouldShowHeaderView) {
            self.headerView.heit_.offset_(self.config.headerHeight).on_();
            self.weekView.top_.equalTo(self.headerView.bott_).offset_(self.config.headerWeekViewMargin).on_();
        } else {
            self.headerView.heit_.offset_(0).on_();
            self.weekView.top_.equalTo(self.headerView.bott_).offset_(0).on_();
        }
    });
    self.config.binding(@selector(setHeaderHeight:), ^{
        @strongly(self);
        self.headerView.heit_.offset_(self.config.headerHeight).on_();
    });
    self.config.binding(@selector(setHeaderWeekViewMargin:), ^{
        @strongly(self);
        self.weekView.top_.equalTo(self.headerView.bott_).offset_(self.config.headerWeekViewMargin).on_();
    });
    self.config.binding(@selector(setShouldShowWeekView:), ^{
        @strongly(self);
        if (self.config.shouldShowWeekView) {
            self.weekView.heit_.offset_(self.config.weekViewHeight).on_();
            self.contentView.top_.equalTo(self.weekView.bott_).offset_(self.config.weekContentViewMargin).on_();
        } else {
            self.weekView.heit_.offset_(0).on_();
            self.contentView.top_.equalTo(self.weekView.bott_).offset_(0).on_();
        }
    });
    self.config.binding(@selector(setWeekViewHeight:), ^{
        @strongly(self);
        self.weekView.heit_.offset_(self.config.weekViewHeight).on_();
    });
    self.config.binding(@selector(setWeekContentViewMargin:), ^{
        @strongly(self);
        self.contentView.top_.equalTo(self.weekView.bott_).offset_(self.config.weekContentViewMargin).on_();
    });
}

- (void)toggleCalenderStyle {
    if (self.config.contentConfig.calendarStyle == HHCalendarStyleWeek) {
        self.config.contentConfig.calendarStyle = HHCalendarStyleMonth;
    } else {
        self.config.contentConfig.calendarStyle = HHCalendarStyleWeek;
    }
}

- (void)previousAction {
    [self.contentView beforePreviousAction];
    [self.dataProvider previousAction];
    [self resizeContentView];
    self.headerView.setDateBlock(self.dataProvider.triggerDate);
    [self.contentView afterPreviousAction];
}

- (void)nextAction {
    [self.contentView beforeNextAction];
    [self.dataProvider nextAction];
    [self resizeContentView];
    self.headerView.setDateBlock(self.dataProvider.triggerDate);
    [self.contentView afterNextAction];
}

- (void)clickHeaderDateActionWithDate:(NSDate *)date {
    if (self.didClickHeaderDateBlock) {
        self.didClickHeaderDateBlock(date);
    }
}

- (void)backToToday {
    [self.dataProvider backToToday];
    [self resizeContentView];
    self.headerView.setDateBlock(self.dataProvider.triggerDate);
}

- (void)backToTriggerDate {
    [self.dataProvider backToTriggerDate];
    [self resizeContentView];
    self.headerView.setDateBlock(self.dataProvider.triggerDate);
}

- (void)resizeContentView {
    self.contentView.heit_.offset_([self.contentView contentViewSize].height).on_();
    self.contentView.widt_.offset_([self.contentView contentViewSize].width).on_();
}

@end
