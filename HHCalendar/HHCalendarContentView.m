//
//  HHCalendarContentView.m
//  HHCalendarDemo
//
//  Created by huxuewei on 2022/8/23.
//

#import "HHCalendarContentView.h"
#import "HHCalendarBaseCell.h"
#import "HHCalendarBaseCellModel.h"
#import <HHCommon/HHCommon.h>

@interface HHCalendarContentView ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) HHCalendarContentConfig *config;
@property (nonatomic, strong) HHCalendarDataProvider *dataProvider;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *leftImageView;
@property (nonatomic, strong) UIImageView *rightImageView;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableDictionary<NSString *, HHCalendarBaseCellModel *> *cacheDictionaryM;

@end

@implementation HHCalendarContentView

- (instancetype)initWithFrame:(CGRect)frame config:(HHCalendarContentConfig *)config dataProvider:(HHCalendarDataProvider *)dataProvider {
    if (self = [super initWithFrame:frame]) {
        _config = config;
        _dataProvider = dataProvider;
        _cacheDictionaryM = @{}.mutableCopy;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveMemoryWarning) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
        [self setupSubviews];
        [self setupContraints];
        [self bindingBlockInfo];
    }
    return self;
}

- (void)setupSubviews {
    self.scrollView = [UIScrollView new];
    [self addSubview:self.scrollView];
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.scrollEnabled = NO;
    self.scrollView.pagingEnabled = YES;
    
    self.leftImageView = [UIImageView new];
    [self.scrollView addSubview:self.leftImageView];
    self.leftImageView.contentMode = UIViewContentModeTop;
    
    self.rightImageView = [UIImageView new];
    [self.scrollView addSubview:self.rightImageView];
    self.rightImageView.contentMode = UIViewContentModeTop;
    
    self.flowLayout = [self createFlowLayout];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.flowLayout];
    [self.scrollView addSubview:self.collectionView];
    self.collectionView.bounces = NO;
    self.collectionView.layer.masksToBounds = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.backgroundColor = UIColor.clearColor;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    CGFloat margin = floor(self.config.calendarWidth) - (self.flowLayout.itemSize.width * 7 + 6 * self.config.columnSpacing);
    self.collectionView.contentInset = UIEdgeInsetsMake(0, margin, 0, 0);
    [self.collectionView registerClass:[HHCalendarBaseCell class] forCellWithReuseIdentifier:NSStringFromClass([HHCalendarBaseCell class])];
    for (Class class in self.config.cellClassArray) {
        if ([class isSubclassOfClass:HHCalendarBaseCell.class]) {
            [self.collectionView registerClass:class forCellWithReuseIdentifier:NSStringFromClass(class)];
        }
    }
    @weakly(self);
    self.dataProvider.dateChangedBlock = ^{
        @strongly(self);
        [self.collectionView reloadData];
        if (self.dateChangedBlock) {
            self.dateChangedBlock();
        }
    };
    self.dataProvider.styleChangedBlock = ^{
        @strongly(self);
        [self.collectionView reloadData];
        if (self.styleChangedBlock) {
            self.styleChangedBlock();
        }
    };
}

- (void)setupContraints {
    self.scrollView.around_();
    self.leftImageView.top_.left_.bott_.centY_.equalTo(self.scrollView).on_();
    self.leftImageView.widt_.offset_(floor(self.config.calendarWidth)).on_();
    
    self.collectionView.left_.equalTo(self.leftImageView.righ_).on_();
    self.collectionView.top_.bott_.centY_.widt_.equalTo(self.leftImageView).on_();
    
    self.rightImageView.left_.equalTo(self.collectionView.righ_).on_();
    self.rightImageView.top_.bott_.widt_.equalTo(self.collectionView).on_();
    self.rightImageView.righ_.equalTo(self.scrollView).on_();
    [self setNeedsLayout];
    [self layoutIfNeeded];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.scrollView setContentOffset:CGPointMake(floor(self.config.calendarWidth), 0) animated:NO];
    });
}

- (void)beforePreviousAction {
    if (self.config.shouldShowChangeAnimation == NO) {
        return;
    }
    UIImage *image = [self snapShotWithView:self.collectionView];
    self.rightImageView.image = image;
    [self.scrollView setContentOffset:CGPointMake(floor(self.config.calendarWidth) * 2, 0) animated:NO];
}

- (void)afterPreviousAction {
    if (self.config.shouldShowChangeAnimation == NO) {
        return;
    }
    [self.scrollView setContentOffset:CGPointMake(floor(self.config.calendarWidth), 0) animated:YES];
}

- (void)beforeNextAction {
    if (self.config.shouldShowChangeAnimation == NO) {
        return;
    }
    UIImage *image = [self snapShotWithView:self.collectionView];
    self.leftImageView.image = image;
    [self.scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
}

- (void)afterNextAction {
    if (self.config.shouldShowChangeAnimation == NO) {
        return;
    }
    [self.scrollView setContentOffset:CGPointMake(floor(self.config.calendarWidth), 0) animated:YES];
}

- (void)bindingBlockInfo {
    @weakly(self);
    self.config.binding(@selector(setCalendarWidth:), ^{
        @strongly(self);
        [self recreateFlowLayout];
    });
    self.config.binding(@selector(setLineSpacing:), ^{
        @strongly(self);
        [self recreateFlowLayout];
    });
    self.config.binding(@selector(setColumnSpacing:), ^{
        @strongly(self);
        [self recreateFlowLayout];
    });
    self.config.binding(@selector(setShouldShowPlaceholder:), ^{
        @strongly(self);
        [self.cacheDictionaryM enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, HHCalendarBaseCellModel * _Nonnull obj, BOOL * _Nonnull stop) {
            obj.shouldShowPlaceholder = self.config.shouldShowPlaceholder;
        }];
        [self.collectionView reloadData];
    });
}

- (void)recreateFlowLayout {
    self.flowLayout = [self createFlowLayout];
    CGFloat margin = floor(self.config.calendarWidth) - (self.flowLayout.itemSize.width * 7 + 6 * self.config.columnSpacing);
    self.collectionView.contentInset = UIEdgeInsetsMake(0, margin, 0, 0);
    [self.collectionView setCollectionViewLayout:self.flowLayout animated:NO];
    if (self.styleChangedBlock) {
        self.styleChangedBlock();
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.dataProvider.numberOfSections;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataProvider.numberOfItemsInSection;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSDate *date = [self.dataProvider.startDate hh_dateOffset:indexPath.row];
    HHCalendarBaseCellModel *cellModel = [self cellModelWithDate:date];
    HHCalendarBaseCell *baseCell = [collectionView dequeueReusableCellWithReuseIdentifier:cellModel.reuseIdentifier forIndexPath:indexPath];
    [baseCell updateCellWithModel:cellModel];
    return baseCell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    HHCalendarBaseCell *cell = (HHCalendarBaseCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if (self.didSelectItemBlock) {
        self.didSelectItemBlock(cell);
    }
}

- (HHCalendarBaseCellModel *)cellModelWithDate:(NSDate *)date {
    NSString *keyString = [date hh_toString];
    HHCalendarBaseCellModel *cellModel = [self.cacheDictionaryM hh_objectForKeySafely:keyString];
    if (cellModel != nil) {
        [cellModel setupCacheModelWithDataProvider:self.dataProvider date:date];
        return cellModel;
    }
    if (self.config.cellModelClass != nil && [self.config.cellModelClass isSubclassOfClass:HHCalendarBaseCellModel.class]) {
        cellModel = [self.config.cellModelClass new];
    } else {
        cellModel = [HHCalendarBaseCellModel new];
    }
    [self.cacheDictionaryM hh_setObjectSafely:cellModel forKey:keyString];
    [cellModel setupCellModelWithDataProvider:self.dataProvider date:date shouldShowPlaceholder:self.config.shouldShowPlaceholder];
    return cellModel;
}

- (CGSize)contentViewSize {
    CGFloat itemWidth = [self.flowLayout itemSize].width;
    CGFloat lineSpacing = self.config.lineSpacing;
    NSInteger rowCount = self.dataProvider.numberOfRows;
    CGFloat contentHeight = rowCount * (itemWidth + lineSpacing) - lineSpacing;
    return CGSizeMake(floor(self.config.calendarWidth), contentHeight);
}

- (UICollectionViewFlowLayout *)createFlowLayout {
    CGFloat columnSpacing = self.config.columnSpacing;
    CGFloat lineSpacing = self.config.lineSpacing;
    CGFloat itemWidth = floor((floor(self.config.calendarWidth) - 6 * columnSpacing) / 7);
    
    UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
    flowLayout.minimumLineSpacing = lineSpacing;
    flowLayout.minimumInteritemSpacing = columnSpacing;
    flowLayout.itemSize = CGSizeMake(itemWidth, itemWidth);
    return flowLayout;
}

- (void)didReceiveMemoryWarning {
    [self.cacheDictionaryM removeAllObjects];
}

- (UIImage *)snapShotWithView:(UIView *)view {
    UIGraphicsBeginImageContextWithOptions(view.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:context];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return viewImage;
}

@end
