//
//  Song.h
//  Playsongs
//
//  Created by Bala Bhadra Maharjan on 8/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Playlist;

@interface Song :  NSManagedObject  
{
}

@property (nonatomic, retain) NSNumber * isVideo;
@property (nonatomic, retain) NSNumber * isLullaby;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * url;
@property (nonatomic, retain) NSString * localPath;
@property (nonatomic, retain) NSSet* favouritePlaylist;

@end


@interface Song (CoreDataGeneratedAccessors)
- (void)addFavouritePlaylistObject:(Playlist *)value;
- (void)removeFavouritePlaylistObject:(Playlist *)value;
- (void)addFavouritePlaylist:(NSSet *)value;
- (void)removeFavouritePlaylist:(NSSet *)value;

@end

