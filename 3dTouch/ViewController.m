//
//  ViewController.m
//  3dTouch
//
//  Created by Dmitriy Zakharov on 2015-10-08.
//

#import "ViewController.h"
#import "PreviewViewController.h"

@interface ViewController () <UIViewControllerPreviewingDelegate>

@property (weak, nonatomic) IBOutlet UILabel *touchForceLabel;
@property (weak, nonatomic) IBOutlet UIButton *peekPopButton;
@property (weak, nonatomic) IBOutlet UIButton *peekCanada;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:nil];
    tapGestureRecognizer.delegate = self;
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
    if (self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable) {
        [self registerForPreviewingWithDelegate:(id)self sourceView:self.view];
        NSLog(@"3D Touch is available!");
    }
}




// If you return nil, a preview presentation will not be performed
- (nullable UIViewController *)previewingContext:(id <UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location NS_AVAILABLE_IOS(9_0);
{
    CGPoint convertedLocation = [self.view convertPoint:location toView:self.peekPopButton];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    
    if (CGRectContainsPoint(self.peekPopButton.bounds, convertedLocation)) {
        // Point lies inside the bounds.
        return [storyboard instantiateViewControllerWithIdentifier:@"detailsPreview"];
    }
    
    convertedLocation = [self.view convertPoint:location toView:self.peekCanada];
    if (CGRectContainsPoint(self.peekCanada.bounds, convertedLocation)) {
        return [storyboard instantiateViewControllerWithIdentifier:@"canadaView"];
    }
    return nil;
}

- (void)previewingContext:(id <UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit NS_AVAILABLE_IOS(9_0)
{
    //perfom actions here
    
    [self.navigationController pushViewController:viewControllerToCommit animated:YES];
    NSLog(@"Peek");
}

- (void)checkTouchStatus:(UITouch *)touch {
    
    if (self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable) {

        NSLog(@"touch.force %f/%f", touch.maximumPossibleForce, touch.force);
        self.touchForceLabel.text = [NSString stringWithFormat:@"%.02f", touch.force];
        
        float maxTouchForce = 3.2;
        float percentFromMax = touch.force / maxTouchForce  * 100;
        
        if (percentFromMax <= 25) {
            self.view.backgroundColor = [UIColor whiteColor];
        }
        else if (percentFromMax <= 50) {
            self.view.backgroundColor = [UIColor greenColor];
        }
        else if (percentFromMax <= 75) {
            self.view.backgroundColor = [UIColor blueColor];
        }
        else if (percentFromMax <= 100) {
            self.view.backgroundColor = [UIColor redColor];
        }
    }
}

#pragma mark - Responders

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self handleTouches:touches withEvent:event];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self handleTouches:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)handleTouches:(NSSet *)touches withEvent:(UIEvent *)event {
    
    if (event.type == UIEventTypeTouches) {
        
        // for each touch update the label
        for (UITouch *currentTouch in touches) {
            [self checkTouchStatus:currentTouch];
        }
    }
}

@end
