How to change localization internally in your iOS application
============

Unfortunately, there’s no official way provided by <i>Apple</i> for this purpose. Let’s look at two methods for solving this problem.

## Method #1

<i>Apple</i> provides a way to specify an application-specific language, by updating the <i>“AppleLanguages”</i> key in <b>NSUserDefaults</b>. For example:

<pre>
[[NSUserDefaults standardUserDefaults] setObject:@"fr" forKey:@"AppleLanguages"];
[[NSUserDefaults standardUserDefaults] synchronize];
</pre>

For working this method, you’ll have to set it before <b>UIKit</b> initialized.

<pre>
#import &#60;UIKit/UIKit.h&#62;
#import "AppDelegate.h"
#import "LanguageManager.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        [[NSUserDefaults standardUserDefaults] setObject:@"fr" forKey:@"AppleLanguages"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}

</pre>

The problem of this method is that the app has to be relaunched to take effect.

## Method #2

The solution is to swap the <b>mainBundle</b> of our application as soon as the user changes their language preferences inside the app.

See the category for <b>NSBundle</b>.

Header:

<pre>
#import &#60;Foundation/Foundation.h&#62;

@interface NSBundle (Language)

+ (void)setLanguage:(NSString *)language;

@end
</pre>

Implementation:

<pre>
#import "NSBundle+Language.h"
#import &#60;objc/runtime.h&#62;

static const char kBundleKey = 0;

@interface BundleEx : NSBundle

@end

@implementation BundleEx

- (NSString *)localizedStringForKey:(NSString *)key value:(NSString *)value table:(NSString *)tableName
{
    NSBundle *bundle = objc_getAssociatedObject(self, &kBundleKey);
    if (bundle) {
        return [bundle localizedStringForKey:key value:value table:tableName];
    }
    else {
        return [super localizedStringForKey:key value:value table:tableName];
    }
}

@end

@implementation NSBundle (Language)

+ (void)setLanguage:(NSString *)language
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        object_setClass([NSBundle mainBundle],[BundleEx class]);
    });
    id value = language ? [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:language ofType:@"lproj"]] : nil;
    objc_setAssociatedObject([NSBundle mainBundle], &kBundleKey, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
</pre>

In this method, a problem that may arise is updating elements on active screens. You can reload your <b>rootViewController</b> from our application delegate, will always work reliably.

<pre>
- (void)reloadRootViewController
{
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    NSString *storyboardName = @"Main";
    UIStoryboard *storybaord = [UIStoryboard storyboardWithName:storyboardName bundle:nil];
    delegate.window.rootViewController = [storybaord instantiateInitialViewController];
}
</pre>

All code you can see in this repository. With simple example.

![alt tag](https://raw.github.com/maximbilan/ios_language_manager/master/img/1.png)

Please, use for free and like it ☺.

<b>Note:</b> In example project by default the app uses <i>method #2</i>. You can disable this. Just comment define <b>USE_ON_FLY_LOCALIZATION</b>.

More details on the blog <a href="http://www.factorialcomplexity.com/blog/2015/01/28/how-to-change-localization-internally-in-your-ios-application.html">here</a>.
