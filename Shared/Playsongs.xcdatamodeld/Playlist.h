//
//  Playlist.h
//  Playsongs
//
//  Created by Bala Bhadra Maharjan on 8/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Song;

@interface Playlist :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSSet* favouriteSong;

@end


@interface Playlist (CoreDataGeneratedAccessors)
- (void)addFavouriteSongObject:(Song *)value;
- (void)removeFavouriteSongObject:(Song *)value;
- (void)addFavouriteSong:(NSSet *)value;
- (void)removeFavouriteSong:(NSSet *)value;

@end

