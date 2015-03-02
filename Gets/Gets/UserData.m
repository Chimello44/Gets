//
//  UserData.m
//  Gets
//
//  Created by Rafael  Hieda on 02/03/15.
//  Copyright (c) 2015 Hugo Luiz Chimello. All rights reserved.
//

#import "UserData.h"

@interface UserData()
@end
static UserData *singleton;
@implementation UserData
+(instancetype)singleton{
    if(singleton==nil)
        singleton=[[UserData alloc]init];
    return singleton;
}
-(id)initWithName:(NSString *)yourName andCity:(NSString *)myCity
{
    if(self = [super init])
    {
        name = yourName;
        city = myCity;
    }
    return self;
}

-(void)siteSort
{
    
}

-(void)insertSite:(Site *)newSite
{
    
}


-(void)deleteSite
{
    
}

-(Site*) showSites
{
    //ainda não tenho tanta certeza assim
    return [favoriteSpots objectAtIndex:0];
}

@end
