//
//  MovieListManager.m
//  DubizzleTest
//
//  Created by Riddhi Ojha on 12/21/16.
//
//

#import "MovieListManager.h"

@implementation MovieListManager

- (void) fetchMovieList : (NSString *) pageNumber
{
    NSString *urlString = [NSString stringWithFormat:@"https://api.themoviedb.org/4/list/1?page=%@&api_key=8bbd6e918890081506dc33fa58f55c04", pageNumber];
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setHTTPMethod:@"GET"];
    connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
    if (responseData) {
        responseData = nil;
    }
    [connection start];
}

- (void) fetchMovieDetails : (NSString *) movieId
{
    NSString *urlString = [NSString stringWithFormat:@"https://api.themoviedb.org/3/movie/%@?api_key=8bbd6e918890081506dc33fa58f55c04", movieId];
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setHTTPMethod:@"GET"];
    connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
    if (responseData) {
        responseData = nil;
    }
    [connection start];
}

- (void) applyMovieFilter: (NSString *)minString : (NSString *)maxString
{
    NSString *urlString = [NSString stringWithFormat:@"https://api.themoviedb.org/3/discover/movie?api_key=8bbd6e918890081506dc33fa58f55c04&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&primary_release_date.gte=%@&primary_release_date.lte=%@", minString, maxString];
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setHTTPMethod:@"GET"];
    connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
    if (responseData) {
        responseData = nil;
    }
    [connection start];
}


#pragma mark - NSURLConnection delegate methods
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    responseData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [responseData appendData:data];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSMutableArray *stopArray = [[NSMutableArray alloc] init];
    NSMutableDictionary *responseDictionary = [[NSMutableDictionary alloc] init];
    
    if(responseData)
    {
        stopArray = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@", stopArray);
        responseDictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:stopArray,@"response",nil];
    }
    else
    {
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(movieListManagerCallback :)]) {
        [self.delegate movieListManagerCallback :responseDictionary];
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
}


@end
