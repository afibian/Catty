/**
 *  Copyright (C) 2010-2013 The Catrobat Team
 *  (http://developer.catrobat.org/credits)
 *
 *  This program is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU Affero General Public License as
 *  published by the Free Software Foundation, either version 3 of the
 *  License, or (at your option) any later version.
 *
 *  An additional term exception under section 7 of the GNU Affero
 *  General Public License, version 3, is available at
 *  (http://developer.catrobat.org/license_additional_term)
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 *  GNU Affero General Public License for more details.
 *
 *  You should have received a copy of the GNU Affero General Public License
 *  along with this program.  If not, see http://www.gnu.org/licenses/.
 */

#import "AppDelegate.h"
#import "FileManager.h"
#import "Util.h"
#import "UIColor+CatrobatUIColorExtensions.h"

void uncaughtExceptionHandler(NSException *exception)
{
    NSError(@"uncaught exception: %@", exception.description);
}

@implementation AppDelegate

- (FileManager*)fileManager
{
    if (_fileManager == nil)
        _fileManager = [[FileManager alloc] init];
    return _fileManager;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{    
    NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);

    [self initNavigationBar];

    [[UITextField appearance] setKeyboardAppearance:UIKeyboardAppearanceDark];

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *appDefaults = [NSDictionary dictionaryWithObject:@"YES"
                                                            forKey:@"lockiphone"];
    [defaults registerDefaults:appDefaults];
    [defaults synchronize];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];

    // if there is no sounds directory in Documents directory, then automatically create one
    // needed for iTunes File Sharing
    if (! [self.fileManager directoryExists:self.fileManager.iTunesSoundsDirectory]) {
        [self.fileManager createDirectory:self.fileManager.iTunesSoundsDirectory];

        //make a file name to write the data to using the documents directory:
        NSString *fileName = [NSString stringWithFormat:@"%@/textfile.txt", self.fileManager.iTunesSoundsDirectory];
        //create content - four lines of text
        NSString *content = @"One\nTwo\nThree\nFour\nFive";
        //save content to the documents directory
        [content writeToFile:fileName
                  atomically:NO
                    encoding:NSStringEncodingConversionAllowLossy
                       error:nil];
    }
    return YES;
}

- (void)initNavigationBar
{
    UIImage *navbarimage = [[UIImage imageNamed:@"darkblue"]
                            resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];

    [[UINavigationBar appearance] setBackgroundImage:navbarimage
                                       forBarMetrics:UIBarMetricsDefault];

    self.window.tintColor = [UIColor lightOrangeColor];

    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                          [UIColor skyBlueColor],
                                                          NSForegroundColorAttributeName, nil]];
}

@end
