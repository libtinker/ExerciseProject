//
//  CTDisplayView.m
//  ExerciseProject
//
//  Created by 天空吸引我 on 2018/9/14.
//  Copyright © 2018年 天空吸引我. All rights reserved.
//

#import "CTDisplayView.h"
#import <CoreText/CoreText.h>
#import <SDWebImageDownloader.h>


@interface CTDisplayView()
@property (nonatomic, strong) UIImage *image;
@end


@implementation CTDisplayView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
#pragma mark 图片代理
void RunDelegateDeallocCallback(void *refCon){
    NSLog(@"RunDelegate dealloc");
}
CGFloat RunDelegateGetAscentCallback(void *refCon){
    NSString *imageName = (__bridge NSString *)refCon;
    if ([imageName isKindOfClass:[NSString class]]){
        // 对应本地图片
        return [UIImage imageNamed:imageName].size.height;
    }
    // 对应网络图片
    return [[(__bridge NSDictionary *)refCon objectForKey:@"height"] floatValue];
}
CGFloat RunDelegateGetDescentCallback(void *refCon){
    return 0;
}
CGFloat RunDelegateGetWidthCallback(void *refCon){
    
    NSLog(@"%@",refCon);
    NSString *imageName = (__bridge NSString *)refCon;
    if ([imageName isKindOfClass:[NSString class]]){
        // 本地图片
        return [UIImage imageNamed:imageName].size.width;
    }
    // 对应网络图片
    return [[(__bridge NSDictionary *)refCon objectForKey:@"width"] floatValue];
}

- (void)downLoadImageWithURL:(NSURL *)url{
    __weak typeof(self) weakSelf = self;

    SDWebImageDownloaderOptions options = SDWebImageDownloaderHandleCookies;
    options = SDWebImageDownloaderContinueInBackground;
    //SDWebImageRetryFailed | SDWebImageHandleCookies | SDWebImageContinueInBackground;
   // options = SDWebImageRetryFailed | SDWebImageContinueInBackground;



    [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:url options:options progress:nil completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
        weakSelf.image = image;
        NSLog(@"%@",image);
        dispatch_async(dispatch_get_main_queue(), ^{
            if (weakSelf.image)
            {
                [weakSelf setNeedsDisplay];
            }
        });
    }];
}


- (void)drawRect:(CGRect)rect {

    [super drawRect:rect];
    NSString* title = @"在现实生活中，我们要不断内外兼修，几十载的人生旅途，看过这边风景，必然错过那边彩虹，有所得，必然有所失。有时，我们只有彻底做到拿得起，放得下，才能拥有一份成熟，才会活得更加充实、坦然、轻松和自由。";

    //步骤1：获取上下文
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    // [a,b,c,d,tx,ty]
    NSLog(@"转换前的坐标：%@",NSStringFromCGAffineTransform(CGContextGetCTM(contextRef)));

    //步骤2：翻转坐标系；
    CGContextSetTextMatrix(contextRef, CGAffineTransformIdentity);
    CGContextTranslateCTM(contextRef, 0, self.bounds.size.height);
    CGContextScaleCTM(contextRef, 1.0, -1.0);
    NSLog(@"转换后的坐标：%@",NSStringFromCGAffineTransform(CGContextGetCTM(contextRef)));


    //步骤3：创建NSAttributedString
    NSMutableAttributedString *attributed = [[NSMutableAttributedString alloc] initWithString:title];
    //设置字体大小
    [attributed addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20] range:NSMakeRange(0, 5)];
    //设置字体颜色
    [attributed addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(3, 10)];
    [attributed addAttribute:(id)kCTForegroundColorAttributeName value:(id)[UIColor greenColor].CGColor range:NSMakeRange(0, 2)];
    // 设置行距等样式
    CGFloat lineSpace = 10; // 行距一般取决于这个值
    CGFloat lineSpaceMax = 20;
    CGFloat lineSpaceMin = 2;
    const CFIndex kNumberOfSettings = 3;
    // 结构体数组
    CTParagraphStyleSetting theSettings[kNumberOfSettings] = {
        {kCTParagraphStyleSpecifierLineSpacingAdjustment,sizeof(CGFloat),&lineSpace},
        {kCTParagraphStyleSpecifierMaximumLineSpacing,sizeof(CGFloat),&lineSpaceMax},
        {kCTParagraphStyleSpecifierMinimumLineSpacing,sizeof(CGFloat),&lineSpaceMin}
    };
    CTParagraphStyleRef theParagraphRef = CTParagraphStyleCreate(theSettings, kNumberOfSettings);
    // 单个元素的形式
    //    CTParagraphStyleSetting theSettings = {kCTParagraphStyleSpecifierLineSpacingAdjustment,sizeof(CGFloat),&lineSpace};
    //    CTParagraphStyleRef theParagraphRef = CTParagraphStyleCreate(&theSettings, kNumberOfSettings);
    // 两种方式皆可
    //    [attributed addAttribute:(id)kCTParagraphStyleAttributeName value:(__bridge id)theParagraphRef range:NSMakeRange(0, attributed.length)];
    // 将设置的行距应用于整段文字
    [attributed addAttribute:NSParagraphStyleAttributeName value:(__bridge id)(theParagraphRef) range:NSMakeRange(0, attributed.length)];
    CFRelease(theParagraphRef);
    // 插入图片部分
    //为图片设置CTRunDelegate,delegate决定留给图片的空间大小
    NSString *weicaiImageName = @"home-page.png";
    CTRunDelegateCallbacks imageCallbacks;
    imageCallbacks.version = kCTRunDelegateVersion1;
    imageCallbacks.dealloc = RunDelegateDeallocCallback;
    imageCallbacks.getAscent = RunDelegateGetAscentCallback;
    imageCallbacks.getDescent = RunDelegateGetDescentCallback;
    imageCallbacks.getWidth = RunDelegateGetWidthCallback;
    // ①该方式适用于图片在本地的情况
    // 设置CTRun的代理
    CTRunDelegateRef runDelegate = CTRunDelegateCreate(&imageCallbacks, (__bridge void *)(weicaiImageName));
    NSMutableAttributedString *imageAttributedString = [[NSMutableAttributedString alloc] initWithString:@" "];//空格用于给图片留位置
    [imageAttributedString addAttribute:(NSString *)kCTRunDelegateAttributeName value:(__bridge id)runDelegate range:NSMakeRange(0, 1)];
    CFRelease(runDelegate);
    [imageAttributedString addAttribute:@"imageName" value:weicaiImageName range:NSMakeRange(0, 1)];
    // 在index处插入图片，可插入多张
    [attributed insertAttributedString:imageAttributedString atIndex:5];
    //    [attributed insertAttributedString:imageAttributedString atIndex:10];

    // ②若图片资源在网络上，则需要使用0xFFFC作为占位符
    // 图片信息字典
    NSString *picURL =@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1538995520447&di=469d246dc82bb5d45a9e70665b09cc20&imgtype=0&src=http%3A%2F%2Fupfile.asqql.com%2F2009pasdfasdfic2009s305985-ts%2F2016-10%2F201610221671542570.JPG";
    UIImage* pImage = [UIImage imageNamed:@"123.png"];
    NSDictionary *imgInfoDic = @{@"width":@(360),@"height":@(360)}; // 宽高跟具体图片有关
    // 设置CTRun的代理
    CTRunDelegateRef delegate = CTRunDelegateCreate(&imageCallbacks, (__bridge void *)imgInfoDic);

    // 使用0xFFFC作为空白的占位符
    unichar objectReplacementChar = 0xFFFC;
    NSString *content = [NSString stringWithCharacters:&objectReplacementChar length:1];
    NSMutableAttributedString *space = [[NSMutableAttributedString alloc] initWithString:content];
    CFAttributedStringSetAttribute((CFMutableAttributedStringRef)space, CFRangeMake(0, 1), kCTRunDelegateAttributeName, delegate);
    CFRelease(delegate);

    // 将创建的空白AttributedString插入进当前的attrString中，位置可以随便指定，不能越界
    [attributed insertAttributedString:space atIndex:10];


    //步骤4：根据NSAttributedString创建CTFramesetterRef
    CTFramesetterRef framesetterRef = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attributed);

    //步骤5：创建绘制区域CGPathRef
    CGMutablePathRef pathRef = CGPathCreateMutable();
    CGPathAddRect(pathRef, NULL, self.bounds);

    //步骤6：根据CTFramesetterRef和CGPathRef创建CTFrame；
    CTFrameRef frameRef = CTFramesetterCreateFrame(framesetterRef, CFRangeMake(0, [attributed length]), pathRef, NULL);

    //步骤7：CTFrameDraw绘制。
    CTFrameDraw(frameRef, contextRef);

    // 处理绘制图片的逻辑
    CFArrayRef lines = CTFrameGetLines(frameRef);
    CGPoint lineOrigins[CFArrayGetCount(lines)];
    // 把ctFrame里每一行的初始坐标写到数组里
    CTFrameGetLineOrigins(frameRef, CFRangeMake(0, 0), lineOrigins);

    // 遍历CTRun找出图片所在的CTRun并进行绘制
    for (int i = 0; i < CFArrayGetCount(lines); i++)
    {
        // 遍历每一行CTLine
        CTLineRef line = CFArrayGetValueAtIndex(lines, i);
        CGFloat lineAscent;
        CGFloat lineDescent;
        CGFloat lineLeading; // 行距
        CTLineGetTypographicBounds(line, &lineAscent, &lineDescent, &lineLeading);
        CFArrayRef runs = CTLineGetGlyphRuns(line);

        for (int j = 0; j < CFArrayGetCount(runs); j++)
        {
            // 遍历每一个CTRun
            CGFloat runAscent;
            CGFloat runDescent;
            CGPoint lineOrigin = lineOrigins[i]; // 获取该行的初始坐标
            CTRunRef run = CFArrayGetValueAtIndex(runs, j); // 获取当前的CTRun
            NSDictionary* attributes = (NSDictionary*)CTRunGetAttributes(run);
            CGRect runRect;
            runRect.size.width = CTRunGetTypographicBounds(run, CFRangeMake(0,0), &runAscent, &runDescent, NULL);
            // 这一段可参考Nimbus的NIAttributedLabel
            runRect = CGRectMake(lineOrigin.x + CTLineGetOffsetForStringIndex(line, CTRunGetStringRange(run).location, NULL), lineOrigin.y - runDescent, runRect.size.width, runAscent + runDescent);

            NSString *imageName = [attributes objectForKey:@"imageName"];
            if ([imageName isKindOfClass:[NSString class]]){
                // 绘制本地图片
                UIImage *image = [UIImage imageNamed:imageName];
                CGRect imageDrawRect;
                imageDrawRect.size = image.size;
                NSLog(@"%.2f",lineOrigin.x); // 该值是0,runRect已经计算过起始值
                imageDrawRect.origin.x = runRect.origin.x;// + lineOrigin.x;
                imageDrawRect.origin.y = lineOrigin.y;
                CGContextDrawImage(contextRef, imageDrawRect, image.CGImage);
            } else {
                imageName = nil;
                CTRunDelegateRef delegate = (__bridge CTRunDelegateRef)[attributes objectForKey:(__bridge id)kCTRunDelegateAttributeName];
                if (!delegate){
                    continue; // 如果是非图片的CTRun则跳过
                }
                // 网络图片
                UIImage *image;
                if (!self.image){
                    // 图片未下载完成，使用占位图片
                    image = pImage;
                    // 去下载图片
                    [self downLoadImageWithURL:[NSURL URLWithString:picURL]];
                }else{
                    image = self.image;
                }
                // 绘制网络图片
                CGRect imageDrawRect;
                imageDrawRect.size = image.size;
                NSLog(@"%.2f",lineOrigin.x); // 该值是0,runRect已经计算过起始值
                imageDrawRect.origin.x = runRect.origin.x;// + lineOrigin.x;
                imageDrawRect.origin.y = lineOrigin.y;
                CGContextDrawImage(contextRef, imageDrawRect, image.CGImage);
            }
        }
    }
    //内存管理
    CFRelease(frameRef);
    CFRelease(pathRef);
    CFRelease(framesetterRef);
}


@end
