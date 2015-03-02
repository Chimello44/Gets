//
//  UserData.h
//  Gets
//
//  Created by Rafael  Hieda on 02/03/15.
//  Copyright (c) 2015 Hugo Luiz Chimello. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Site.h"
@interface UserData : NSObject
{
    NSString *name;
    NSString *city;
    NSMutableArray *favoriteSpots;
}

-(id)initWithName:(NSString *)yourName andCity:(NSString *) myCity;
@property NSString *name, *city;
@property NSMutableArray *favoriteSpots;

+(instancetype)singleton;
-(void)siteSort:(NSInteger)fromIndex toIndex:(NSInteger)toIndex;
-(void)insertSite:(Site *) newSite;
-(void)deleteSite:(NSInteger)siteIndex;
-(Site *)showSites;

@end
