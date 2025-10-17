# CrashKiller

此防护系统并不能解决所有的崩溃类型，只是对一些[高频crash](#高频crash)进行一一的处理，我们的目的就是降低crash率。
<br>这套防护系统被命名为：『CrashKiller（闪退杀手）』，名字缘起于电影《杀死比尔》。
<br>不过呢，这不重要。。。我就是为这个项目起了个花里胡哨的名字，并给这个名字赋予了一些无聊的意义。。。


## 安装

通过[CocoaPods](https://cocoapods.org)方式安装`CrashKiller `,请在`Podfile `中指定：

```
//安装最新的tag版本
pod 'CrashKiller'
```

## 如何使用

### 所有异常的分类，根据自身需要，自由组合

```js
typedef NS_OPTIONS(NSUInteger, CrashKillerDefendCrashType) {

    CrashKillerDefendUnrecognizedSelector = 1 << 1,
    CrashKillerDefendKVC = 1 << 2,
    CrashKillerDefendKVO = 1 << 3,
    CrashKillerDefendNSTimer = 1 << 4,
    CrashKillerDefendDictionaryContainer = 1 << 5,
    CrashKillerDefendArrayContainer = 1 << 6,
    CrashKillerDefendStringContainer = 1 << 7,
    CrashKillerDefendSetContainer = 1 << 8,
    CrashKillerDefendJSONSerialization = 1 << 9,
    CrashKillerDefendNSFileManager = 1 << 10,
    CrashKillerDefendNSFileHandle = 1 << 11,
    CrashKillerDefendDataContainer = 1 << 12,
    CrashKillerDefendAll = CrashKillerDefendUnrecognizedSelector | CrashKillerDefendKVC | CrashKillerDefendKVO | CrashKillerDefendNSTimer | CrashKillerDefendDictionaryContainer | CrashKillerDefendArrayContainer | CrashKillerDefendStringContainer | CrashKillerDefendSetContainer | CrashKillerDefendJSONSerialization | CrashKillerDefendNSFileManager | CrashKillerDefendNSFileHandle | CrashKillerDefendDataContainer
};
```

### 配置异常类型并开启，根据需求自由组合异常类型;默认`CrashKillerDefendAll `

```js
[CrashKiller configDefendCrashType:CrashKillerDefendUnrecognizedSelector | CrashKillerDefendKVC];
[CrashKiller start];
```

### 当异常时，默认程序不会中断，如果需要遇到异常时退出，需要如下设置:

```js
//如果terminateWhenException设置为YES,发生异常时将终止应用程序
//如果terminateWhenException设置为NO，则该异常只显示在控制台上，不会停止应用程序
//默认NO
CrashKiller.terminateWhenException = YES;
```

### 如果需要关闭防护系统内部打印日志，需要如下设置

```js
//YES:打印日志 NO:不打印日志；默认YES
CrashKiller.debugLog = NO;
```

### 如果有些类不需要添加防护，可设置白名单

```js
/*
 类名白名单
 白名单里的类中方法不做处理，相当于这个类关闭了CrashKillerDefendUnrecognizedSelector防护功能
 [CrashKiller addSelectorClassWhiteList:@[NSClassFromString(@"MAUserLocation")]];
 */
+ (void)addSelectorClassWhiteList:(NSArray*)objects;
```

### 如果需要记录日志，注册协议并实现`CrashKillerLogDelegate`

```js
[CrashKiller handleCrashLog:(id<CrashKillerLogDelegate>)self];
- (void)onLog:(NSException *)exception
{
    NSLog(@"%@\n   *** First throw call stack:%@",exception.reason,exception.callStackSymbols);
}
```

## <a name="高频crash"></a>可以防护的崩溃类型

- [x] Unrecognized Selector（找不到对象方法或者类方法的实现）<br>
- [x]  KVO Crash
	1. KVO 添加次数和移除次数不匹配：
		* 移除未注册的观察者，导致崩溃
		* 重复移除多次，移除次数多于添加次数，导致崩溃
		* 重复添加多次，虽然不会崩溃，但是发生改变时，也同时会被观察多次
	2. 被观察者提前被释放，被观察者在 dealloc 时仍然注册着 KVO，导致崩溃。 例如：被观察者是局部变量的情况（iOS 10 及之前会崩溃）。
	3. 添加了观察者，但未实现 observeValueForKeyPath:ofObject:change:context: 方法，导致崩溃。
	4. 添加或者移除时 keypath == nil，导致崩溃。<br>
- [x]  KVC Crash
	1. key 不是对象的属性，造成崩溃。
	2. keyPath 不正确，造成崩溃。
	3. key 为 nil，造成崩溃。
	4. value 为 nil，为非对象设值，造成崩溃。<br>
- [x] NSTimer
	1. 注册了没有主动释放，会导致内存泄露，多线程中有可能会闪退 <br>
- [x] NSNull
	1. null类型调用其他类型（如NSString,NSNumber）方法，找不到方法 <br>
- [x] NSArray,NSMutableArray,NSDictonary,NSMutableDictionary,NSString,NSMutableString，NSSet，NSMutableSet，NSJSONSerialization，NSFileManager，NSFileHandle，NSData
	1. 数组越界，参数为nil等



## License

CrashKiller is available under the MIT license. See the LICENSE file for more info.
