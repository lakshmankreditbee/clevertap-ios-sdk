#import "CTCarouselImageMessageCell.h"
#import "CTCarouselImageView.h"

@implementation CTCarouselImageMessageCell

-(void)onAwake {
    // no-op here
}

-(void)populateItemViews {
    self.itemViews = [NSMutableArray new];
    int index = 0;
    for (CleverTapInboxMessageContent *content in (self.message.content)) {
        NSString *imageUrl = content.mediaUrl;
        NSString *actionUrl = content.actionUrl;
        
        if (imageUrl == nil) {
            continue;
        }
        CTCarouselImageView *itemView;
        if (itemView == nil){
            CGRect frame = self.carouselView.bounds;
            frame.size.height =  frame.size.height;
            frame.size.width = frame.size.width;
            itemView = [[CTCarouselImageView alloc] initWithFrame:frame
                                                         imageUrl:imageUrl actionUrl:actionUrl
                                              orientationPortrait: [self orientationIsPortrait]];
        }
        
        UITapGestureRecognizer *itemViewTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleItemViewTapGesture:)];
        itemView.userInteractionEnabled = YES;
        itemView.tag = index;
        [itemView addGestureRecognizer:itemViewTapGesture];
        [self.itemViews addObject:itemView];
        index++;
    }
}

- (void)setupMessage:(CleverTapInboxMessage *)message {
    self.dateLabel.text = message.relativeDate;
    self.readView.hidden = message.isRead;
    self.readViewWidthConstraint.constant = message.isRead ? 0 : 16;
    UIInterfaceOrientation orientation = [[CTInAppResources getSharedApplication] statusBarOrientation];
    BOOL landscape = (orientation == UIInterfaceOrientationLandscapeLeft || orientation == UIInterfaceOrientationLandscapeRight);
    CGFloat viewWidth = landscape ? self.frame.size.width : (CGFloat) [[UIScreen mainScreen] bounds].size.width;
    CGFloat viewHeight = viewWidth;
    if (![self orientationIsPortrait]) {
        viewHeight = (viewWidth*[self getLandscapeMultiplier]);
    }
    CGRect frame = CGRectMake(0, 0, viewWidth, viewHeight);
    self.frame = frame;
    if (!landscape) {
        self.carouselViewHeight.constant = viewHeight;
        self.carouselView.frame = frame;
    } else {
        viewWidth = self.carouselView.frame.size.width;
        self.carouselViewHeight.constant = [[UIScreen mainScreen] bounds].size.height - 80;
    }
    for (UIView *view in self.itemViews) {
        [view removeFromSuperview];
    }
    for (UIView *subview in [self.carouselView subviews]) {
        [subview removeFromSuperview];
    }
    [self configureSwipeViewWithHeightAdjustment:0];
    [self populateItemViews];
    [self configurePageControlWithRect:CGRectMake(0, self.carouselView.frame.size.height, viewWidth, [self heightForPageControl])];
    [self.swipeView reloadData];
}

@end
