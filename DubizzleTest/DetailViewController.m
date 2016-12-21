
//
//  DetailViewController.m
//  DubizzleTest
//
//  Created by Riddhi Ojha on 12/21/16.
//
//

#import "DetailViewController.h"

#define MOVIE_POSTER_PREFIX_URL @"https://image.tmdb.org/t/p/w1280"
#define RELEASE_DATE @"Release Date : "
#define GENRE @"Genre : "

@interface DetailViewController ()

@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setMovieID:(NSString *)movieID {
    if (_movieID != movieID) {
        _movieID = movieID;
        // Update the view.
        [self configureView];
    }
}

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.movieID) {
        movieManager = [[MovieListManager alloc] init];
        movieManager.delegate = self;
        [movieManager fetchMovieDetails:self.movieID];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Movie manager delegate methods
- (void) movieListManagerCallback : (NSDictionary *) responseDictionary
{
    NSDictionary *dataDictionary = responseDictionary[@"response"];
    NSArray *genreArray = dataDictionary[@"genres"];
    NSString *releaseDateLabelText = [NSString stringWithFormat:@"%@%@", RELEASE_DATE, dataDictionary[@"release_date"]];
    NSString *genreLabelText = [NSString stringWithFormat:@"%@%@", GENRE, [genreArray componentsJoinedByString:@","]];
    NSString *runtimeLabelText = [NSString stringWithFormat:@"%@ mins", dataDictionary[@"runtime"]];
    NSString *ratingLabelText = [NSString stringWithFormat:@"* %@", dataDictionary[@"vote_average"]];
    NSString *urlString = [NSString stringWithFormat:@"%@%@",MOVIE_POSTER_PREFIX_URL, dataDictionary[@"poster_path"]];
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
    self.posterImageView.image = [UIImage imageWithData:imageData];
    self.movieTitle.text = dataDictionary[@"title"];
    self.releaseDateLabel.text = releaseDateLabelText;
    self.genreLabel.text = genreLabelText;
    self.ratingLabel.text = ratingLabelText;
    self.runtimeLabel.text = runtimeLabelText;
    self.movieDescriptionTextView.text = dataDictionary[@"overview"];
}


@end
