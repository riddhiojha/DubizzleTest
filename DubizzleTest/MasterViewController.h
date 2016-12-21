//
//  MasterViewController.h
//  DubizzleTest
//
//  Created by Riddhi Ojha on 12/21/16.
//
//

#import <UIKit/UIKit.h>
#import "MovieListManager.h"

@class DetailViewController;

@interface MasterViewController : UITableViewController<MovieListManagerDelegate>
{
    MovieListManager *movieManager;
    NSMutableArray *movieDataArray;
}

@property (strong, nonatomic) DetailViewController *detailViewController;


@end

