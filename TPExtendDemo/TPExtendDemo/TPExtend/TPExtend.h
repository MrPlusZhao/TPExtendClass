//
//  TPExtend.h
//  TPExtendDemo
//
//  Created by ztp on 2019/9/10.
//  Copyright © 2019 ztp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TPExtend : NSObject

+ (UIView *)viewColor:(UIColor*)color addSubView:(id)subView;

+ (UIView *)viewColor:(UIColor*)color Frame:(CGRect)frame addSubView:(id)subView;

+ (UILabel *)labTextColor:(UIColor*)color
                     Text:(nullable NSString*)text
                     Font:(CGFloat)font
               addSubView:(id)subView;

+ (UILabel *)labTextColor:(UIColor*)color
                     Text:(nullable NSString*)text
                     Font:(CGFloat)font
                    Frame:(CGRect)frame
               addSubView:(id)subView;

+ (UIImageView *)imgName:(nullable NSString *)name
                 bgColor:(nullable UIColor*)color
              addSubView:(id)subView;

+ (UIImageView *)imgName:(nullable NSString *)name
                 bgColor:(nullable UIColor*)color
                   Frame:(CGRect)frame
              addSubView:(id)subView;

+ (UIButton *)btnTitle:(nullable NSString *)text
                 BGImg:(nullable NSString *)bgImg
             NormalImg:(nullable NSString*)normalImg
             TextColor:(UIColor*)color
              TextFont:(CGFloat)font
       BackgroundColor:(nullable UIColor *)bgColor
            addSubView:(id)subView;

+ (UIButton *)btnTitle:(nullable NSString *)text
                 BGImg:(nullable NSString *)bgImg
             NormalImg:(nullable NSString*)normalImg
             TextColor:(UIColor*)color
              TextFont:(CGFloat)font
       BackgroundColor:(nullable UIColor *)bgColor
                 Frame:(CGRect)frame
            addSubView:(id)subView;

+ (UITextField *)textFieldPlaceholder:(nullable NSString *)placeholder
                 PlaceholderTextColor:(nullable UIColor *)placeholderColor
                      SecureTextEntry:(BOOL)entry
                      BackgroundColor:(nullable UIColor *)bgColor
                             TextFont:(CGFloat)font
                            TextColor:(UIColor*)textColor
                           addSubView:(id)subView;

+ (UITextField *)textFieldPlaceholder:(nullable NSString *)placeholder
                 PlaceholderTextColor:(nullable UIColor *)placeholderColor
                      SecureTextEntry:(BOOL)entry
                      BackgroundColor:(nullable UIColor *)bgColor
                             TextFont:(CGFloat)font
                            TextColor:(UIColor*)textColor
                                Frame:(CGRect)frame
                           addSubView:(id)subView;
//是否为IphoneX及以上系列
+ (BOOL)ISIphoneXModel;
//监测当前是否断网
+ (BOOL)connectedToNetwork;
/// 通过View获取当前view所在的VC
+ (UIViewController *)FatherViewControllerFromView:(UIView*)view;
/// 根据内容获取textView的高度
+ (CGSize)getStringRectInTextView:(NSString *)string InTextView:(UITextView *)textView;

/// View 任意角圆角处理
+ (void)makeCornersTopLeft:(BOOL)topLeft TopRight:(BOOL)topRight BomLeft:(BOOL)bomLeft BomRight:(BOOL)bomRight Subview:(UIView*)subView CornerRadii:(CGSize)cornerRadii;

/// 验证是否为二维码图片,并返回对应内容
+ (NSString*)isAvailableQRcodeIn:(UIImage *)img;

/// 计算s字符串高度
+ (CGFloat)getStringHeightWithText:(NSString *)text font:(UIFont *)font viewWidth:(CGFloat)width;

/// 缩放效果动画
+ (void)scaleAnimation:(BOOL)isShow View:(UIView*)subView;
/// 根据字符串计算行数
+ (NSArray*)GetLineNumberForString:(NSString*)contentStr andWidth:(CGFloat)width font:(UIFont*)font lineSpace:(CGFloat)lineSpace;

/// 计算与当前时间相差多少分钟
+ (NSInteger )beforeCurrentTime:(NSString *)str;

/// 获取当前时间戳 毫秒为单位
+ (NSString *)getNowTimeTimestampfor1000;
/// 时间戳转时间
+ (NSString*)getTimeStr:(NSString *)str;
/// 时间戳转时间/ 年月日时分秒
+ (NSString*)getTimeStr_YMD_HMS:(NSString *)str;
/// 判断是ipad设备
+ (BOOL)IpadDevice;

/// 字典转json
+(NSString*)dictionaryToString:(NSDictionary*)dictionary;
/// json转字典
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
/// 获取字符串宽度
+ (CGFloat)getStringWidthtWithText:(NSString *)text font:(UIFont *)font viewHeight:(CGFloat)height;
/**
 改变 label 文字中某段文字的颜色和大小
 label      传入的文本内容（注：传入前要有文字）
 color      字体颜色
 */
+ (void)TPChangeLab:(UILabel *)label ColorFromLoc:(NSInteger)location len:(NSInteger)lengh textColor:(UIColor *)color;

+ (void)TPChangeLab:(UILabel *)label ColorFromLoc:(NSInteger)location len:(NSInteger)lengh textColor:(UIColor *)color Font:(UIFont*)font;
/// 字符串 加载html样式
+ (NSAttributedString*)getHtmlString:(NSString*)content;

@end

NS_ASSUME_NONNULL_END
