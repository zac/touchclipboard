//
//  ZWClipboard.m
//  CopyPaste
//
//  Created by Zac White on 8/2/08.
//  Copyright 2008 Zac White. All rights reserved.
//

#import "ZWClipboard.h"

#define CLIPBOARD_NAME @"clipboard.data"
#define CLIPBOARD_PATH [NSString stringWithFormat:@"%@/Documents/%@", NSHomeDirectory(), CLIPBOARD_NAME]

#define APPLICATION_DIRECTORY @"/private/var/mobile/Applications/"

@implementation ZWClipboard

static id instance = nil;

+ (ZWClipboard *)sharedClipboard {
    if (!instance) instance = [[ZWClipboard alloc] init];
    return instance;
}

- (id)init {
	if(!(self = [super init])) return nil;
	
	localClipboard = [(NSMutableArray *)[NSKeyedUnarchiver unarchiveObjectWithFile:CLIPBOARD_PATH] retain];
	if(localClipboard) {
		//we have a local clipboard.
	} else {
		localClipboard = [[NSMutableArray alloc] init];
	}
	
	externalPaths = [[NSMutableArray alloc] init];
	
	NSDirectoryEnumerator *enumerator = [[NSFileManager defaultManager] enumeratorAtPath:@"/private/var/mobile/Applications/"]; 
	id item;
	while(item = [enumerator nextObject]){
		BOOL dir = [[[enumerator fileAttributes] objectForKey:NSFileTypeDirectory] boolValue];
		NSAssert(!dir, @"This really shouldn't happen");
		
		[externalPaths addObject:[APPLICATION_DIRECTORY stringByAppendingPathComponent:item]];
		
		[enumerator skipDescendents];
	}
	
	return self;
}

- (BOOL)copyData:(NSData *)data withMimeType:(NSString *)mimeType error:(NSError **)err {
	ZWClipboardItem *item = [[ZWClipboardItem alloc] init];
	item.data = data;
	item.mimeType = mimeType;
	item.owningApplicationInfo = nil; //TODO: Fix.
	item.timeStamp = [NSDate new];
		
	[localClipboard addObject:item];
	[item release];
	return YES;
}

- (BOOL)copyClipboardItem:(ZWClipboardItem *)item error:(NSError **)err {
	[localClipboard addObject:item];
	return YES;
}

- (ZWClipboardItem *)pasteLatest:(NSError **)err {
	NSError *error = NULL;
	NSArray *allPastes = [self pasteList:&error];
	
	if(error || [allPastes count] == 0){
		*err = error;
		return nil;
	}
	
	return [allPastes objectAtIndex:0];
}

- (ZWClipboardItem *)pasteLatestWithMimeType:(NSString *)mimeType error:(NSError **)err {
	NSError *error = NULL;
	NSArray *allPastes = [self pasteList:&error];
	
	if(error || [allPastes count] == 0) {
		*err = error;
		return nil;
	}
	
	for(ZWClipboardItem *item in allPastes) {
		if([item.mimeType isEqualToString:mimeType]){
			return item;
		}
	}
	return nil;
}

- (NSArray *)pasteList:(NSError **)err {
	NSString *path;
	
	NSMutableArray *allPastes = [[NSMutableArray alloc] init];
	
	for(path in externalPaths){
		NSMutableArray *appPastes = [NSKeyedUnarchiver unarchiveObjectWithFile:[[path stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:CLIPBOARD_NAME]];
		if(appPastes){
			[allPastes addObjectsFromArray:appPastes];
		}
	}
	
	NSArray *sorted = [self sortedArray:[allPastes autorelease] ascending:YES];

	return sorted;
}

NSComparisonResult PasteSortNewestFirst(ZWClipboardItem *s1, ZWClipboardItem *s2, void *ascending) {
    return ascending ? [s2.timeStamp compare:s1.timeStamp] : [s1.timeStamp compare:s2.timeStamp];
}

- (NSArray *)sortedArray:(NSArray *)inArray ascending:(BOOL)ascending {
    return [inArray sortedArrayUsingFunction:PasteSortNewestFirst context:(void*)ascending];
}

- (BOOL)writeToFile:(NSError **)err {	
	BOOL success = [NSKeyedArchiver archiveRootObject:localClipboard toFile:CLIPBOARD_PATH];
	
	if(!success) {
		NSString *description = @"could not write clipboard file.";
		*err = [NSError errorWithDomain:@"ZWClipboard" code:1 userInfo:[NSDictionary dictionaryWithObject:description forKey:NSLocalizedDescriptionKey]];
		return NO;
	}
	
	//NSLog(@"WRITING %@ %@ %d", success?@"SUCCESS":@"FAIL", localClipboard);
	
	return YES;
}

- (void)dealloc{
	//write out our file if the dev forgets.
	[self writeToFile:NULL];
	
	[localClipboard release];
	[externalPaths release];
	
	[super dealloc];
}

@end
