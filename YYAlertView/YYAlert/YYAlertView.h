//
//  YYAlertView.h
//  ResponseLinkPass
//
//  Created by 于云飞 on 17/3/31.
//  Copyright © 2017年 于云飞. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef UIView *(^SubView)(void);
typedef UIControl *(^ActionView)(void);
typedef NSString *(^Block)(void);

@interface YYAlertView : UIView

@property (nonatomic,readonly,strong) NSMutableArray *viewsArray;
@property (nonatomic,readonly,strong) NSMutableArray *controlsArray;

+ (YYAlertView *)alertTitle:(NSString *)title message:(NSString *)message;

- (void)show;
- (void)addView:(SubView)view;
- (void)addActions:(ActionView)button;
- (void)addControl:(ActionView)button Actions:(Block)block;

@end
