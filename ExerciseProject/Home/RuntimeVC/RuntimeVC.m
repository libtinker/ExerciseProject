//
//  RuntimeVC.m
//  ExerciseProject
//
//  Created by 天空吸引我 on 2018/9/7.
//  Copyright © 2018年 天空吸引我. All rights reserved.
//



#import "RuntimeVC.h"
#import <objc/runtime.h>

@interface RuntimeVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *dataArray;
}

@property (nonatomic,strong,) UITableView *tableView;
@end
@implementation RuntimeVC
static NSString *CellName = @"TableViewCell";

+ (void)load {
   
   [self.class zjj_swapOriginSel:@selector(iAmBeautiful) currentSel:@selector(iAmFool)];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Runtime学习";
    dataArray = @[@"获取SEL",@"获取Class对象",@"反射机制",@"获取属性列表",@"获取方法列表",@"获取成员变量列表",@"添加方法",@"交换方法(我是美女)",@"Method"];
    [self.view addSubview:self.tableView];
    [_tableView reloadData];
}
// 获取Class对象
//Class对象其实本质上就是一个结构体，这个结构体中的成员变量还是自己，这种设计方式非常像链表的数据结构
/*
 typedef struct objc_class *Class;
 struct objc_class {
 Class isa  OBJC_ISA_AVAILABILITY;
 }
 */
- (void)getClass {
    // 在实例方法中通过self调用class实例方法获取类对象
    Class class1 = [self class];
    // 通过ViewController类直接调用class类方法获取类对象
    Class class2 = [RuntimeVC class];

    Class class3 = NSClassFromString(@"RuntimeVC");

    Class class4 = objc_getClass("RuntimeVC");
    NSLog(@"class1==%p\nclass2==%p\nclass3 == %p\n  class4==%p",class1,class2,class3,class4);
}



#pragma mark ----- 反射机制 ---------
//反射机制
//系统Foundation框架为我们提供了一些方法反射的API，我们可以通过这些API执行将字符串转为SEL等操作。由于OC语言的动态性，这些操作都是发生在运行时的
- (void)reflex {
    //通过字符串得到类
    Class class = NSClassFromString(@"RuntimeVC");
    NSLog(@"%@",class);
    NSString *string = NSStringFromClass(class);
    NSLog(@"%@",string);
    SEL sel = NSSelectorFromString(@"testSel");
    SuppressPerformSelectorLeakWarning(
                                       [self performSelector:sel];
                                       );
    //通过方法得到字符串
    NSString *selString = NSStringFromSelector(sel);
    NSLog(@"通过方法得到字符串%@",selString);
    
}
- (void)testSel {
    NSLog(@"test");
}

#pragma mark ----- 获取属性列表---------

/** 获取属性列表 */
- (void)getProperties {
    u_int count = 0;
    objc_property_t *properties = class_copyPropertyList([self class], &count);

    for (int i = 0; i < count; i++) {
        const char *propertyName = property_getName(properties[i]);
        const char *attributes = property_getAttributes(properties[i]);
        NSString *str = [NSString stringWithCString:propertyName encoding:NSUTF8StringEncoding];
        NSString *attributesStr = [NSString stringWithCString:attributes encoding:NSUTF8StringEncoding];
        NSLog(@"propertyName : %@", str);
        NSLog(@"attributesStr : %@", attributesStr);
    }
}
#pragma mark --- 获取方法列表 ------
//获取方法列表
- (void)getMethodList {
    unsigned int count;
    Method *methods = class_copyMethodList([self class], &count);
    for (int i = 0; i < count; i++) {
        Method method = methods[i];
        SEL selector = method_getName(method);
        NSString *name = NSStringFromSelector(selector);
        NSLog(@"%@",name);
    }
}

#pragma mark - 获取成员变量列表-
- (void)getIvarList {
    unsigned int numIvars;
    Ivar *vars = class_copyIvarList([self class], &numIvars);
    NSString *key=nil;
    for(int i = 0; i < numIvars; i++) {
        Ivar thisIvar = vars[i];
        key = [NSString stringWithUTF8String:ivar_getName(thisIvar)];
        NSLog(@"%@", key);
    }
    free(vars);
}
//添加方法
- (void)addMethod:(NSString *)selString {

    SEL sel = NSSelectorFromString(selString);
    [self.class zjj_addMethod:sel methodImp:@selector(qutamadeIMP)];
    SuppressPerformSelectorLeakWarning( [self performSelector:sel];);
}
- (void)qutamadeIMP {
    NSLog(@"动态添加方法");
}
//添加方法
+ (BOOL)zjj_addMethod:(SEL)methodSel methodImp:(SEL)methodImp {
    Class class = [self class];
    Method method = class_getInstanceMethod(class, methodImp);
    IMP methodIMP = method_getImplementation(method);
    const char *types = method_getTypeEncoding(method);
    // class: 给哪个类添加方法
    // SEL: 添加哪个方法
    // IMP: 方法实现 => 函数 => 函数入口 => 函数名
    // type: 方法类型：void用v来表示，id参数用@来表示，SEL用:来表示
    return class_addMethod(class, methodSel, methodIMP, types);
}
- (void)testIMP {
    NSLog(@"添加方法");
}

//交换实例方法
+ (void)zjj_swapOriginSel:(SEL)originSel currentSel:(SEL)currentSel {
    Method originMethod = class_getInstanceMethod([self class], originSel);
    Method currentMethod = class_getInstanceMethod([self class], currentSel);
    const char *types = method_getTypeEncoding(originMethod);
    IMP originIMP = method_getImplementation(originMethod);

    //添加成功：说明源SEL没有实现IMP，将源SEL的IMP替换到交换SEL的IMP
    if ([self zjj_addMethod:originSel methodImp:currentSel]) {
        class_replaceMethod([self class], currentSel, originIMP, types);
    }else{
        method_exchangeImplementations(originMethod, currentMethod);
    }
}
- (void)iAmBeautiful
{
    NSLog(@"我是美女");
}
- (void)iAmFool {
    NSLog(@"你是傻逼");
}

- (void)getSel {
//SEL又叫选择器，是表示一个方法的selector的指针，其定义如下：
   // typedef struct objc_selector *SEL;
/*
 不同的类可以拥有相同的selector，这个没有问题。不同类的实例对象执行相同的selector时，会在各自的方法列表中去根据selector去寻找自己对应的IMP。

 工程中的所有的SEL组成一个Set集合，Set的特点就是唯一，因此SEL是唯一的。因此，如果我们想到这个方法集合中查找某个方法时，只需要去找到这个方法对应的SEL就行了，SEL实际上就是根据方法名hash化了的一个字符串，而对于字符串的比较仅仅需要比较他们的地址就可以了  本质上，SEL只是一个指向方法的指针
 */
   SEL sel = sel_registerName("iAmBeautiful");
    SuppressPerformSelectorLeakWarning( [self performSelector:sel];);

    SEL sel1 = @selector(iAmFool);
     SuppressPerformSelectorLeakWarning( [self performSelector:sel1];);

    SEL sel2 = NSSelectorFromString(@"iAmBeautiful");
     SuppressPerformSelectorLeakWarning( [self performSelector:sel2];);

}
- (void)methodTest {
    
    /*
     struct objc_method
     {
     SEL method_name;
     char * method_types;
     IMP method_imp;
     };
     typedef objc_method Method;
     */
    
//    Method originMethod = class_getInstanceMethod([self class], @selector(viewDidLoad));
    
}

- (UITableView *)tableView {
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellName];
        _tableView.frame = self.view.frame;
    }
    return _tableView;
}
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return dataArray.count;
}
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellName forIndexPath:indexPath];
    return cell;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.textLabel.text = dataArray[indexPath.row];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
            [self getSel];
            break;
        case 1:
            [self getClass];
            break;
        case 2:
            [self reflex];
            break;
        case 3:
            [self getProperties];
            break;
        case 4:
            [self getMethodList];
            break;
        case 5:
            [self getIvarList];
            break;
        case 6:
            [self addMethod:@"qutamade"];
            break;
        case 7:
            [self iAmBeautiful];
            break;
        case 8:
            [self methodTest];
            break;

        default:
            break;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
