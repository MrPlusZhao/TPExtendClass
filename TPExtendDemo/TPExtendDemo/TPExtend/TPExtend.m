//
//  TPExtend.m
//  TPExtendDemo
//
//  Created by ztp on 2019/9/10.
//  Copyright © 2019 ztp. All rights reserved.
//

#import "TPExtend.h"
#include <netdb.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import <CoreText/CoreText.h>


@implementation TPExtend

+ (UIView *)viewColor:(UIColor*)color addSubView:(id)subView{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = color;
    [subView addSubview:view];
    return view;
}

+ (UIView *)viewColor:(UIColor*)color Frame:(CGRect)frame addSubView:(id)subView{
    UIView *view = [TPExtend viewColor:color addSubView:subView];
    [view setFrame:frame];
    return view;
}

+ (UILabel *)labTextColor:(UIColor*)color Text:(nullable NSString*)text Font:(CGFloat)font addSubView:(id)subView{
    UILabel *lab = [[UILabel alloc] init];
    lab.text = text?text:@"";
    lab.font = [UIFont systemFontOfSize:font];
    lab.textColor = color;
    [subView addSubview:lab];
    return lab;
}

+ (UILabel *)labTextColor:(UIColor*)color Text:(nullable NSString*)text Font:(CGFloat)font Frame:(CGRect)frame addSubView:(id)subView{
    UILabel *lab = [TPExtend labTextColor:color Text:text Font:font addSubView:subView];
    [lab setFrame:frame];
    return lab;
}

+ (UIImageView *)imgName:(nullable NSString *)name
                 bgColor:(nullable UIColor*)color
              addSubView:(id)subView{
    UIImageView *imgView = [[UIImageView alloc]init];
    if (name && name.length > 0) {
        imgView.image = [UIImage imageNamed:name];
    }
    if (color) {
        imgView.backgroundColor = color;
    }
    [subView addSubview:imgView];
    return imgView;
}

+ (UIImageView *)imgName:(nullable NSString *)name
                 bgColor:(nullable UIColor*)color
                   Frame:(CGRect)frame
              addSubView:(id)subView{
    UIImageView *imgView = [TPExtend imgName:name bgColor:color addSubView:subView];
    [imgView setFrame:frame];
    return imgView;
}

+ (UIButton *)btnTitle:(nullable NSString *)text
                 BGImg:(nullable NSString *)bgImg
             NormalImg:(nullable NSString*)normalImg
             TextColor:(UIColor*)color
              TextFont:(CGFloat)font
       BackgroundColor:(nullable UIColor *)bgColor
            addSubView:(id)subView{
    UIButton *btn = [[UIButton alloc] init];
    btn.titleLabel.font = [UIFont systemFontOfSize:font];
    [btn setTitleColor:color forState:UIControlStateNormal];
    if (text) {
        [btn setTitle:text forState:UIControlStateNormal];
    }
    if (bgColor) {
        [btn setBackgroundColor:bgColor];
    }
    if (bgImg && bgImg.length > 0) {
        [btn setBackgroundImage:[UIImage imageNamed:bgImg] forState:UIControlStateNormal];
    }
    if (normalImg && normalImg.length > 0) {
        [btn setImage:[UIImage imageNamed:normalImg] forState:UIControlStateNormal];
    }
    [subView addSubview:btn];
    return btn;
}

+ (UIButton *)btnTitle:(nullable NSString *)text
                 BGImg:(nullable NSString *)bgImg
             NormalImg:(nullable NSString*)normalImg
             TextColor:(UIColor*)color
              TextFont:(CGFloat)font
       BackgroundColor:(nullable UIColor *)bgColor
                 Frame:(CGRect)frame
            addSubView:(id)subView{
    UIButton *btn = [TPExtend btnTitle:text BGImg:bgImg NormalImg:normalImg TextColor:color TextFont:font BackgroundColor:bgColor addSubView:subView];
    [btn setFrame:frame];
    return btn;
}

+ (UITextField *)textFieldPlaceholder:(nullable NSString *)placeholder
                 PlaceholderTextColor:(nullable UIColor *)placeholderColor
                      SecureTextEntry:(BOOL)entry
                      BackgroundColor:(nullable UIColor *)bgColor
                             TextFont:(CGFloat)font
                            TextColor:(UIColor*)textColor
                           addSubView:(id)subView{
    UITextField *textField    = [[UITextField alloc]init];
    if (bgColor) {
        textField.backgroundColor = bgColor;
    }
    if (textColor) {
        textField.textColor=textColor;
    }
    if (placeholderColor) {
        //        [textField setValue:placeholderColor forKeyPath:@"_placeholderLabel.textColor"];
    }
    if (entry) {
        textField.secureTextEntry = entry;
    }
    if (placeholder) {
        textField.placeholder     = placeholder;
    }
    textField.font            = [UIFont systemFontOfSize:font];
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [subView addSubview:textField];
    return textField;
}
+ (UITextField *)textFieldPlaceholder:(nullable NSString *)placeholder
                 PlaceholderTextColor:(nullable UIColor *)placeholderColor
                      SecureTextEntry:(BOOL)entry
                      BackgroundColor:(nullable UIColor *)bgColor
                             TextFont:(CGFloat)font
                            TextColor:(UIColor*)textColor
                                Frame:(CGRect)frame
                           addSubView:(id)subView{
    UITextField *textField = [TPExtend textFieldPlaceholder:placeholder PlaceholderTextColor:placeholderColor SecureTextEntry:entry BackgroundColor:bgColor TextFont:font TextColor:textColor addSubView:subView];
    [textField setFrame:frame];
    return textField;
}
+ (BOOL)ISIphoneXModel
{
    BOOL iPhoneXSeries = NO;
    if (UIDevice.currentDevice.userInterfaceIdiom != UIUserInterfaceIdiomPhone) {
        return iPhoneXSeries;
    }
    
    if (@available(iOS 11.0, *)) {
        if ([[[UIApplication sharedApplication] delegate] window].safeAreaInsets.bottom > 0.0) {
            iPhoneXSeries = YES;
        }
    }
    return iPhoneXSeries;
}
+ (BOOL)connectedToNetwork
{
    // 创建零地址，0.0.0.0的地址表示查询本机的网络连接状态
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    /**
     *  SCNetworkReachabilityRef: 用来保存创建测试连接返回的引用
     *
     *  SCNetworkReachabilityCreateWithAddress: 根据传入的地址测试连接.
     *  第一个参数可以为NULL或kCFAllocatorDefault
     *  第二个参数为需要测试连接的IP地址,当为0.0.0.0时则可以查询本机的网络连接状态.
     *  同时返回一个引用必须在用完后释放.
     *  PS: SCNetworkReachabilityCreateWithName: 这个是根据传入的网址测试连接,
     *  第二个参数比如为"www.apple.com",其他和上一个一样.
     *
     *  SCNetworkReachabilityGetFlags: 这个函数用来获得测试连接的状态,
     *  第一个参数为之前建立的测试连接的引用,
     *  第二个参数用来保存获得的状态,
     *  如果能获得状态则返回TRUE，否则返回FALSE
     *
     */
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    
    if (!didRetrieveFlags)
    {
        return NO;
    }
    
    /**
     *  kSCNetworkReachabilityFlagsReachable: 能够连接网络
     *  kSCNetworkReachabilityFlagsConnectionRequired: 能够连接网络,但是首先得建立连接过程
     *  kSCNetworkReachabilityFlagsIsWWAN: 判断是否通过蜂窝网覆盖的连接,
     *  比如EDGE,GPRS或者目前的3G.主要是区别通过WiFi的连接.
     *
     */
    BOOL isReachable = ((flags & kSCNetworkFlagsReachable) != 0);
    BOOL needsConnection = ((flags & kSCNetworkFlagsConnectionRequired) != 0);
    return (isReachable && !needsConnection) ? YES : NO;
}
+ (UIViewController *)FatherViewControllerFromView:(UIView*)view
{
    UIView *next = view;
    while ((next = [next superview])) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}
+ (CGSize)getStringRectInTextView:(NSString *)string InTextView:(UITextView *)textView
{
    //实际textView显示时我们设定的宽
    UITextView* localTextView=textView;
    CGFloat contentWidth = CGRectGetWidth(localTextView.frame);
    //但事实上内容需要除去显示的边框值
    CGFloat broadWith    = (localTextView.contentInset.left + localTextView.contentInset.right
                            + localTextView.textContainerInset.left
                            + localTextView.textContainerInset.right
                            + localTextView.textContainer.lineFragmentPadding/*左边距*/
                            + localTextView.textContainer.lineFragmentPadding/*右边距*/);
    
    CGFloat broadHeight  = (localTextView.contentInset.top
                            + localTextView.contentInset.bottom
                            + localTextView.textContainerInset.top
                            + localTextView.textContainerInset.bottom);
    //由于求的是普通字符串产生的Rect来适应textView的宽
    contentWidth -= broadWith;
    
    CGSize InSize = CGSizeMake(contentWidth, MAXFLOAT);
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = localTextView.textContainer.lineBreakMode;
    NSDictionary *dic = @{NSFontAttributeName:localTextView.font, NSParagraphStyleAttributeName:[paragraphStyle copy]};
    
    CGSize calculatedSize =  [string boundingRectWithSize:InSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil].size;
    
    CGSize adjustedSize = CGSizeMake(ceilf(calculatedSize.width),calculatedSize.height + broadHeight);
    return adjustedSize;
}

+ (void)makeCornersTopLeft:(BOOL)topLeft TopRight:(BOOL)topRight BomLeft:(BOOL)bomLeft BomRight:(BOOL)bomRight Subview:(UIView*)subView CornerRadii:(CGSize)cornerRadii
{
    UIBezierPath *maskPath;
    
    // 一个角圆角
    if (topLeft && !topRight && !bomLeft && !bomRight) {
        maskPath = [UIBezierPath bezierPathWithRoundedRect:subView.bounds byRoundingCorners:UIRectCornerTopLeft cornerRadii:cornerRadii];
    }
    if (!topLeft && topRight && !bomLeft && !bomRight) {
        maskPath = [UIBezierPath bezierPathWithRoundedRect:subView.bounds byRoundingCorners:UIRectCornerTopRight cornerRadii:cornerRadii];
    }
    if (!topLeft && !topRight && bomLeft && !bomRight) {
        maskPath = [UIBezierPath bezierPathWithRoundedRect:subView.bounds byRoundingCorners:UIRectCornerBottomLeft cornerRadii:cornerRadii];
    }
    if (!topLeft && !topRight && !bomLeft && bomRight) {
        maskPath = [UIBezierPath bezierPathWithRoundedRect:subView.bounds byRoundingCorners:UIRectCornerBottomRight cornerRadii:cornerRadii];
    }
    // 两个角圆角
    // 01
    if (topLeft && topRight && !bomLeft && !bomRight) {
        maskPath = [UIBezierPath bezierPathWithRoundedRect:subView.bounds byRoundingCorners:UIRectCornerTopLeft|
                    UIRectCornerTopRight cornerRadii:cornerRadii];
    }
    if (topLeft && !topRight && bomLeft && !bomRight) {
        maskPath = [UIBezierPath bezierPathWithRoundedRect:subView.bounds byRoundingCorners:UIRectCornerTopLeft|
                    UIRectCornerBottomLeft cornerRadii:cornerRadii];
    }
    if (topLeft && !topRight && !bomLeft && bomRight) {
        maskPath = [UIBezierPath bezierPathWithRoundedRect:subView.bounds byRoundingCorners:UIRectCornerTopLeft|
                    UIRectCornerBottomRight cornerRadii:cornerRadii];
    }
    // 02
    if (!topLeft && topRight && bomLeft && !bomRight) {
        maskPath = [UIBezierPath bezierPathWithRoundedRect:subView.bounds byRoundingCorners:UIRectCornerTopRight|
                    UIRectCornerBottomLeft cornerRadii:cornerRadii];
    }
    if (!topLeft && topRight && !bomLeft && bomRight) {
        maskPath = [UIBezierPath bezierPathWithRoundedRect:subView.bounds byRoundingCorners:UIRectCornerTopRight|
                    UIRectCornerBottomRight cornerRadii:cornerRadii];
    }
    if (!topLeft && !topRight && bomLeft && bomRight) {
        maskPath = [UIBezierPath bezierPathWithRoundedRect:subView.bounds byRoundingCorners:UIRectCornerBottomLeft|
                    UIRectCornerBottomRight cornerRadii:cornerRadii];
    }
    // 三个角圆角
    if (topLeft && topRight && bomLeft && !bomRight) {
        maskPath = [UIBezierPath bezierPathWithRoundedRect:subView.bounds byRoundingCorners:UIRectCornerTopLeft|
                    UIRectCornerTopRight | UIRectCornerBottomLeft cornerRadii:cornerRadii];
    }
    if (topLeft && topRight && !bomLeft && bomRight) {
        maskPath = [UIBezierPath bezierPathWithRoundedRect:subView.bounds byRoundingCorners:UIRectCornerTopLeft|
                    UIRectCornerTopRight | UIRectCornerBottomRight cornerRadii:cornerRadii];
    }
    if (topLeft && !topRight && bomLeft && bomRight) {
        maskPath = [UIBezierPath bezierPathWithRoundedRect:subView.bounds byRoundingCorners:UIRectCornerTopLeft|
                    UIRectCornerBottomRight | UIRectCornerBottomLeft cornerRadii:cornerRadii];
    }
    if (!topLeft && topRight && bomLeft && bomRight) {
        maskPath = [UIBezierPath bezierPathWithRoundedRect:subView.bounds byRoundingCorners:UIRectCornerBottomRight|
                    UIRectCornerTopRight | UIRectCornerBottomLeft cornerRadii:cornerRadii];
    }
    // 四个角圆角
    if (topLeft && topRight && bomLeft && bomRight) {
        maskPath = [UIBezierPath bezierPathWithRoundedRect:subView.bounds
                                         byRoundingCorners:
                    UIRectCornerTopLeft| UIRectCornerBottomRight|
                    UIRectCornerTopRight | UIRectCornerBottomLeft
                                               cornerRadii:cornerRadii];
    }
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = subView.bounds;
    maskLayer.path = maskPath.CGPath;
    subView.layer.mask = maskLayer;
}

+ (NSString*)isAvailableQRcodeIn:(UIImage *)img
{
    NSString *qrString = @"";
    UIImage *image = [TPExtend imageByInsetEdge:UIEdgeInsetsMake(-20, -20, -20, -20) withColor:[UIColor lightGrayColor] withImage:img];
    
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:@{}];
    
    NSArray *features = [detector featuresInImage:[CIImage imageWithCGImage:image.CGImage]];
    
    if (features.count >= 1) {
        CIQRCodeFeature *feature = [features objectAtIndex:0];
        qrString = [feature.messageString copy];
        NSLog(@"QR result :%@", qrString);
        return qrString;
    } else {
        NSLog(@"No QR");
        return qrString;
    }
}
// you can also implement by UIImage category
+ (UIImage *)imageByInsetEdge:(UIEdgeInsets)insets withColor:(UIColor *)color withImage:(UIImage *)image
{
    CGSize size = image.size;
    size.width -= insets.left + insets.right;
    size.height -= insets.top + insets.bottom;
    if (size.width <= 0 || size.height <= 0) {
        return nil;
    }
    CGRect rect = CGRectMake(-insets.left, -insets.top, image.size.width, image.size.height);
    UIGraphicsBeginImageContextWithOptions(size, NO, image.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (color) {
        CGContextSetFillColorWithColor(context, color.CGColor);
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathAddRect(path, NULL, CGRectMake(0, 0, size.width, size.height));
        CGPathAddRect(path, NULL, rect);
        CGContextAddPath(context, path);
        CGContextEOFillPath(context);
        CGPathRelease(path);
    }
    [image drawInRect:rect];
    UIImage *insetEdgedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return insetEdgedImage;
}

+ (CGFloat)getStringHeightWithText:(NSString *)text font:(UIFont *)font viewWidth:(CGFloat)width {
    // 设置文字属性 要和label的一致
    NSDictionary *attrs = @{NSFontAttributeName :font};
    CGSize maxSize = CGSizeMake(width, MAXFLOAT);
    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    // 计算文字占据的宽高
    CGSize size = [text boundingRectWithSize:maxSize options:options attributes:attrs context:nil].size;
    
    // 当你是把获得的高度来布局控件的View的高度的时候.size转化为ceilf(size.height)。
    return  ceilf(size.height);
}
+ (CGFloat)getStringWidthtWithText:(NSString *)text font:(UIFont *)font viewHeight:(CGFloat)height {
    // 设置文字属性 要和label的一致
    NSDictionary *attrs = @{NSFontAttributeName :font};
    CGSize maxSize = CGSizeMake(MAXFLOAT, height);
    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    // 计算文字占据的宽高
    CGSize size = [text boundingRectWithSize:maxSize options:options attributes:attrs context:nil].size;
    
    // 当你是把获得的高度来布局控件的View的高度的时候.size转化为ceilf(size.height)。
    return  ceilf(size.width);
}
//缩放效果动画
+ (void)scaleAnimation:(BOOL)isShow View:(UIView*)subView {
    if (isShow) {
        CGAffineTransform transform0 = CGAffineTransformMakeScale(0.1, 0.1);
        CGAffineTransform transform1 = CGAffineTransformMakeScale(1.2, 1.2);
        CGAffineTransform transform2 = CGAffineTransformMakeScale(0.9, 0.9);
        CGAffineTransform transform3 = CGAffineTransformMakeScale(1.1, 1.1);
        CGAffineTransform transform4 = CGAffineTransformMakeScale(1, 1);
        
        [subView setTransform:transform0];
        [TPExtend startScaleAnimateWithView:subView after:0 during:0.2 toTransform:transform1];
        [self startScaleAnimateWithView:subView after:0.2 during:0.05 toTransform:transform2];
        [self startScaleAnimateWithView:subView after:0.25 during:0.05 toTransform:transform3];
        [self startScaleAnimateWithView:subView after:0.3 during:0.05 toTransform:transform4];
    } else {
        CGAffineTransform transform = CGAffineTransformMakeScale(1.0, 0.0001);
        [self startScaleAnimateWithView:subView after:0 during:0.1 toTransform:transform];
    }
}
#pragma mark -- 动画效果

+ (void)startScaleAnimateWithView:(UIView*)view after:(CGFloat)after during:(CGFloat)during toTransform:(CGAffineTransform)transform{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(after * 0.2)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:during animations:^{
            [view setTransform:transform];
        }];
    });
}

+ (NSArray*)GetLineNumberForString:(NSString*)contentStr andWidth:(CGFloat)width font:(UIFont*)font lineSpace:(CGFloat)lineSpace
{
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc]init];
    [paraStyle setLineSpacing:lineSpace];
    NSMutableAttributedString * setString = [[NSMutableAttributedString alloc]initWithString:contentStr];
    [setString addAttributes:@{NSParagraphStyleAttributeName:paraStyle} range:NSMakeRange(0, contentStr.length)];
    [setString addAttributes:@{NSParagraphStyleAttributeName:font} range:NSMakeRange(0, contentStr.length)];
    
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)setString);
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0, 0, width, 10000));
    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, NULL);
    NSArray *lines = (__bridge NSArray*)CTFrameGetLines(frame);
    NSMutableArray *lineArr = [[NSMutableArray alloc]init];
    for (id Line in lines) {
        CTLineRef lineRef = (__bridge CTLineRef)Line;
        CFRange lineRange = CTLineGetStringRange(lineRef);
        NSRange range = NSMakeRange(lineRange.location, lineRange.length);
        NSString *lineString = [contentStr substringWithRange:range];
        [lineArr addObject:lineString];
    }
    return (NSArray*)lineArr;
}
/// 计算与当前时间相差多少分钟
+ (NSInteger )beforeCurrentTime:(NSString *)str
{
    //str为时间戳
    NSTimeInterval interval = [str doubleValue] / 1000.0;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    //把字符串转为NSdate
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *timeString =[dateFormatter stringFromDate: date];
    NSDate *timeDate = [dateFormatter dateFromString:timeString];
    NSDate *currentDate = [NSDate date];
    NSTimeInterval timeInterval = [currentDate timeIntervalSinceDate:timeDate];
    long temp = 0;
    temp = timeInterval/60;
    NSString *result = [NSString stringWithFormat:@"%ld",temp];
    return [result integerValue];
}
/// 获取当前时间戳 毫秒为单位
+ (NSString *)getNowTimeTimestampfor1000{
    NSDate *datenow = [NSDate date];
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)([datenow timeIntervalSince1970]*1000)];
    return timeSp;
}
+ (NSString*)getTimeStr:(NSString *)str
{
    NSInteger num              = [str integerValue];
    num = num / 1000;
    NSTimeZone* timeZone       = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    [formatter setTimeZone:timeZone];
    NSDate  *confromTimesp    = [NSDate dateWithTimeIntervalSince1970:num];
    NSString *newString = [formatter stringFromDate:confromTimesp];
    return newString;
}
+ (NSString*)getTimeStr_YMD_HMS:(NSString *)str
{
    NSInteger num              = [str integerValue];
    num = num / 1000;
    NSTimeZone* timeZone       = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [formatter setTimeZone:timeZone];
    NSDate  *confromTimesp    = [NSDate dateWithTimeIntervalSince1970:num];
    NSString *newString = [formatter stringFromDate:confromTimesp];
    return newString;
}
+ (BOOL)IpadDevice
{
    CGFloat MainScreenWidth = [UIScreen mainScreen].bounds.size.width;
    if (TARGET_IPHONE_SIMULATOR == 1) {
        //模拟器
        return MainScreenWidth>768;
    }
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        return YES;
    }
    return NO;
}
#pragma mark - 字典转json串
+(NSString*)dictionaryToString:(NSDictionary*)dictionary
{
    if (!dictionary) {
        return @"";
    }
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData
                                                 encoding:NSUTF8StringEncoding];
    return jsonString;
}
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err)
    {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}
+ (void)TPLabelAttributedString:(UILabel *)label firstText:(NSString *)oneIndex toEndText:(NSString *)endIndex textColor:(UIColor *)color textSize:(CGFloat)size {
    // 创建 Attributed
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:label.text];
    // 需要改变的首位文字位置
    NSUInteger firstLoc = [[noteStr string] rangeOfString:oneIndex].location;
    // 需要改变的末位文字位置
//    NSUInteger endLoc = [[noteStr string] rangeOfString:endIndex].location + 1;
    NSUInteger endLoc = [[noteStr string] rangeOfString:endIndex].location + [[noteStr string] rangeOfString:endIndex].length;
    // 需要改变的区间
    NSRange range = NSMakeRange(firstLoc, endLoc - firstLoc);
    // 改变颜色
    [noteStr addAttribute:NSForegroundColorAttributeName value:color range:range];
    // 改变字体大小及类型
    [noteStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFangSC-Regular" size:size] range:range];
    // 为 label 添加 Attributed
    [label setAttributedText:noteStr];
}
+ (void)TPChangeLab:(UILabel *)label ColorFromLoc:(NSInteger)location len:(NSInteger)lengh textColor:(UIColor *)color
{
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:label.text];
    NSRange range = NSMakeRange(location, lengh);
    // 改变颜色
    [noteStr addAttribute:NSForegroundColorAttributeName value:color range:range];
    // 为 label 添加 Attributed
    [label setAttributedText:noteStr];
}
+ (void)TPChangeLab:(UILabel *)label ColorFromLoc:(NSInteger)location len:(NSInteger)lengh textColor:(UIColor *)color Font:(UIFont*)font
{
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:label.text];
    NSRange range = NSMakeRange(location, lengh);
    if (color) {
        // 改变颜色
        [noteStr addAttribute:NSForegroundColorAttributeName value:color range:range];
    }
    if (font) {
        // 为 label 添加 Attributed
        [noteStr addAttribute:NSFontAttributeName value:font range:range];
    }
    [label setAttributedText:noteStr];

}
+ (NSAttributedString*)getHtmlString:(NSString*)content{
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[content dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    return attributedString;
}
@end
