import 'package:flutter/material.dart';

class QuestionMap {
  static final List chooseDas = [
    "Did not apply to me at all.",
    "Applied to me to some degree, or some of the time.",
    "Applied to me to a considerable degree, or a good part of time.",
    "Applied to me very much, or most of the time."
  ];
  static final List chooseTipi = [
    "Disagree strongly.",
    "Disagree moderately.",
    "Disagree a little.",
    "Neither agree nor disagree.",
    "Agree a little.",
    "Agree moderately.",
    "Agree strongly.",
  ];

  static final List options = [
    {
      'cat': "Education Level",
      "options": [
        'Less than high school',
        'High school',
        'University degree',
        'Graduate degree',
      ]
    },
    {
      'cat': "Locality",
      "options": [
        'Rural (country side)',
        'Suburban',
        'Urban (town, city)',
      ]
    },
    {
      'cat': "Gender",
      "options": [
        'Male',
        'Female',
        'Other',
      ]
    },
    {
      'cat': "Religion",
      "options": [
        'Agnostic',
        'Atheist',
        'Buddhist',
        'Christian (Catholic)',
        'Christian (Mormon)',
        'Christian (Protestant)',
        'Christian (Other)',
        'Hindu',
        'Jewish',
        'Muslim',
        'Sikh',
        'Other',
      ]
    },
    {
      'cat': "Race",
      "options": [
        'Asian',
        'Arab',
        'Black',
        'Indigenous Australian',
        'Native American',
        'White',
        'Other',
      ]
    },
    {
      'cat': "Marriage Status",
      "options": ['Never married', 'Currently married', 'Previously married']
    },
    {
      'cat': "Family Size",
      "options": [""]
    },
    {
      'cat': "Age",
      "options": [
        'Less than 11',
        'Less than 17',
        'Less than  21',
        'Less than 35',
        'Less than  48',
        'Greater than 49'
      ]
    },
  ];

   
}
