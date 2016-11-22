//
//  LLView.h
//  手势解锁
//
//  Created by 张磊 on 2016/11/18.
//  Copyright © 2016年 leilei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LLView : UIView
@property(nonatomic) NSMutableArray *Btns;
@property(nonatomic) NSMutableArray *lineBtns;
@property(nonatomic) CGPoint currentPoint;
@property (nonatomic) BOOL (^password)(NSString *);
@end
