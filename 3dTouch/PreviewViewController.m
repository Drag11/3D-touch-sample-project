//
//  PreviewViewController.m
//  3dTouch
//
//  Created by Dmitriy Zakharov on 2015-10-09.
//

#import <Foundation/Foundation.h>
#import "PreviewViewController.h"

@implementation PreviewViewController


- (NSArray <id <UIPreviewActionItem>> *)previewActionItems {
    UIPreviewAction *action = [UIPreviewAction actionWithTitle:@"Reload" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        //handler
    }];
    
    UIPreviewAction *action2 = [UIPreviewAction actionWithTitle:@"Share to Redpsace" style:UIPreviewActionStyleSelected handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        //handler
    }];
    
    UIPreviewAction *action3 = [UIPreviewAction actionWithTitle:@"Share to iOS team" style:UIPreviewActionStyleDestructive handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        //handler
    }];
    
    UIPreviewActionGroup *group1 = [UIPreviewActionGroup actionGroupWithTitle:@"Action Group" style:UIPreviewActionStyleDefault actions:@[action2, action3, action]];
    
    return @[action2, action3, group1];
}

@end