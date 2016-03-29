//
//  DetailImageViewController.m
//  丝袜美图
//
//  Created by Miles on 3/28/16.
//  Copyright © 2016 Miles. All rights reserved.
//

#import "DetailImageViewController.h"
#import <MWPhotoBrowser.h>
#import <AFNetworking.h>
#import <MJExtension.h>
#import "ImgData.h"
@interface DetailImageViewController ()

@property(nonatomic,strong)NSMutableArray *dataList;
@end

@implementation DetailImageViewController

- (NSMutableArray *)dataList
{
    if (_dataList == nil) {
       _dataList = [NSMutableArray array];
    }
    return _dataList;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self getData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
