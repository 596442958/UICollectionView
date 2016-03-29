//
//  HomeCollectionViewCell.m
//  丝袜美图
//
//  Created by Miles on 3/27/16.
//  Copyright © 2016 Miles. All rights reserved.
//

#import "HomeCollectionViewCell.h"
#import <Masonry.h>
@implementation HomeCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.image = [[UIImageView alloc]init];
        [self.contentView addSubview:self.image];
        [self.image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(([UIScreen mainScreen].bounds.size.width)/3);
            make.height.mas_equalTo(([UIScreen mainScreen].bounds.size.height)/3);
            make.top.left.right.bottom.mas_equalTo(self.contentView);
        }];
    }
    return self;
}
@end
