//
//  MySplitViewController.m
//  NSSplitView-Part1
//
//  Created by Jeff Schilling on 12/28/09.
//  Copyright 2009 Manicwave Productions. All rights reserved.
//

#import "MySplitViewController.h"

@interface MySplitViewController() 
-(void)collapseRightView;
-(void)uncollapseRightView;
@end
@implementation MySplitViewController
@synthesize mySplitView = mySplitView_;


#pragma mark -- Programmatic Collapsing

-(IBAction)toggleRightView:(id)sender;
{
	BOOL rightViewCollapsed = [[self mySplitView] isSubviewCollapsed:[[[self mySplitView] subviews] objectAtIndex: 1]];
    NSLog(@"%@:%s toggleInspector isCollapsed: %@",[self class], _cmd, rightViewCollapsed?@"YES":@"NO");
	if (rightViewCollapsed) {
		[self uncollapseRightView];
	} else {
		[self collapseRightView];
	}
}

-(void)collapseRightView
{
	
	NSView *right = [[[self mySplitView] subviews] objectAtIndex:1];
	NSView *left  = [[[self mySplitView] subviews] objectAtIndex:0];
    NSRect leftFrame = [left frame];
    NSRect overallFrame = [[self mySplitView] frame]; //???
    [right setHidden:YES];
    [left setFrameSize:NSMakeSize(overallFrame.size.width,leftFrame.size.height)];
	[[self mySplitView] display];
}

-(void)uncollapseRightView
{
	NSView *left  = [[[self mySplitView] subviews] objectAtIndex:0];
	NSView *right = [[[self mySplitView] subviews] objectAtIndex:1];
    [right setHidden:NO];
    
	CGFloat dividerThickness = [[self mySplitView] dividerThickness];
	
    // get the different frames
	NSRect leftFrame = [left frame];
	NSRect rightFrame = [right frame];
    
	leftFrame.size.width = (leftFrame.size.width-rightFrame.size.width-dividerThickness);
	rightFrame.origin.x = leftFrame.size.width + dividerThickness;
	[left setFrameSize:leftFrame.size];
	[right setFrame:rightFrame];
	[[self mySplitView] display];
}

- (BOOL)splitView:(NSSplitView *)splitView canCollapseSubview:(NSView *)subview;
{
    NSView* rightView = [[splitView subviews] objectAtIndex:1];
    NSLog(@"%@:%s returning %@",[self class], _cmd, ([subview isEqual:rightView])?@"YES":@"NO");
    return ([subview isEqual:rightView]);
}

/* Return YES if the subview should be collapsed because the user has double-clicked on an adjacent divider. If a split view has a delegate, and the delegate responds to this message, it will be sent once for the subview before a divider when the user double-clicks on that divider, and again for the subview after the divider, but only if the delegate returned YES when sent -splitView:canCollapseSubview: for the subview in question. When the delegate indicates that both subviews should be collapsed NSSplitView's behavior is undefined.
 */
- (BOOL)splitView:(NSSplitView *)splitView shouldCollapseSubview:(NSView *)subview forDoubleClickOnDividerAtIndex:(NSInteger)dividerIndex;
{ 
    NSView* rightView = [[splitView subviews] objectAtIndex:1];
    NSLog(@"%@:%s returning %@",[self class], _cmd, ([subview isEqual:rightView])?@"YES":@"NO");
    return ([subview isEqual:rightView]);
}

- (BOOL)splitView:(NSSplitView *)splitView shouldHideDividerAtIndex:(NSInteger)dividerIndex;
{
    NSLog(@"%@:%s returning NO",[self class], _cmd);
    return YES;
}

//- (BOOL)splitView:(NSSplitView *)splitView shouldAdjustSizeOfSubview:(NSView *)view;
//{
//    NSLog(@"%@:%s returning NO",[self class], _cmd);
//    return NO;
//}
//

/* From the header doc 
 * Delegates that respond to this message and return a number larger than the proposed minimum position effectively declare a minimum size for the subview above or to the left of the divider in question, 
 the minimum size being the difference between the proposed and returned minimum positions. This minimum size is only effective for the divider-dragging operation during which the 
 -splitView:constrainMinCoordinate:ofSubviewAt: message is sent. NSSplitView's behavior is undefined when a delegate responds to this message by returning a number smaller than the proposed minimum.
 */
- (CGFloat)splitView:(NSSplitView *)splitView constrainMinCoordinate:(CGFloat)proposedMinimumPosition ofSubviewAt:(NSInteger)dividerIndex;
{
    NSLog(@"%@:%s proposedMinimum: %f",[self class], _cmd, proposedMinimumPosition);
    return proposedMinimumPosition + 200;
}

/*  Delegates that respond to this message and return a number smaller than the proposed maximum position effectively declare a minimum size for the subview below or to the right of the divider in question, 
 the minimum size being the difference between the proposed and returned maximum positions. This minimum size is only effective for the divider-dragging operation during which the
 -splitView:constrainMaxCoordinate:ofSubviewAt: message is sent. NSSplitView's behavior is undefined when a delegate responds to this message by returning a number larger than the proposed maximum.
 */
- (CGFloat)splitView:(NSSplitView *)splitView constrainMaxCoordinate:(CGFloat)proposedMaximumPosition ofSubviewAt:(NSInteger)dividerIndex;
{
    NSLog(@"%@:%s proposedMaximum: %f",[self class], _cmd, proposedMaximumPosition);
    return proposedMaximumPosition - 100;
}

@end
