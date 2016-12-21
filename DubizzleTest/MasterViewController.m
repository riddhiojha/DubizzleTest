//
//  MasterViewController.m
//  DubizzleTest
//
//  Created by Riddhi Ojha on 12/21/16.
//
//
#import "SDWebImage/UIImageView+WebCache.h"
#import "MasterViewController.h"
#import "DetailViewController.h"
#import "MovieListTVC.h"

#define MOVIE_POSTER_PREFIX_URL @"https://image.tmdb.org/t/p/w1280"

@interface MasterViewController ()

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicatorLoading;
@property NSMutableArray *objects;
@end

@implementation MasterViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
}

- (void)viewWillAppear:(BOOL)animated {
    self.clearsSelectionOnViewWillAppear = self.splitViewController.isCollapsed;
    [super viewWillAppear:animated];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear: animated];
    movieManager = [[MovieListManager alloc] init];
    movieManager.delegate = self;
    countForPagination = 1;
    [movieManager fetchMovieList:@"1"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender {
    if (!self.objects) {
        self.objects = [[NSMutableArray alloc] init];
    }
    [self.objects insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDictionary *movieData = movieDataArray[indexPath.row];
        DetailViewController *controller = (DetailViewController *)[segue destinationViewController];
        [controller setMovieID:movieData[@"id"]];
        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        controller.navigationItem.leftItemsSupplementBackButton = YES;
    }
}

#pragma mark - Movie manager delegate methods
- (void) movieListManagerCallback : (NSDictionary *) reponseDictionary
{
    if (movieDataArray.count) {
        [movieDataArray addObjectsFromArray:reponseDictionary[@"response"][@"results"]];
    }
    else
    {
        movieDataArray = reponseDictionary[@"response"][@"results"];
    }
    [self.tableView reloadData];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return movieDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MovieListTVC *cell = [tableView dequeueReusableCellWithIdentifier:@"movieListTVC" forIndexPath:indexPath];
    NSDictionary *movieData = movieDataArray[indexPath.row];
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@", MOVIE_POSTER_PREFIX_URL, movieData[@"poster_path"]];
    [cell.moviePoster sd_setImageWithURL:[NSURL URLWithString:urlString]
                      placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    
    cell.movieTitle.text = movieData[@"original_title"];
    cell.movieDescription.text = movieData[@"overview"];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"showDetail" sender:nil];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return NO;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CGRect frame = tableView.frame;
    UIButton *filterButton = [[UIButton alloc] initWithFrame:CGRectMake(frame.size.width-100, 10, 95, 30)];
    [filterButton setTitle:@"Filter"
                  forState:UIControlStateNormal];
    [filterButton addTarget:self
                     action:@selector(filterButtonPressed)
           forControlEvents:UIControlEventTouchUpInside];
    filterButton.backgroundColor = [UIColor darkGrayColor];
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 50)];
    [headerView setBackgroundColor:[UIColor lightGrayColor]];
    [headerView addSubview:filterButton];
    return headerView;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger lastSectionIndex = [tableView numberOfSections] - 1;
    NSInteger lastRowIndex = [tableView numberOfRowsInSection:lastSectionIndex] - 1;
    if ((indexPath.section == lastSectionIndex) && (indexPath.row == lastRowIndex)) {
        // This is the last cell
        [self loadMoreMovies];
    }
}

- (void) loadMoreMovies
{
    countForPagination++;
    NSString *countString = [NSString stringWithFormat:@"%d", countForPagination];
    [movieManager fetchMovieList:countString];
}


#pragma mark - FilterButton
- (void) filterButtonPressed
{
    
}

@end
