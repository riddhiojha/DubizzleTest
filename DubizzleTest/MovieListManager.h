//
//  MovieListManager.h
//  DubizzleTest
//
//  Created by Riddhi Ojha on 12/21/16.
//
//

#import <Foundation/Foundation.h>

@protocol MovieListManagerDelegate <NSObject>

@optional
- (void) movieListManagerCallback : (NSDictionary *) reponseDictionary;

@end

@interface MovieListManager : NSObject < NSURLConnectionDelegate, NSURLSessionDelegate>
{
    NSURLConnection *connection;
    NSMutableData *responseData;
}
@property (nonatomic, assign) id<MovieListManagerDelegate> delegate;
- (void) fetchMovieList;
@end
