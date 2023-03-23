# TBD App

## 3/10 Project Overview:

### App Overview:
Fashion App assistant that makes mornings easier and digitizes your laundry pile. On this app, you can upload photos of your clothing and swipe through your closet to select a top, bottom and shoes pairing for the day by exploring the “clean” clothing items in your closet. The app will further remind you to do laundry when your virtual “dirty” clothes bin is full. For rarely worn items of clothing, the app will recommend local donation centers to pass on the clothing. The app will also be capable of recommending clothes to wear in the form of outfits. These outfits will be based on user preferences and weather data, with potential to integrate even more parameters into clothing recommendations.

### API technologies being used:
Weather API (to help with deciding daily outfits)
Maps API (for finding the closest donation center)

### Sources of Complexity/Difficulty:
Updating the recommended clothing items based on changes in weather (i.e. temperature, expected forecast, etc.)
Storage & organization issues -- user uploading photos 
Recommending clothing items based on an intelligent recommender rather than randomly generating (could take way too long to generate ideal outfit selections)
Custom API calls to database and designing said database
Fitting all the commands and features into aesthetic UI


### App Details:
myCloset = [clothingItem]
Datastore holds clothingItems

clothingItem
Required
Unique identifier
Image (person uploads this image)
Label (top (t-shirt, sweater, long sleeve), bottom (pants, shorts, skirts) )
Boolean clean/dirty (default clean)
The last time it was worn (default to when clothing was uploaded into the app)
- Optionals
Temperature range 
Pairing restrictions (only pair X with skirts, only pair Y with long-sleeve tops, etc) (default no restrictions)
Number of uses before wash (default 1)
Number of times used (this is only applicable for clothes that are worn more than once)
Marked as ‘dirty’ when number of times used == number of times before washed
Computed property
Eligible for donation?
If the last time it was worn > 30 days ago AND it was something that was able to be worn for the temperature ranges of the previous month >70% of the time, mark as eligible

dailyView
Daily temperature range at the top
Two swiping features in a vertical stack
On load of the view, an outfit that was pre-picked from a calendar view is the one that shows up
If no outfit was pre-picked from a calendar view, the first top and bottom in the closet shows up
Swipe between tops, swipe between bottoms
Generate a random outfit
Only can choose from clean clothes, is done within the bounds of pairing restrictions and temperature ranges
Can generate as many times as you want; have the option to ‘lock’ a top/bottom if you like it, and only generate random corresponding bottom/top
Reset outfit
If outfit was pre-picked from a calendar view
If any changes are made, and the user clicks ‘reset,’ it resets back to this pre-picked outfit
If no outfit was pre-picked from a calendar view
Clicking reset just goes to the first top and first bottoms item
Button to say ‘I wore this’
Have a confirmation screen show up; we want this to be intentional
Marks the clothing items in the outfit as ‘dirty’ (or, if there are more than one uses before washing, marks it as used one time)
Button to say ‘I’ve done my laundry’
Again have a confirmation screen show up
Any clothing items that have been marked as dirty become clean
For the clothes that can be worn more than once:
If the clothes have been worn before, but not the max number of times until they’re dirty, have a pop up to ask the user if they washed it or not
Button to add clothing item
Prompts user to take a picture
Takes user to form to have them fill out label, temp range, pairing restrictions, number of uses

weeklyView
7 day calendar view
Can click on any day
See the daily temperature range at the top
Swipe through or generate a random outfit
‘Lock’ outfit
Button to generate a random week of outfits
Does not overwrite any days you have locked
If an updated temperature range occurs that will change an outfit
Warning sign showing up over that day – “the temperature has changed. Would you like to re-generate your outfit?”
If the clothing item that was scheduled to be worn later in the week was chosen days before:
Warning sign showing up over that day – “this item is dirty. Would you like to re-generate an outfit?”

donationView
Show the clothes that are eligible for donation
Map view of nearest donation places to you
Button ‘mark as donated’ - removes the clothingItem from the closet

## Jon Approval 3/17/23
* Nicely done, good luck!
* I appreciate the detailed thought to date.

## Getting started

To make it easy for you to get started with GitLab, here's a list of recommended next steps.

Already a pro? Just edit this README.md and make it your own. Want to make it easy? [Use the template at the bottom](#editing-this-readme)!

## Add your files

- [ ] [Create](https://docs.gitlab.com/ee/user/project/repository/web_editor.html#create-a-file) or [upload](https://docs.gitlab.com/ee/user/project/repository/web_editor.html#upload-a-file) files
- [ ] [Add files using the command line](https://docs.gitlab.com/ee/gitlab-basics/add-file.html#add-a-file-using-the-command-line) or push an existing Git repository with the following command:

```
cd existing_repo
git remote add origin https://gitlab.oit.duke.edu/tim-cookies/tbd-app.git
git branch -M main
git push -uf origin main
```

## Integrate with your tools

- [ ] [Set up project integrations](https://gitlab.oit.duke.edu/tim-cookies/tbd-app/-/settings/integrations)

## Collaborate with your team

- [ ] [Invite team members and collaborators](https://docs.gitlab.com/ee/user/project/members/)
- [ ] [Create a new merge request](https://docs.gitlab.com/ee/user/project/merge_requests/creating_merge_requests.html)
- [ ] [Automatically close issues from merge requests](https://docs.gitlab.com/ee/user/project/issues/managing_issues.html#closing-issues-automatically)
- [ ] [Enable merge request approvals](https://docs.gitlab.com/ee/user/project/merge_requests/approvals/)
- [ ] [Automatically merge when pipeline succeeds](https://docs.gitlab.com/ee/user/project/merge_requests/merge_when_pipeline_succeeds.html)

## Test and Deploy

Use the built-in continuous integration in GitLab.

- [ ] [Get started with GitLab CI/CD](https://docs.gitlab.com/ee/ci/quick_start/index.html)
- [ ] [Analyze your code for known vulnerabilities with Static Application Security Testing(SAST)](https://docs.gitlab.com/ee/user/application_security/sast/)
- [ ] [Deploy to Kubernetes, Amazon EC2, or Amazon ECS using Auto Deploy](https://docs.gitlab.com/ee/topics/autodevops/requirements.html)
- [ ] [Use pull-based deployments for improved Kubernetes management](https://docs.gitlab.com/ee/user/clusters/agent/)
- [ ] [Set up protected environments](https://docs.gitlab.com/ee/ci/environments/protected_environments.html)

***
