//
//  MySplitViewController.h
//  NSSplitView-Part1
//
//  Created by Jeff Schilling on 12/28/09.
//  Copyright 2009 Manicwave Productions. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface MySplitViewController : NSObject <NSSplitViewDelegate> {
    NSSplitView* mySplitView_;
}

@property(nonatomic,assign)IBOutlet NSSplitView *mySplitView;

-(IBAction)toggleRightView:(id)sender;

@end
