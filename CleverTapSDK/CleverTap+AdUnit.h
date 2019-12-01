#import <Foundation/Foundation.h>
#import "CleverTap.h"
@class CTAdUnitUtils;
@class CleverTapAdUnitContent;

@interface CleverTapAdUnit : NSObject

- (instancetype _Nullable )initWithJSON:(NSDictionary *_Nullable)json;

@property (nullable, nonatomic, copy, readonly) NSDictionary *json;
@property (nullable, nonatomic, copy, readonly) NSString *adID;
@property (nullable, nonatomic, copy, readonly) NSString *type;
@property (nullable, nonatomic, copy, readonly) NSString *orientation;
@property (nullable, nonatomic, copy, readonly) NSDictionary *customExtras;
@property (nullable, nonatomic, copy, readonly) NSArray<CleverTapAdUnitContent *> *content;

@end

@interface CleverTapAdUnitContent : NSObject

@property (nullable, nonatomic, copy, readonly) NSString *title;
@property (nullable, nonatomic, copy, readonly) NSString *titleColor;
@property (nullable, nonatomic, copy, readonly) NSString *message;
@property (nullable, nonatomic, copy, readonly) NSString *messageColor;
@property (nullable, nonatomic, copy, readonly) NSString *backgroundColor;
@property (nullable, nonatomic, copy, readonly) NSString *videoPosterUrl;
@property (nullable, nonatomic, copy, readonly) NSString *actionUrl;
@property (nullable, nonatomic, copy, readonly) NSString *mediaUrl;
@property (nullable, nonatomic, copy, readonly) NSString *iconUrl;
@property (nonatomic, readonly, assign) BOOL mediaIsAudio;
@property (nonatomic, readonly, assign) BOOL mediaIsVideo;
@property (nonatomic, readonly, assign) BOOL mediaIsImage;
@property (nonatomic, readonly, assign) BOOL mediaIsGif;

- (instancetype _Nullable )initWithJSON:(NSDictionary *_Nullable)jsonObject;

@end

@protocol CleverTapAdUnitDelegate <NSObject>
@optional
- (void)adUnitsDidReceive:(NSArray<CleverTapAdUnit *>*_Nonnull)adUnits;
@end

typedef void (^CleverTapAdUnitSuccessBlock)(BOOL success);

@interface CleverTap (AdUnit)
 
- (CleverTapAdUnit *_Nullable)getAdUnitForID:(NSString *_Nonnull)adID;

- (void)setAdUnitDelegate:(id <CleverTapAdUnitDelegate>_Nonnull)delegate;
- (void)recordAdUnitViewedEventForID:(NSString *_Nonnull)adID;
- (void)recordAdUnitClickedEventForID:(NSString *_Nonnull)adID;

@end
