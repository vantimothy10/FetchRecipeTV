### Screen Shots
#### Main Screen
<img src="https://github.com/user-attachments/assets/0a124301-9b2f-436f-a930-f87f460278e2" width="300" height="600">

#### Filter Active
<img src="https://github.com/user-attachments/assets/ca8f49e3-0305-497c-a00a-59236c0be21c" width="300" height="600">

### No Recipes/ Error State
<img src="https://github.com/user-attachments/assets/14a43b12-948e-4437-811d-ea1d296fdb0c" width="300" height="600">

### Steps to Run the App
1. Clone this repo to your local machine

2. Open FetchRecipeTV.xcodeproj in Xcode
3. Press Cmd + R to run the app.

### Focus Areas: What specific areas of the project did you prioritize? Why did you choose to focus on these areas?

I prioritized adding enhanced filtering options, such as filter chips, to improve usability. This implementation highlights my ability to design new views with well-structured APIs.

### Time Spent: Approximately how long did you spend working on this project? How did you allocate your time?

I spent roughly 6 hours on this project. Within the first hour I felt like I had the core MVP set of features. However the bulk of my time was spent creating a dual caching system since I thought in-memory caching would be better suited than disk-caching. In-memory caching alone achieves an optimal balance by reducing redundant API calls and mitigating stale data risks. I also spent additional time developing dependency injection patterns in order to create unit tests effective unit tests.

### Trade-offs and Decisions: Did you make any significant trade-offs in your approach?

I decided to invest time to develop patterns like dependency injection and more comprehensive caching. While these took extra time to implement, they improve code clarity and scalability. 

### Weakest Part of the Project: What do you think is the weakest part of your project?

The project’s weakest aspect is the design, as I typically work with design partners who provide specifications based on user research.

### External Code and Dependencies: Did you use any external code, libraries, or dependencies?

I intentionally chose not to include external dependencies, as the project requirements were achievable with native Swift APIs. Introducing additional dependencies was unnecessary and would have introduced a steeper learning curve and potential maintenance requirements.
