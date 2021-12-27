import 'package:flutter/material.dart';

// Colors
const colorPrimary = Color(0xff0079d6);
const colorSecondary = Color(0xffffffff);

// Strings
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

// Interests Set
const interestSet = {'Anime', 'Astrology', 'Beauty', 'Board Games', 'Books',
  'Card Games', 'Cars & Motorcycle', 'Concerts', 'Cooking', 'Dance', 'DIY Crafts',
  'Fashion', 'Finance', 'Fine Arts', 'Fitness', 'Food', 'Instruments', 'Languages',
  'Movies', 'Nature', 'Nightlife', 'Pets', 'Sports', 'Tabletop Games', 'Theatre',
  'TV Series', 'Vegan', 'Video Games', 'Volunteering'};

const interestMap = {
  'Entertainment': ['Anime', 'Books', 'Movies', 'Theatre' 'TV Series'],
  'Games': ['Board Games', 'Card Games', 'Tabletop Games', 'Video Games'],
  'Events': ['Concerts', 'Dance', 'Nightlife', 'Volunteering'],
  'Leisure': ['Cars & Motorcycle', 'Instruments', 'DIY Crafts', 'Food', 'Pets'],
  'Lifestyle': ['Astrology', 'Beauty', 'Fashion', 'Vegan'],
  'Wellness': ['Cooking', 'Fitness', 'Food', 'Nature', 'Sports'],
  'Education': ['Finance', 'Fine Arts', 'Languages']
};

final interestCategories = interestMap.keys.toList();

// Activity Set
const activitySet = {'Any', 'Eat', 'Study', 'Workout', 'In-Person Chat/ Outing', 'Online Chat'};