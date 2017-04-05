//
//  YYAlertView.m
//  ResponseLinkPass
//
//  Created by 于云飞 on 17/3/31.
//  Copyright © 2017年 于云飞. All rights reserved.
//

#import "YYAlertView.h"
#import <objc/runtime.h>

@interface UILabel(Alert)

+ (instancetype)alert_label;
- (CGFloat)alert_textHeight;

@end

@interface YYAlertView ()
{
    UIEdgeInsets _edgeInsets;
}
@property (nonatomic, copy)   NSString *tip;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *content;
@property (nonatomic, strong) UILabel *tips;

@property (nonatomic,readwrite,strong) NSMutableArray *viewsArray;
@property (nonatomic,readwrite,strong) NSMutableArray *controlsArray;



@end

#define __YY_SCREEN_WIDTH   [UIScreen mainScreen].bounds.size.width
#define __YY_SCREEN_HEIGHT  [UIScreen mainScreen].bounds.size.height
#define __YY_ALERT_WIDTH    (__YY_SCREEN_WIDTH * 0.75)
#define __YY_ALERT_CORNER   12
#define __YY_ACTION_HEIGHT  45
#define EDGE_INSET  UIEdgeInsetsMake(10, 15, 20, 15)

@implementation YYAlertView

+ (YYAlertView *)alertTitle:(NSString *)title message:(NSString *)message {
    YYAlertView *alertView = [[YYAlertView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    alertView.title.text = title;
    alertView.content.text = message;
    return alertView;
}

- (id)init {
    if (self = [super init]) {
        [self defaultSetting];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self defaultSetting];
    }
    return self;
}

- (void)defaultSetting {
    
    _edgeInsets = UIEdgeInsetsMake(5, 20, 20, 20);
    self.viewsArray = [NSMutableArray array];
    self.controlsArray = [NSMutableArray array];
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = __YY_ALERT_CORNER;
    self.layer.borderColor = [UIColor colorWithWhite:0.7 alpha:1.0].CGColor;
    self.layer.borderWidth = 0.8;
    [self.layer setMasksToBounds:YES];
}
static UIWindow *window = nil;
- (void)show {
    if (!window) {
        window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        window.windowLevel = UIWindowLevelAlert;
        window.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.4];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignResponder)];
        [window addGestureRecognizer:tap];
    }
    [window makeKeyAndVisible];
    
    [window addSubview:self];
    self.center = window.center;
    
    [UIView animateWithDuration:0.12 animations:^{
        self.layer.transform = CATransform3DMakeScale(1.01, 1.01, 1.0);
    } completion:^(BOOL finished) {
        self.layer.transform = CATransform3DIdentity;
    }];
}

- (void)resignResponder {
    [window endEditing:YES];
}
- (void)dismiss {
    [UIView animateWithDuration:0.1 animations:^{
        self.layer.transform = CATransform3DMakeScale(0.9, 0.9, 1.0);
        self.alpha = 0.2;
        window.alpha = 0.2;
    } completion:^(BOOL finished) {
        self.layer.transform = CATransform3DIdentity;
        [self removeFromSuperview];
        [window resignKeyWindow];
        window.hidden = YES;
        window.alpha = 1.0;
    }];
    
}

- (void)addView:(SubView)view {
    UIView *tempView = view();
    
    if (![self.viewsArray containsObject:tempView]) {
        [self.viewsArray addObject:tempView];
        [self addSubview:tempView];
    }
}

- (void)addActions:(ActionView)button {
    UIControl *tempControl = button();
    if (![self.controlsArray containsObject:tempControl]) {
        [self.controlsArray addObject:tempControl];
        [self addSubview:tempControl];
    }
}

static const void *BUTTON_ASSOCIATED_KEY = @"button_associated_key";

- (void)addControl:(ActionView)button Actions:(Block)block {
    UIControl *tempControl = button();
    if (![self.controlsArray containsObject:tempControl]) {
        [self.controlsArray addObject:tempControl];
        [self addSubview:tempControl];
    }
    objc_setAssociatedObject(tempControl, BUTTON_ASSOCIATED_KEY, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [tempControl removeTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    if (block) {
        [tempControl addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)buttonClick:(UIButton *)sender {
    Block block = objc_getAssociatedObject(sender, BUTTON_ASSOCIATED_KEY);
    NSString *tip = block();
    if (tip && [tip isKindOfClass:[NSString class]] && tip.length > 0) {
        self.tip = tip;
    }else {
        [self dismiss];
    }
}

- (void)setTip:(NSString *)tip {
    if (_tip != tip) {
        _tip = tip;
        self.tips.text = _tip;
        CGRect rect = self.frame;
        rect.size.height += (self.tips.alert_textHeight + EDGE_INSET.left);
        self.frame = rect;
    }
}

- (UILabel *)title {
    if (!_title) {
        UILabel *titleLab = [UILabel alert_label];
        titleLab.textColor = [UIColor blackColor];
        titleLab.font = [UIFont systemFontOfSize:16];
        [self addSubview:_title = titleLab];
    }
    return _title;
}
- (UILabel *)content {
    if (!_content) {
        UILabel *contentLab = [UILabel alert_label];
        contentLab.font = [UIFont systemFontOfSize:13];
        [self addSubview:_content = contentLab];
    }
    return _content;
}
- (UILabel *)tips {
    if (!_tips) {
        UILabel *tipsLab = [UILabel alert_label];
        tipsLab.textColor = [UIColor redColor];
        [self addSubview:_tips = tipsLab];
    }
    return _tips;
}

- (void)layoutSubviews {
    
    __block float height = EDGE_INSET.top;
    // title
    if (self.title && self.title.text.length) {
        self.title.frame = CGRectMake(EDGE_INSET.left, height, __YY_ALERT_WIDTH - (EDGE_INSET.left+EDGE_INSET.right), self.title.alert_textHeight);
        height +=self.title.alert_textHeight;
    }
    // content
    if (self.content && self.content.text.length) {
        self.content.frame = CGRectMake(EDGE_INSET.left, height, __YY_ALERT_WIDTH - (EDGE_INSET.left+EDGE_INSET.right), self.content.alert_textHeight);
        height +=(self.content.alert_textHeight);
    }
    height += 5;
    // subview
    if (self.viewsArray.count) {
        [self.viewsArray enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if ([view isKindOfClass:[UIImageView class]]) {
                CGPoint center = view.center;
                center.x = __YY_ALERT_WIDTH/2.0;
                center.y = height + (view.frame.size.height/2.0);
                view.center = center;
            }else {
                CGRect rect = view.frame;
                rect.origin.x = EDGE_INSET.left;
                rect.origin.y = height;
                rect.size.width = __YY_ALERT_WIDTH - (EDGE_INSET.left+EDGE_INSET.right);
                view.frame = rect;
            }
            height += (view.frame.size.height+EDGE_INSET.top);
        }];
    }else {
        height +=15;
    }
    
    // tips
    if (self.tip.length > 0) {
        self.tips.frame = CGRectMake(EDGE_INSET.left, height, __YY_ALERT_WIDTH - (EDGE_INSET.left+EDGE_INSET.right), self.tips.alert_textHeight);
        height +=self.tips.alert_textHeight+EDGE_INSET.top;
    }
    // actionView
    if (self.controlsArray.count <= 2) {
        
        [self.controlsArray enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL * _Nonnull stop) {
            CGPoint center =  view.center;
            center.x = __YY_ALERT_WIDTH/(self.controlsArray.count*2)*(2*idx+1);
            center.y = height + (__YY_ACTION_HEIGHT/2.0);
            view.center = center;
        }];
        
    }else {
        [self.controlsArray enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL * _Nonnull stop) {
            CGRect rect = view.frame;
            rect.origin.x = EDGE_INSET.left;
            rect.origin.y = height;
            rect.size.width = __YY_ALERT_WIDTH - (EDGE_INSET.left+EDGE_INSET.right);
            view.frame = rect;
            
            height += __YY_ACTION_HEIGHT+EDGE_INSET.top;
        }];
    }
    
    [super layoutSubviews];
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    __block float height = _edgeInsets.top;
    // title's height
    if (self.title && self.title.text.length) {height +=self.title.alert_textHeight;}
    // content's height
    if (self.content && self.content.text.length) {height +=self.content.alert_textHeight;}
    height +=10;
    // view's height of added to it
    if (self.viewsArray.count) {
        [self.viewsArray enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL * _Nonnull stop) {
            height +=(view.frame.size.height+EDGE_INSET.top);
        }];
    }else {
        height +=15;
    }
    // action's height;cancel or confirm
    if (self.controlsArray.count <= 2) {
        height += __YY_ACTION_HEIGHT;
    }else {
        [self.controlsArray enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL * _Nonnull stop) {
            height +=(__YY_ACTION_HEIGHT+EDGE_INSET.top);
            view.layer.cornerRadius = __YY_ALERT_CORNER;
        }];
        height -= EDGE_INSET.top;
    }
    CGRect rect = CGRectZero;
    rect.size.width = __YY_ALERT_WIDTH;
    rect.size.height = height;
    
    self.frame = rect;
}

- (void)drawRect:(CGRect)rect {

    [super drawRect:rect];
    
    if (self.controlsArray.count > 0 && self.controlsArray.count <3) {
        CGContextRef contextRef = UIGraphicsGetCurrentContext();
        
        CGContextSetLineWidth(contextRef, 0.6);
        CGContextSetStrokeColorWithColor(contextRef, [UIColor grayColor].CGColor);
        CGContextMoveToPoint(contextRef, 0, rect.size.height-__YY_ACTION_HEIGHT);
        CGContextAddLineToPoint(contextRef, rect.size.width, rect.size.height-__YY_ACTION_HEIGHT);
        if (self.controlsArray.count == 2) {
            CGContextMoveToPoint(contextRef, rect.size.width/2.0, rect.size.height-__YY_ACTION_HEIGHT);
            CGContextAddLineToPoint(contextRef, rect.size.width/2.0, rect.size.height);
        }
        
        CGContextStrokePath(contextRef);
    }
}

- (void)dealloc {
    NSLog(@"___%@___释放了__",NSStringFromSelector(_cmd));
}

@end



@implementation UILabel(Alert)

+ (instancetype)alert_label
{
    UILabel *label = [[self alloc] init];
    label.font = [UIFont systemFontOfSize:12];
    label.textColor = [UIColor colorWithRed:(90)/255.0 green:(90)/255.0 blue:(90)/255.0 alpha:1.0];
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    return label;
}

- (CGFloat)alert_textHeight {
    CGFloat height = 0;
    CGSize size = CGSizeMake((__YY_ALERT_WIDTH - (EDGE_INSET.left+EDGE_INSET.right)), MAXFLOAT);
    if (self.text.length > 0) {
#if defined(__IPHONE_OS_VERSION_MAX_ALLOWED) && __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
        height =[self.text
                      boundingRectWithSize:size
                      options:NSStringDrawingUsesLineFragmentOrigin
                      attributes:@{NSFontAttributeName:self.font}
                      context:nil].size.height;
#else
        
        height = [self.text sizeWithFont:self.font
                            constrainedToSize:size
                                lineBreakMode:NSLineBreakByCharWrapping].height;
#endif
    }
    return height + 10;
}

@end
