WCAlertView
==========

## How To Use

You can use couple predefined styles, or write you own styles.
WCAlertView support blocks.

``` objective-c
[WCAlertView showAlertWithTitle:@"Custom AlertView Title" message:@"You can do a lot of additional setup using WCAlertView. You can do a lot of additional setup using WCAlertView" customizationBlock:^(WCAlertView *alertView) {
        alertView.style = WCAlertViewStyleVioletHatched;
    } completionBlock:^(NSUInteger buttonIndex, WCAlertView *alertView) {
        
    } cancelButtonTitle:@"Cancel" otherButtonTitles:@"Okay",nil];
```

This also works:
``` objective-c
WCAlertView *alert = [[WCAlertView alloc] initWithTitle:@"Custom AlertView Title" message:@"You can do a lot of additional setup using WCAlertView. You can do a lot of additional setup using WCAlertView" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:@"Okay", nil];
    alert.style = WCAlertViewStyleVioletHatched;
    
    [alert show];
```


You can set default appearance for all alert views:

``` objective-c
[WCAlertView setDefaultStyle:WCAlertViewStyleWhite];
```


## Credits

Inspired by [Aaron Crabtree -  UIAlertView Custom Graphics](http://mobile.tutsplus.com) , borrowing some general approaches in drawing Alert View.
Simple block extension got from [wannabegeek](http://github.com/wannabegeek/UIAlertViewExtentsions).

## Contact

[Michal Zaborowski](http://github.com/m1entus) 
