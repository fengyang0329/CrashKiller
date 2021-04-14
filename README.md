# CrashKiller

这套防护系统被命名为：『CrashKiller（闪退杀手）』，名字缘起于电影《杀死比尔》。
<br>不过呢，这不重要。。。我就是为这个项目起了个花里胡哨的名字，并给这个名字赋予了一些无聊的意义。。。

## 安装

通过[CocoaPods](https://cocoapods.org)方式安装`CrashKiller `,请在`Podfile `中指定：

```
//私有库，需要指定CocoaPods源(source)
source 'git@gitlab.mypaas.com.cn:appcloud/cocoapods/specs.git'
//安装最新的tag版本
pod 'CrashKiller'

//或直接使用master最新代码：
pod 'CrashKiller',:git =>'git@gitlab.mypaas.com.cn:appcloud/cocoapods/MicBaseLib.git'
```

## 如何使用

### 所有异常的分类，根据自身需要，自由组合

```js
typedef NS_OPTIONS(NSUInteger, CrashKillerDefendCrashType) {

    CrashKillerDefendUnrecognizedSelector = 1 << 1,
    CrashKillerDefendKVC = 1 << 2,
    CrashKillerDefendKVO = 1 << 3,
    CrashKillerDefendNSTimer = 1 << 4,
    CrashKillerDefendDictionaryContainer = 1 << 4,
    CrashKillerDefendArrayContainer = 1 << 5,
    CrashKillerDefendStringContainer = 1 << 6,
    CrashKillerDefendAll = CrashKillerDefendUnrecognizedSelector | CrashKillerDefendKVC | CrashKillerDefendKVO | CrashKillerDefendNSTimer | CrashKillerDefendDictionaryContainer | CrashKillerDefendArrayContainer | CrashKillerDefendStringContainer
};
```

### 配置异常类型并开启

```js
[CrashKiller configDefendCrashType:CrashKillerDefendUnrecognizedSelector | CrashKillerDefendKVC];
[CrashKiller startWihtLogDelegate:nil];
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

### 如果需要记录日志，在开启的时候注册协议，并实现`CrashKillerLogDelegate`

```js
[CrashKiller startWihtLogDelegate:(id<CrashKillerLogDelegate>)self];
- (void)onLog:(NSString*)log callStackSymbols:(NSArray <NSString *> *)callStackSymbols;
{
    NSLog(@"%@\n   *** First throw call stack:%@",log,callStackSymbols);
}
```

## 可以防护的崩溃类型

- [x] Unrecognized Selector

- [x]  KVO Crash

- [x]  KVC Crash

- [x] NSTimer
 
- [x] NSNull

- [x] NSArray,NSMutableArray,NSDictonary,NSMutableDictionary,NSString,NSMutableString




## License

CrashKiller is available under the MIT license. See the LICENSE file for more info.
