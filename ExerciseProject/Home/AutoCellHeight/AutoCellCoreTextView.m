//
//  AutoCellCoreTextView.m
//  ExerciseProject
//
//  Created by 天空吸引我 on 2018/10/12.
//  Copyright © 2018年 天空吸引我. All rights reserved.
//

#import "AutoCellCoreTextView.h"
#import <CoreText/CoreText.h>
#import <SDWebImageDownloader.h>


@interface AutoCellCoreTextView()

@property (nonatomic, strong) UIImage *image;
@property (nonatomic,strong) NSString *text;
@property (nonatomic,strong) NSArray *imageArray;
@end

@implementation AutoCellCoreTextView

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

#pragma mark - CTRunDelegateCallbacks Method
#pragma mark 图片代理
void RunDelegateDeallocCallback(void *refCon){
    NSLog(@"RunDelegate dealloc");
}
CGFloat RunDelegateGetAscentCallback(void *refCon){
    return 80;
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

    return 80;
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
    [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:url options:options progress:nil completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
        weakSelf.image = image;
        dispatch_async(dispatch_get_main_queue(), ^{
            if (weakSelf.image)
            {
                [weakSelf setNeedsDisplay];
            }
        });
    }];
}
- (void)setDiscribText:(NSString *)text imageArray:(NSArray *)imageArray {
    _text = [text stringByAppendingString:@"\n"];
    _imageArray = imageArray;

    [self setNeedsDisplay];
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {

      [super drawRect:rect];

    //步骤1：获取上下文
    CGContextRef contextRef = UIGraphicsGetCurrentContext();

    //步骤2：翻转坐标系；
    CGContextSetTextMatrix(contextRef, CGAffineTransformIdentity);
    CGContextTranslateCTM(contextRef, 0, self.bounds.size.height);
    CGContextScaleCTM(contextRef, 1.0, -1.0);
    NSLog(@"转换后的坐标：%@",NSStringFromCGAffineTransform(CGContextGetCTM(contextRef)));

    //步骤3：创建NSAttributedString
    NSMutableAttributedString *attributed = [[NSMutableAttributedString alloc] initWithString:_text];
    //设置字体大小
    [attributed addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, attributed.length-1)];

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
    // 将设置的行距应用于整段文字
    [attributed addAttribute:NSParagraphStyleAttributeName value:(__bridge id)(theParagraphRef) range:NSMakeRange(0, attributed.length)];
    CFRelease(theParagraphRef);
    // 插入图片部分
    //为图片设置CTRunDelegate,delegate决定留给图片的空间大小

    CTRunDelegateCallbacks imageCallbacks;
    imageCallbacks.version = kCTRunDelegateVersion1;
    imageCallbacks.dealloc = RunDelegateDeallocCallback;
    imageCallbacks.getAscent = RunDelegateGetAscentCallback;
    imageCallbacks.getDescent = RunDelegateGetDescentCallback;
    imageCallbacks.getWidth = RunDelegateGetWidthCallback;

    for (int i=0; i<_imageArray.count; i++) {
        NSDictionary *imgInfoDic = @{@"width":@(80),@"height":@(80)}; // 宽高跟具体图片有关
        // 设置CTRun的代理
        CTRunDelegateRef delegate = CTRunDelegateCreate(&imageCallbacks, (__bridge void *)imgInfoDic);

        // 使用0xFFFC作为空白的占位符
        unichar objectReplacementChar = 0xFFFC;
        NSString *content = [NSString stringWithCharacters:&objectReplacementChar length:1];
        NSMutableAttributedString *space = [[NSMutableAttributedString alloc] initWithString:content];
        CFAttributedStringSetAttribute((CFMutableAttributedStringRef)space, CFRangeMake(0, 1), kCTRunDelegateAttributeName, delegate);
        CFRelease(delegate);
        [attributed insertAttributedString:space atIndex:attributed.length];

    }

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

    int index = 0;
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

                CTRunDelegateRef delegate = (__bridge CTRunDelegateRef)[attributes objectForKey:(__bridge id)kCTRunDelegateAttributeName];
                if (!delegate){
                    continue; // 如果是非图片的CTRun则跳过
                }
                // 网络图片
                UIImage *image = [UIImage imageNamed:_imageArray[index]];
                index++;
                // 绘制网络图片
                CGRect imageDrawRect;
                imageDrawRect.size = CGSizeMake(80, 80);// image.size;
                NSLog(@"%.2f",lineOrigin.x); // 该值是0,runRect已经计算过起始值
                imageDrawRect.origin.x = runRect.origin.x +10*j;// + lineOrigin.x;
                imageDrawRect.origin.y = lineOrigin.y;
                CGContextDrawImage(contextRef, imageDrawRect, image.CGImage);
            }
    }
    //内存管理
    CFRelease(frameRef);
    CFRelease(pathRef);
    CFRelease(framesetterRef);
}


@end
