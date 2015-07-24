#import "DBManager.h"
#import "DDBGoodsItem.h"
/*
 数据库
 1.导入 libsqlite3.dylib
 2.导入 fmdb
 3.导入头文件
 fmdb 是对底层C语言的sqlite3的封装
 */
@implementation DBManager
{
    FMDatabase *_database;
}

+ (DBManager *)sharedManager {
    static DBManager *manager = nil;
    @synchronized(self) {
        if (manager == nil) {
            manager = [[self alloc] init];
        }
    }
    return manager;
}
- (id)init {
    if (self = [super init]) {
        //1.获取数据库文件的路径
        NSString *filePath = [self getFileFullPathWithFileName:@"bookmark.db"];
        //2.创建database
        _database = [[FMDatabase alloc] initWithPath:filePath];
        //3.open数据库文件如果不存在会创建并且打开
        if ([_database open]) {
            NSLog(@"数据库打开成功");
            [self createTable];
        } else {
            NSLog(@"database open failed:%@",_database.lastErrorMessage);
        }
    }
    return self;
}

#pragma mark - 创建表
- (void)createTable {
    NSString *sql = @"create table if not exists collection(serial integer  Primary Key Autoincrement,id Varchar(1024),rank Varchar(1024),title Varchar(1024),iftobuy Varchar(1024), pubtime Varchar(1024),image Varchar(1024),buyurl Varchar(1024),fromsite Varchar(1024))";
    BOOL isSuccees = [_database executeUpdate:sql];
    if (!isSuccees) {
        NSLog(@"creatTable error:%@",_database.lastErrorMessage);
    }
}
#pragma mark - 获取文件的全路径
// 获取文件在沙盒中的 Documents中的路径
- (NSString *)getFileFullPathWithFileName:(NSString *)fileName {
    NSString *docPath = [NSHomeDirectory() stringByAppendingFormat:@"/Documents"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:docPath]) {
        return [docPath stringByAppendingFormat:@"/%@",fileName];
    } else {
        NSLog(@"Documents不存在");
        return nil;
    }
}

//增加数据
- (BOOL)insertGoods:(id)goods {
    DDBGoodsItem *item = (DDBGoodsItem *)goods;
    if ([self isExistItemWithId:item.id]) {
        // NSLog(@"this item has bookmarked");
        return NO;
    }
    NSString *sql = @"insert into collection(id, rank, title, iftobuy, pubtime, image, buyurl, fromsite) values (?,?,?,?,?,?,?,?)";
    BOOL isSuccess = [_database executeUpdate:sql,item.id,item.rank,item.title, item.iftobuy,item.pubtime,item.image,item.buyurl,item.fromsite];
    return isSuccess;
}

// 删除指定的收藏数据
- (BOOL)deleteItemWithId:(NSString *)id {
    NSString *sql = @"delete from collection where id = ? ";
    BOOL isSuccess = [_database executeUpdate:sql,id];
    if (!isSuccess) {
        NSLog(@"delete error:%@",_database.lastErrorMessage);
        return NO;
    }
    return YES;
}

// 查找所有的记录
- (NSArray *)readItemsFromCollection {
    
    NSString *sql = @"select * from collection";
    FMResultSet *resultSet = [_database executeQuery:sql];

    NSMutableArray *array = [NSMutableArray array];
    while ([resultSet next]) {
        //把查询之后结果 放在model
        DDBGoodsItem *item = [[DDBGoodsItem alloc] init];
        item.id = [resultSet stringForColumn:@"id"];
        item.title = [resultSet stringForColumn:@"title"];
        item.iftobuy = [resultSet stringForColumn:@"iftobuy"];
        item.rank = [resultSet stringForColumn:@"rank"];
        item.fromsite = [resultSet stringForColumn:@"fromsite"];
        item.buyurl = [resultSet stringForColumn:@"buyurl"];
        item.image = [resultSet stringForColumn:@"image"];
        item.pubtime = [resultSet stringForColumn:@"pubtime"];

        [array addObject:item];
    }
    return array;
}

- (BOOL)isExistItemWithId:(NSString *)id {
    NSString *sql = @"select * from collection where id = ? ";
    FMResultSet *resultSet = [_database executeQuery:sql,id];
    if ([resultSet next]) {
        return YES;
    } else {
        return NO;
    }
}

- (NSInteger)getCountsOfItem {
    NSString *sql = @"select count(*) from collection";
    FMResultSet *resultSet = [_database executeQuery:sql];
    NSInteger count = 0;
    while ([resultSet next]) {
        count = [[resultSet stringForColumnIndex:0] integerValue];
    }
    return count;
}

@end
