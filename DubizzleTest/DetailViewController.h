//
//  DetailViewController.h
//  DubizzleTest
//
//  Created by Riddhi Ojha on 12/21/16.
//
//

#import <UIKit/UIKit.h>
#import "MovieListManager.h"

@interface DetailViewController : UIViewController<MovieListManagerDelegate>
{
    MovieListManager *movieManager;
}

@property (strong, nonatomic) NSString *movieID;
@property (weak, nonatomic) IBOutlet UIImageView *posterImageView;
@property (weak, nonatomic) IBOutlet UILabel *movieTitle;
@property (weak, nonatomic) IBOutlet UILabel *releaseDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *genreLabel;
@property (weak, nonatomic) IBOutlet UILabel *runtimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;
@property (weak, nonatomic) IBOutlet UITextView *movieDescriptionTextView;


@end

