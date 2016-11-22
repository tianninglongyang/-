//
//  LLView.m
//  手势解锁
//
//  Created by 张磊 on 2016/11/18.
//  Copyright © 2016年 leilei. All rights reserved.
//

#import "LLView.h"

@implementation LLView
-(NSMutableArray *)Btns
{
    if (_Btns ==nil) {
        _Btns = [NSMutableArray array];
        for (int i = 0;i<9; i++) {
            UIButton *btn = [[UIButton alloc] init];
            [btn setBackgroundImage:[UIImage imageNamed:@"0"] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageNamed:@"2"] forState:UIControlStateSelected];
            [btn setBackgroundImage:[UIImage imageNamed:@"1"] forState:UIControlStateDisabled];
            [btn setUserInteractionEnabled:NO];
            btn.tag =i;
            [self addSubview:btn];
            [self.Btns addObject:btn];
        }

          }
    return _Btns;
}
-(NSMutableArray *)lineBtns
{
    if (!_lineBtns) {
        _lineBtns = [NSMutableArray array];
    }
    return _lineBtns;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    for (int i = 0; i<9; i++) {
        UIButton *btn = self.Btns[i];
        CGFloat margin = 33;
        CGFloat btnw = 56;
        CGFloat btnh = 56;
        CGFloat btnx = (i%3)*btnw+margin*(i%3+1);
        CGFloat btny = i/3*btnh+margin*(i/3+1);
        btn.frame = CGRectMake(btnx, btny, btnw, btnh);
    }
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *t = touches.anyObject;
    CGPoint p = [t locationInView:self];
    
    for (int i = 0; i<9; i++) {
        UIButton *btn = self.Btns[i];
        if (CGRectContainsPoint(btn.frame,p)==YES) {
            btn.selected = YES;
            [self.lineBtns addObject:btn];
        }
    }
    [self setNeedsDisplay];
}
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *t = touches.anyObject;
    CGPoint p = [t locationInView:self];
    self.currentPoint = p;
    for (int i = 0; i<9; i++) {
        UIButton *btn = self.Btns[i];
        if (CGRectContainsPoint(btn.frame,p)==YES) {
            btn.selected = YES;
            if (![self.lineBtns containsObject:btn]) {
                [self.lineBtns addObject:btn];
            }
        }
    }
    
    [self setNeedsDisplay];
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UIButton *lastBtn = [self.lineBtns lastObject];
    self.currentPoint = lastBtn.center;
    [self setNeedsDisplay];
    NSString *password = @"";
    
    
    for (int i = 0; i<self.lineBtns.count; i++) {
        UIButton *btn = self.lineBtns[i];
        password = [password stringByAppendingString:[NSString stringWithFormat:@"%ld",btn.tag]];
        btn.selected = NO;
        btn.enabled = NO;
    }
    if (self.password) {
        if (self.password(password)==YES) {
            NSLog(@"right");
        }
        else{
            NSLog(@"wrong");
        }
    }
    [self setUserInteractionEnabled:NO];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self clear];
        [self setUserInteractionEnabled:YES];
    });
}
-(void)clear
{
    for (int i = 0; i<9; i++) {
        UIButton *btn = self.Btns[i];
        btn.selected = NO;
        btn.enabled = YES;
    }
    [self.lineBtns removeAllObjects];
    [self setNeedsDisplay];

}
-(void)drawRect:(CGRect)rect
{
    if (!self.lineBtns.count) {
        return;
    }
    UIBezierPath *path = [UIBezierPath bezierPath];
    for (int i = 0; i<self.lineBtns.count; i++) {
        UIButton *btn = self.lineBtns[i];
        if (i==0) {
            [path moveToPoint:btn.center];
        }
        else{
            [path addLineToPoint:btn.center];
        }
        
    }
    [path addLineToPoint:self.currentPoint];

    
    [[UIColor greenColor] set];
    [path setLineJoinStyle:kCGLineJoinRound];
    [path setLineCapStyle:kCGLineCapRound];
    [path setLineWidth:8];
    [path stroke];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
