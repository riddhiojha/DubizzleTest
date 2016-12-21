//
//  FilterViewController.m
//  DubizzleTest
//
//  Created by Riddhi Ojha on 12/21/16.
//
//

#import "FilterViewController.h"

@interface FilterViewController ()

@end

@implementation FilterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/




- (IBAction)cancelPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)filterPressed:(id)sender {
    if ([self checkDateValidation]) {
        NSDictionary *filterDictionary = [NSDictionary dictionaryWithObjectsAndKeys:self.minTF.text,@"min",
                                          self.maxTF.text, @"max", nil];
        [self dismissViewControllerAnimated:YES completion:nil];
        if (self.delegate && [self.delegate respondsToSelector:@selector(maxMinDateSelected:)]) {
            [self.delegate maxMinDateSelected:filterDictionary];
        }
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Maximum date should be greater than minimum date." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
    
}

- (IBAction)pickerValueChanged:(id)sender {
    NSDate *myDate = self.datePicker.date;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [dateFormat stringFromDate:myDate];
    currentTextField.text = dateString;
}

- (IBAction)doneSelectingDate:(id)sender {
    NSDate *myDate = self.datePicker.date;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [dateFormat stringFromDate:myDate];
    currentTextField.text = dateString;
    self.pickerView.hidden = YES;
}


-(void)textFieldDidBeginEditing:(UITextField *)sender
{
    currentTextField = sender;
    self.pickerView.hidden = NO;
}


#pragma mark - check min nad max date validation

- (BOOL) checkDateValidation
{
    NSDateFormatter *datePickerFormat = [[NSDateFormatter alloc] init];
    [datePickerFormat setDateFormat:@"yyyy-MM-dd"];
    NSDate *currentDate = [datePickerFormat dateFromString:self.minTF.text];
    NSDate *serverDate = [datePickerFormat dateFromString:self.maxTF.text];
    NSComparisonResult result;
    result = [currentDate compare:serverDate];
    if(result == NSOrderedAscending)
    {
        NSLog(@"current date is less");
        return YES;
    }
    else if(result == NSOrderedDescending)
    {
        NSLog(@"server date is less");
        return NO;
    }
    else if(result == NSOrderedSame)
    {
        NSLog(@"Both dates are same");
        return NO;
    }
    else if(!self.maxTF.text || !self.minTF.text)
        return NO;
    return NO;
}
@end
