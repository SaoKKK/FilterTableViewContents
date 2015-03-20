//
//  AppDelegate.m
//  FilterTableViewContents
//
//  Created by 河野 さおり on 2015/03/20.
//  Copyright (c) 2015年 Saori Kohno. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (){
    IBOutlet NSSearchField *searchField;
    NSString* srcPath;
}

@property (strong) IBOutlet NSWindow *window;
@property (strong) IBOutlet NSTableView *table;
@end

@implementation AppDelegate
@synthesize table,srcList,filteredList;

- (id)init{
    self = [super init];
    if (self) {
        srcList = [[NSMutableArray array]retain];
        filteredList = [[NSMutableArray array]retain];
    }
    return self;
}

- (void)dealloc{
    [srcList release];
    [filteredList release];
    [super dealloc];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    //srcList読み込み
    srcPath = [[[NSBundle mainBundle] pathForResource:@"srcList" ofType: @"array"]retain];
    srcList = [[NSMutableArray arrayWithContentsOfFile:srcPath]retain];
    //filteredList初期化
    filteredList = [[NSMutableArray arrayWithArray:srcList]retain];
    [table reloadData];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    [srcList writeToFile:srcPath atomically:YES];
}

- (IBAction)searthAction:(id)sender {
    NSString* filterStr = [sender stringValue];
    if ([filterStr isEqualToString:@""]) {
        //searchFieldが空の場合（空の文字列でフィルター処理ってのは無理らしいので必要）
        //filteredListを初期化
        filteredList = [[NSMutableArray arrayWithArray:srcList]retain];
    }else{
        //searchFieldの文字列でフィルター処理
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"FirstName CONTAINS %@",filterStr];
        filteredList = [[NSMutableArray arrayWithArray:[srcList filteredArrayUsingPredicate:predicate]]retain];
    }
    [table reloadData];
}

//誕生日ボタンが押された
- (IBAction)pshBirthday:(id)sender {
    for (NSDictionary *data in filteredList) {
        int index = [[data objectForKey:@"ID"]intValue];
        int age = [[[srcList objectAtIndex:index]objectForKey:@"Age"]intValue];
        age ++;
        [[srcList objectAtIndex:index]setObject:[NSNumber numberWithInt:age] forKey:@"Age"];
        [table reloadData];
    }
}

@end
