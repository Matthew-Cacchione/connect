import 'package:flutter/material.dart';

// Colors
const colorPrimary = Color(0xff0079d6);
const colorSecondary = Color(0xffffffff);

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
const passwordStrengthError = 'Password entered is too weak.';
const emailInUseError = 'An account with that email already exists.';
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
const tooManyInterests = 'Please select a maximum of 5 items.';
const interestsPrompt = 'What are your interests?';
const interestsLimitMessage = 'Please select up to 5 interests';
const submitBtn = 'Submit';

// Interests Set
const interestSet = {
  'Anime',
  'Astrology',
  'Beauty',
  'Board Games',
  'Books',
  'Card Games',
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
};

const interestMap = {
  'Entertainment': ['Anime', 'Books', 'Movies', 'Theatre', 'TV Series'],
  'Games': ['Board Games', 'Card Games', 'Tabletop Games', 'Video Games'],
  'Events': ['Concerts', 'Dance', 'Nightlife', 'Volunteering'],
  'Leisure': ['Cars & Motorcycle', 'Instruments', 'DIY Crafts', 'Food', 'Pets'],
  'Lifestyle': ['Astrology', 'Beauty', 'Fashion', 'Vegan'],
  'Wellness': ['Cooking', 'Fitness', 'Nature', 'Sports'],
  'Education': ['Finance', 'Fine Arts', 'Languages'],
};

final interestCategories = interestMap.keys.toList();

// Activity Set
const activitySet = {
  'Any',
  'Eat',
  'Study',
  'Workout',
  'In-Person Chat/ Outing',
  'Online Chat',
};
