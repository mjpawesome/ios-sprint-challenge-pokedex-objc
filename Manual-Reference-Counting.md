# Manual Reference Counting

Answer the following questions inline with this document.

1. Are there memory leaks with this code? (If so, where are the leaks?)

	```swift
	NSString *quote = @"Your work is going to fill a large part of your life, and the only way to be truly satisfied is to do what you believe is great work. And the only way to do great work is to love what you do. If you haven't found it yet, keep looking. Don't settle. As with all matters of the heart, you'll know when you find it. - Steve Jobs";

	NSCharacterSet *punctuationSet = [[NSCharacterSet punctuationCharacterSet] retain];

you don't need to retain punctuationSet.  

	NSString *cleanQuote = [[quote componentsSeparatedByCharactersInSet:punctuationSet] componentsJoinedByString:@""];
	NSArray *words = [[cleanQuote lowercaseString] componentsSeparatedByString:@" "];

	NSMutableDictionary<NSString *, NSNumber *> *wordFrequency = [[NSMutableDictionary alloc] init];
    
    

	for (NSString *word in words) {
		NSNumber *count = wordFrequency[word];
		if (count) {
			wordFrequency[word] = [NSNumber numberWithInteger:count.integerValue + 1];
		} else {
			wordFrequency[word] = [[NSNumber alloc] initWithInteger:1];
		}
	}

	printf("Word frequency: %s", wordFrequency.description.UTF8String);
	```

	2. Rewrite the code so that it does not leak any memory with ARC disabled

2. Which of these objects is autoreleased?  Why?

	1. `NSDate *yesterday = [NSDate date];`
    
        yes, we don't own it
	
	2. `NSDate *theFuture = [[NSDate dateWithTimeIntervalSinceNow:60] retain];`
    
    No.  We're retaining the object.
	
	3. `NSString *name = [[NSString alloc] initWithString:@"John Sundell"];`
    
    No.  We've created an instance of the object that we own.
	
	4. `NSDate *food = [NSDate new];`
    No.  We've created a new instance we own.
    
	5. `LSIPerson *john = [[LSIPerson alloc] initWithName:name];`
    No.  We've recreated a new instance we own.
	
	6. `LSIPerson *max = [[[LSIPerson alloc] initWithName:@"Max"] autorelease];`
    Yes, we've used the autorelease functionality.
    
3. Explain when you need to use the `NSAutoreleasePool`.

From Apple's documentation:

If you write a loop that creates many temporary objects. You may use an autorelease pool block inside the loop to dispose of those objects before the next iteration. Using an autorelease pool block in the loop helps to reduce the maximum memory footprint of the application.

If you spawn a secondary thread.  You must create your own autorelease pool block as soon as the thread begins executing; otherwise, your application will leak objects.

4. Implement a convenience `class` method to create a `LSIPerson` object that takes a `name` property and returns an autoreleased object.

```swift
@interface LSIPerson: NSObject

@property (nonatomic, copy) NSString *name;

- (instancetype)initWithName:(NSString *)name;

+ (instancetype)contactName:(NSString *)name {
return [[[LSIperson alloc] initWithName:name] autorelease];
}

@end
```
