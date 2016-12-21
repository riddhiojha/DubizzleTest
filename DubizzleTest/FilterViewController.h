//
//  FilterViewController.h
//  DubizzleTest
//
//  Created by Riddhi Ojha on 12/21/16.
//
//

#import <UIKit/UIKit.h>

@protocol FilterViewDelegate <NSObject>
@optional
- (void) maxMinDateSelected : (NSDictionary *)dateDictionary;
@end

@interface FilterViewController : UIViewController<UIPickerViewDelegate>
{
    UITextField *currentTextField;
}
@property (nonatomic, assign) id<FilterViewDelegate> delegate;
@property (weak, nonatomic) IBOutlet UITextField *minTF;
@property (weak, nonatomic) IBOutlet UITextField *maxTF;
@property (weak, nonatomic) IBOutlet UIView *pickerView;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

- (IBAction)cancelPressed:(id)sender;
- (IBAction)filterPressed:(id)sender;
- (IBAction)pickerValueChanged:(id)sender;
- (IBAction)doneSelectingDate:(id)sender;
@end

