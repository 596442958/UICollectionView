//
//  HomeCollectionViewController.m
//  丝袜美图
//
//  Created by Miles on 3/27/16.
//  Copyright © 2016 Miles. All rights reserved.
//

#import "HomeCollectionViewController.h"
#import <Masonry.h>
#import "ImgData.h"
#import <AFNetworking.h>
#import "HomeCollectionViewCell.h"
#import <UIImageView+WebCache.h>
#import "ImgData.h"
#import <MJExtension.h>
#import "DetailImageViewController.h"
@interface HomeCollectionViewController ()

@property(nonatomic,strong)NSMutableArray *dataList;

@end

@implementation HomeCollectionViewController

static NSString * const reuseIdentifier = @"Cell";


- (NSMutableArray *)dataList
{
    if (_dataList == nil) {
        _dataList = [NSMutableArray array];
    }
    return _dataList;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self getData];
    self.collectionView.pagingEnabled = YES;
    self.collectionView.backgroundColor = [UIColor blackColor];
    [self.collectionView registerClass:[HomeCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    UIView *nav = [[UIView alloc]init];
    nav.backgroundColor = [UIColor blackColor];
    nav.alpha = 0.6;
    [self.view addSubview:nav];
    [nav mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(35);
    }];
    UIButton *channelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [channelBtn setBackgroundImage:[UIImage imageNamed:@"ios7_thumb_category"] forState:UIControlStateNormal];
    [nav addSubview:channelBtn];
    [channelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(nav);
        make.left.mas_equalTo(nav).offset(10);
    }];
}

- (instancetype)init
{
    //设置布局
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc]init];
    //设置每个item的大小
    flow.itemSize = CGSizeMake(([UIScreen mainScreen].bounds.size.width)/3, ([UIScreen mainScreen].bounds.size.height)/3);
    //设置间距
    flow.minimumInteritemSpacing = 0;
    flow.minimumLineSpacing = 0;
    //设置横向滚动
    [flow setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    return [super initWithCollectionViewLayout:flow];
}

- (void)getData
{
    NSString *url = @"http://www.tngou.net/tnfs/api/news";
    NSMutableDictionary *paras = [NSMutableDictionary dictionary];
    paras[@"id"] = @"0";
    paras[@"rows"] = @"60";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:url parameters:paras progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *dictWithArray = responseObject[@"tngou"];
        NSArray *imageData = [ImgData mj_objectArrayWithKeyValuesArray:dictWithArray];
        [self.dataList addObjectsFromArray:imageData];
        [self.collectionView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
- (BOOL)prefersStatusBarHidden
{
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.dataList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    ImgData *data = self.dataList[indexPath.row];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://tnfs.tngou.net/image%@",data.img]];
    [cell.image sd_setImageWithURL:url];
    cell.contentView.layer.borderWidth = 0.5;
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    DetailImageViewController *detail = [[DetailImageViewController alloc]init];
    [self presentViewController:detail animated:YES completion:nil];
}
#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
