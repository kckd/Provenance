//
//  PVNESControllerViewController.m
//  Provenance
//
//  Created by James Addyman on 22/03/2015.
//  Copyright (c) 2015 James Addyman. All rights reserved.
//

#import "PVNESControllerViewController.h"
#import "PVNESEmulatorCore.h"

@interface PVNESControllerViewController ()

@end

@implementation PVNESControllerViewController

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    for (JSButton *button in [self.buttonGroup subviews])
    {
        if (![button isMemberOfClass:[JSButton class]])
        {
            continue;
        }
        
        if ([[[button titleLabel] text] isEqualToString:@"A"])
        {
            [button setTag:PVNESButtonA];
        }
        else if ([[[button titleLabel] text] isEqualToString:@"B"])
        {
            [button setTag:PVNESButtonB];
        }
    }
    
    [self.startButton setTag:PVNESButtonStart];
    [self.selectButton setTag:PVNESButtonSelect];
}

- (void)dPad:(JSDPad *)dPad didPressDirection:(JSDPadDirection)direction
{
    PVNESEmulatorCore *nesCore = (PVNESEmulatorCore *)self.emulatorCore;
    
    [nesCore releaseNESButton:PVNESButtonUp forPlayer:0];
    [nesCore releaseNESButton:PVNESButtonDown forPlayer:0];
    [nesCore releaseNESButton:PVNESButtonLeft forPlayer:0];
    [nesCore releaseNESButton:PVNESButtonRight forPlayer:0];
    
    switch (direction)
    {
        case JSDPadDirectionUpLeft:
            [nesCore pushNESButton:PVNESButtonUp forPlayer:0];
            [nesCore pushNESButton:PVNESButtonLeft forPlayer:0];
            break;
        case JSDPadDirectionUp:
            [nesCore pushNESButton:PVNESButtonUp forPlayer:0];
            break;
        case JSDPadDirectionUpRight:
            [nesCore pushNESButton:PVNESButtonUp forPlayer:0];
            [nesCore pushNESButton:PVNESButtonRight forPlayer:0];
            break;
        case JSDPadDirectionLeft:
            [nesCore pushNESButton:PVNESButtonLeft forPlayer:0];
            break;
        case JSDPadDirectionRight:
            [nesCore pushNESButton:PVNESButtonRight forPlayer:0];
            break;
        case JSDPadDirectionDownLeft:
            [nesCore pushNESButton:PVNESButtonDown forPlayer:0];
            [nesCore pushNESButton:PVNESButtonLeft forPlayer:0];
            break;
        case JSDPadDirectionDown:
            [nesCore pushNESButton:PVNESButtonDown forPlayer:0];
            break;
        case JSDPadDirectionDownRight:
            [nesCore pushNESButton:PVNESButtonDown forPlayer:0];
            [nesCore pushNESButton:PVNESButtonRight forPlayer:0];
            break;
        default:
            break;
    }
    
    [self vibrate];
}

- (void)dPadDidReleaseDirection:(JSDPad *)dPad
{
    PVNESEmulatorCore *nesCore = (PVNESEmulatorCore *)self.emulatorCore;
    
    [nesCore releaseNESButton:PVNESButtonUp forPlayer:0];
    [nesCore releaseNESButton:PVNESButtonDown forPlayer:0];
    [nesCore releaseNESButton:PVNESButtonLeft forPlayer:0];
    [nesCore releaseNESButton:PVNESButtonRight forPlayer:0];
}

- (void)buttonPressed:(JSButton *)button
{
    PVNESEmulatorCore *nesCore = (PVNESEmulatorCore *)self.emulatorCore;
    [nesCore pushNESButton:[button tag] forPlayer:0];
    
    [self vibrate];
}

- (void)buttonReleased:(JSButton *)button
{
    PVNESEmulatorCore *nesCore = (PVNESEmulatorCore *)self.emulatorCore;
    [nesCore releaseNESButton:[button tag] forPlayer:0];
}

- (void)controllerPressedButton:(PVControllerButton)button forPlayer:(NSInteger)player
{
    PVNESEmulatorCore *nesCore = (PVNESEmulatorCore *)self.emulatorCore;

    switch (button) {
        case PVControllerButtonA:
            [nesCore pushNESButton:PVNESButtonA forPlayer:player];
            break;
        case PVControllerButtonB:
            [nesCore pushNESButton:PVNESButtonB forPlayer:player];
            break;
        case PVControllerButtonX:
        case PVControllerButtonLeftShoulder:
        case PVControllerButtonLeftTrigger:
            [nesCore pushNESButton:PVNESButtonStart forPlayer:player];
            break;
        case PVControllerButtonY:
        case PVControllerButtonRightShoulder:
        case PVControllerButtonRightTrigger:
            [nesCore pushNESButton:PVNESButtonSelect forPlayer:player];
            break;
        default:
            break;
    }
}

- (void)controllerReleasedButton:(PVControllerButton)button forPlayer:(NSInteger)player
{
    PVNESEmulatorCore *nesCore = (PVNESEmulatorCore *)self.emulatorCore;
    
    switch (button) {
        case PVControllerButtonA:
            [nesCore releaseNESButton:PVNESButtonA forPlayer:player];
            break;
        case PVControllerButtonB:
            [nesCore releaseNESButton:PVNESButtonB forPlayer:player];
            break;
        case PVControllerButtonX:
        case PVControllerButtonLeftShoulder:
        case PVControllerButtonLeftTrigger:
            [nesCore releaseNESButton:PVNESButtonStart forPlayer:player];
            break;
        case PVControllerButtonY:
        case PVControllerButtonRightShoulder:
        case PVControllerButtonRightTrigger:
            [nesCore releaseNESButton:PVNESButtonSelect forPlayer:player];
            break;
        default:
            break;
    }
}

- (void)controllerPressedDirection:(GCControllerDirectionPad *)dpad forPlayer:(NSInteger)player
{
    PVNESEmulatorCore *nesCore = (PVNESEmulatorCore *)self.emulatorCore;
    
    [nesCore releaseNESButton:PVNESButtonUp forPlayer:player];
    [nesCore releaseNESButton:PVNESButtonDown forPlayer:player];
    [nesCore releaseNESButton:PVNESButtonLeft forPlayer:player];
    [nesCore releaseNESButton:PVNESButtonRight forPlayer:player];
    
    if ([[dpad xAxis] value] > 0)
    {
        [nesCore pushNESButton:PVNESButtonRight forPlayer:player];
    }
    if ([[dpad xAxis] value] < 0)
    {
        [nesCore pushNESButton:PVNESButtonLeft forPlayer:player];
    }
    if ([[dpad yAxis] value] > 0)
    {
        [nesCore pushNESButton:PVNESButtonUp forPlayer:player];
    }
    if ([[dpad yAxis] value] < 0)
    {
        [nesCore pushNESButton:PVNESButtonDown forPlayer:player];
    }
}

- (void)controllerReleasedDirection:(GCControllerDirectionPad *)dpad forPlayer:(NSInteger)player
{
    PVNESEmulatorCore *nesCore = (PVNESEmulatorCore *)self.emulatorCore;
    
    [nesCore releaseNESButton:PVNESButtonUp forPlayer:player];
    [nesCore releaseNESButton:PVNESButtonDown forPlayer:player];
    [nesCore releaseNESButton:PVNESButtonLeft forPlayer:player];
    [nesCore releaseNESButton:PVNESButtonRight forPlayer:player];
}

@end
