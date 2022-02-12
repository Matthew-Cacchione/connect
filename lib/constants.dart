import 'package:flutter/material.dart';

// Colors
const colorPrimary = Color(0xff0067db);
const colorSecondary = Color(0xff86cd82);
const colorError = Color(0xffcc0000);

// Strings
const activitySelectionTitle = "Select Activity";
const appName = "Connect";
const birthdatePrompt = "Please provide your birthdate.";
const birthdateTitle = "Birthdate";
const cameraTxt = "Camera";
const chatTitle = "Chat";
const chooseActivity = "Choose an activity";
const confirmPasswordHint = "Confirm Password";
const defaultError = "Something went wrong.";
const emailAlreadyInUse = "An account with that email already exists.";
const emailHint = "University Email";
const emailNotValid = "Please enter a valid email";
const emptyError = "Required";
const forgotPassword = "Forgot password?";
const freeUntilTitle = "Until when are you free?";
const frequentRequestError = "You are doing that too much.";
const galleryTxt = "Gallery";
const haveAccountPrompt = "Already have an account? ";
const homeTitle = "Home";
const interestsSubtitle = "Please select your interests.";
const interestsTitle = "Interests";
const loginBtn = "Login";
const nameHint = "First Name";
const nameNotValid = "Minimum 3 characters";
const nextBtn = "Next";
const noAccountPrompt = "Don't have an account? ";
const noEmailEntered = "Please enter an email.";
const noInterests = "No interests selected";
const noInterestsPrompt = "Are you sure you want to continue without picking any interests?";
const noPictureSelected = "Please select a profile picture before continuing.";
const noTxt = "No";
const passwordHint = "Password";
const passwordMatchError = "Passwords must match";
const passwordNotValid = "Minimum 8 characters";
const passwordResetSent = "Password reset email has been sent.";
const permissionDenied = "You don't have permission to do that";
const profilePictureTitle = "Profile Picture";
const profileTitle = "Profile";
const promptTitle = "Let others know what you want to do";
const registrationTitle = "Create Account";
const resendVerification = "Another email has been sent, please check your spam folder.";
const selectPicturePrompt = "Select your profile picture";
const signOutBtn = "Sign Out";
const signUpAgreement = "By signing up, you agree to the Terms of Service and Privacy Policy, including cookie use.";
const signUpPrompt = "Sign Up";
const userDisabled = "This user account has been disabled.";
const userNotFound = "No user found with that email address.";
const verificationMessage =
    "A verification email has been sent. Click on the link provided to complete your registration.\n\nIf you don't see it you may need to check your spam folder.\n\nStill didn't receive an email?";
const verificationNotSent = "Resend email";
const verificationTitle = "Please verify your email";
const weakPassword = "Password entered is too weak.";
const wrongPassword = "Wrong password provided.";
const yesTxt = "Yes";

// Interests
final interestSet = [
  'Anime',
  'Astrology',
  'Beauty',
  'Board Games',
  'Books' 'Card Games',
  'Cars & Motorcycle',
  'Concerts',
  'Cooking',
  'Dance',
  'DIY Crafts',
  'Fashion',
  'Finance',
  'Fine Arts',
  'Fitness',
  'Food',
  'Instruments',
  'Languages',
  'Movies',
  'Nature',
  'Nightlife',
  'Pets',
  'Sports',
  'Tabletop Games',
  'Theatre',
  'TV Series',
  'Vegan',
  'Video Games',
  'Volunteering',
];

final interestMap = {
  'Entertainment': ['Anime', 'Books', 'Movies', 'Theatre', 'TV Series'],
  'Games': ['Board Games', 'Card Games', 'Tabletop Games', 'Video Games'],
  'Events': ['Concerts', 'Dance', 'Nightlife', 'Volunteering'],
  'Leisure': ['Cars & Motorcycle', 'Instruments', 'DIY Crafts', 'Food', 'Pets'],
  'Lifestyle': ['Astrology', 'Beauty', 'Fashion', 'Vegan'],
  'Wellness': ['Cooking', 'Fitness', 'Nature', 'Sports'],
  'Education': ['Finance', 'Fine Arts', 'Languages'],
};

final interestCategories = interestMap.keys.toList();

// Activities
final activitySet = ['Coffee', 'Eat', 'Study', 'Exercise', 'Other', 'Any'];

final activityIcons = [
  'assets/images/default_activity.png',
  'assets/images/default_activity.png',
  'assets/images/default_activity.png',
  'assets/images/default_activity.png',
  'assets/images/default_activity.png',
  'assets/images/default_activity.png',
];
