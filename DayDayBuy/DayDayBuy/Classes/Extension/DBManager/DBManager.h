#import <Foundation/Foundation.h>
#import "FMDatabase.h"

@interface DBManager : NSObject

+ (DBManager *)sharedManager;

- (BOOL)insertGoods:(id)goods;

- (BOOL)deleteItemWithId:(NSString *)id;

- (BOOL)isExistItemWithId:(NSString *)id;

- (NSInteger)getCountsOfItem;

- (NSArray *)readItemsFromCollection;

@end


