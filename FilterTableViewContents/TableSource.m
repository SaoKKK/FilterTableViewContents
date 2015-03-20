//
//  TableSource.m
//  FilterTableViewContents
//
//  Created by 河野 さおり on 2015/03/20.
//  Copyright (c) 2015年 Saori Kohno. All rights reserved.
//

#import "TableSource.h"
#import "AppDelegate.h"

@implementation TableSource

#pragma mark - NSTableView data source

- (NSInteger)numberOfRowsInTableView:(NSTableView*)tableView{
    AppDelegate *appD = (AppDelegate*)[[NSApplication sharedApplication]delegate];
    return appD.filteredList.count;
}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row{
    AppDelegate *appD = (AppDelegate*)[[NSApplication sharedApplication]delegate];
    NSString* identifier = [tableColumn identifier];
    NSDictionary *data = [appD.filteredList objectAtIndex:row];
    return [data objectForKey:identifier];
}
@end
