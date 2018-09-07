//
//  KVOVC.m
//  ExerciseProject
//
//  Created by 天空吸引我 on 2018/8/25.
//  Copyright © 2018年 天空吸引我. All rights reserved.
//

#import "KVOVC.h"

@interface KVOVC ()

@property (nonatomic,strong) UITextField *textFiled;
@property (nonatomic,strong) UILabel *label;
@property (nonatomic,copy) NSString *kvoString;
@property (nonatomic,strong) UITextView *textView;

@end

@implementation KVOVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"KVO";
    [self.view addSubview:self.textFiled];
    [self.view addSubview:self.label];
    [self.view addSubview:self.textView];
    //注册KVO
    [self addObserver:self forKeyPath:@"kvoString" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc {
    //删除KVO
    [self removeObserver:self forKeyPath:@"kvoString"];
}

- (UITextField *)textFiled {
    if (!_textFiled) {
        _textFiled = [[UITextField alloc] initWithFrame:CGRectMake(50, 20, 200, 40)];
        _textFiled.placeholder = @"KVO监听测试";
        [_textFiled addTarget:self action:@selector(textFiledDidChange:) forControlEvents:UIControlEventEditingChanged];
        _textFiled.textColor = [UIColor blackColor];
    }
    return _textFiled;
}
- (UILabel *)label {
    if (!_label) {
        _label = [[UILabel alloc] initWithFrame:CGRectMake(50, 80, 200, 40)];
        _label.textColor = [UIColor blackColor];
    }
    return _label;
}

- (UITextView *)textView {
    if (!_textView) {
        _textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 140, 300, 500)];
        _textView.font = [UIFont systemFontOfSize:16];
        _textView.text = @"KVO的实现分析\n使用观察者模式需要被观察者的配合，当被观察者的状态发生变化的时候通过事先定义好的接口（协议）通知观察者。在KVO的使用中我们并不需要向被观察者添加额外的代码，就能在被观察的属性变化的时候得到通知，这个功能是如何实现的呢？同KVC一样依赖于强大的Runtime机制。\n系统实现KVO有以下几个步骤：\n当类A的对象第一次被观察的时候，系统会在运行期动态创建类A的派生类。我们称为B。\n在派生类B中重写类A的setter方法，B类在被重写的setter方法中实现通知机制。\n类B重写会 class方法，将自己伪装成类A。类B还会重写dealloc方法释放资源。\n系统将所有指向类A对象的isa指针指向类B的对象。\nKVO同KVC一样，通过 isa-swizzling 技术来实现。当观察者被注册为一个对象的属性的观察对象的isa指针被修改，指向一个中间类，而不是在真实的类。其结果是，isa指针的值并不一定反映实例的实际类。\n所以不能依靠isa指针来确定对象是否是一个类的成员。应该使用class方法来确定对象实例的类。";
    }
    return _textView;
}

- (void)textFiledDidChange:(UITextField *)textFiled {
    self.kvoString = textFiled.text;
}
//监听
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {

    if ([keyPath isEqualToString:@"kvoString"]) {
        _label.text = change[@"new"];
    }
}

//自定义监听
- (void)zjj_observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(id)change {

    NSLog(@"%@",change);
}

- (void)setKvoString:(NSString *)kvoString {
    _kvoString = kvoString;
    [self zjj_observeValueForKeyPath:@"kvoString" ofObject:self change:kvoString];
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
