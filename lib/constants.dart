import 'package:flutter/material.dart';

// Colors
const colorPrimary = Color(0xff493843);
const colorSecondary = Color(0xff61988e);
const colorError = Color(0xffcc0000);

// Strings
const appName = 'Connect';
const emailHint = 'University Email';
const emptyError = 'Required';
const emailNotValid = 'Please enter a valid email';
const passwordHint = 'Password';
const forgotPassword = 'Forgot password?';
const loginBtn = 'Login';
const noAccountPrompt = 'Don\'t have an account? ';
const signUpPrompt = 'Sign Up';
const nameHint = 'First Name';
const confirmPasswordHint = 'Confirm Password';
const signOutBtn = 'Sign Out';
const passwordNotValid = 'Minimum 8 characters';
const nameNotValid = 'Minimum 3 characters';
const passwordMatchError = 'Passwords must match';
const userNotFound = 'No user found with that email address.';
const wrongPassword = 'Wrong password provided.';
const defaultError = 'Something went wrong.';
const weakPassword = 'Password entered is too weak.';
const emailAlreadyInUse = 'An account with that email already exists.';
const profileTitle = 'Profile';
const homeTitle = 'Home';
const chatTitle = 'Chat';
const verificationTitle = 'Verification';
const verificationMessage = 'A verification email has been sent. Click on the link provided to complete your registration.';
const verificationNotSent = 'Didn\'t receive an email?';
const frequentRequestError = 'You are doing that too much.';
const resendVerification = 'Another email has been sent, please check your spam folder.';
const signUpAgreement = 'By signing up, you agree to the Terms of Service and Privacy Policy, including cookie use.';
const noEmailEntered = 'Please enter an email.';
const passwordResetSent = 'Password reset email has been sent.';
const registrationTitle = 'Create Account';
const interestsTitle = 'Interests';
const interestsSubtitle = 'Please select your interests.';
const nextBtn = 'Next';
const noInterests = 'No interests selected';
const noInterestsPrompt = 'Are you sure you want to continue without picking any interests?';
const noTxt = 'No';
const yesTxt = 'Yes';
const birthdateTitle = 'Birthdate';
const birthdatePrompt = 'Please provide your birthdate.';
const permissionDenied = 'You don\'t have permission to do that';
const userDisabled = 'This user account has been disabled.';
const selectProfilePrompt = 'Select your profile picture';
const cameraTxt = 'Camera';
const galleryTxt = 'Gallery';
const profilePictureTitle = 'Profile Picture';
const noPictureSelected = 'Please select a profile picture before continuing.';
const chooseActivity = 'Choose an activity';
const promptTitle = 'Let others know what you want to do';
const freeUntilTitle = 'Until when are you free?';
const activitySelectionTitle = 'Select Activity';

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
final activitySet = ['Any', 'Eat', 'Study', 'Workout', 'Online Chat'];
