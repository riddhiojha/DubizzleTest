//
//  MasterViewController.h
//  DubizzleTest
//
//  Created by Riddhi Ojha on 12/21/16.
//
//

#import <UIKit/UIKit.h>
#import "MovieListManager.h"
#import "FilterViewController.h"

@class DetailViewController;

@interface MasterViewController : UIViewController<MovieListManagerDelegate, FilterViewDelegate, UITableViewDelegate, UITableViewDataSource>
{
    MovieListManager *movieManager;
    NSMutableArray *movieDataArray;
    int countForPagination;
    BOOL isFilterImplemented;
}

@property (strong, nonatomic) DetailViewController *detailViewController;
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

