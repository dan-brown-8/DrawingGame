**README:**

**How it Works**
- Register an account or log in.
- View the public list of drawings. If you select a drawing you will be presented additional detail about that drawing.
If the drawing you have chosen is owned by you, you will have the option to delete it.
- If you click on the pencil icon at the top right of the screen (on the navigation bar) you will be able to create your own drawing. 

![alt text](http://url/to/DrawingGameImages/Screen Shot 2020-08-21 at 2.39.36 PM.png)

- Click on the text fields above the piece of paper to customize the color, utensil, and brush width.

![alt text](http://url/to/DrawingGameImages/Screen Shot 2020-08-21 at 2.39.45 PM.png)


**Architecture:**
- I used MVC since that is what I am most experienced with and considering the time restriction it made the most sense. 
- I made an effort to separate reusable classes/functions from the ViewController whenever possible to try and avoid the common “Massive View Controller” issue.
- Folder structure: 1. Model (data models and calls to the database) 2. Tools (Formatting, common UI functions, etc) 3. Storybaards 4. Controllers 5. Views 


**If I had more time or if this were for production:**
- Write automated tests.
- Add security rules in Firebase.
- Test using a physical device rather than the simulators.
- Create an easier way for users to delete their own drawings.
- I would’ve attempted to move a few other functions out of the view controller such as the createPickers function.
- I would’ve added size classes for iPad screen sizes and possibly the iPhone 7 screen size. The app currently works on those devices but it’s not optimal.
- To store the drawing photos I create a random 15 character string as an ID and then store it to FirebaseStorage and Firestore as the same ID. 
If this were production id want to make sure that 15 character string is never duplicated.
- Fix the minor bug where the drawing thumbnail photo isn’t always the exact same size when you upload drawings on different devices.
- There is a specific bug that I found where if you create a new drawing, delete a drawing, then switch to a different simulator the app will crash 
or will not display one of the drawing photos. For production I am confident I’d fix the bug but for this project I simply ran out of time.
- Would’ve made a few things slightly more efficient with extra time. An example of this is it’s not very efficient to compare Strings using if statements, 
so I’d alter that and use structs to attach a number value to that string and then compare them that way.
- A sign out option.

**Other Ideas:**
- Allow users to ‘like’ or ‘comment’ on drawings.
- Add more statistics for the user’s profile ‘numOfDrawings', 'totalTimeSpentDrawing’.
- Create a customizable profile for each user.
- Admin option with more power/control.
- Ability to sign in using either email or username.

**Features I decided to leave out:**
- I wasn’t able to find a way to successfully test screen recording on the simulator while also saving the video recording. I was planning on having the 
video be displayed in the DrawingDetailsVC, but for now a picture of the drawing has been used as a placeholder. Some options I would look into if this were 
for production would be SGASScreenRecorder, AVFoundation, ReplayKit, and AVPlayer. 

**Issues I Ran Into:**
- Trying to figure out the most efficient way to utilize a Firebase listener to handle new photos being loaded in in real time or photos being removed in real time. 
I ended up wiping my local drawing data completely upon changes and loading in an entirely new dataset, which may or may not have been the most efficient way to do 
it when you consider some of the limitations that come with Firebase. 

**My Biggest Mistake:**
- Spending a ton of time trying to find a way to screen record and save the file without using a physical device. If I were to do this over again I’d give 
myself a strict time limit so I have more time to test and refine my already existing code. I think I focused too much on completing all of the features.


**DATABASE STRUCTURE**

Firebase Auth: Email & Password

Firestore: 
users -> userDocuments -> emailAddress, username
drawings -> drawingDocuments -> artist, displayName, dateCreated, timeSpent, videoReference

Storage:
photos -> photoFiles


Icons by https://icons8.com 
