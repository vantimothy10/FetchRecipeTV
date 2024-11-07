### Screen Shots
## Main Screen
<img src="[https://your-image-url.type](https://github.com/user-attachments/assets/0a124301-9b2f-436f-a930-f87f460278e2)" width="200" height="600">

![MainScreen]( | width=100)
## Filter Active
![FilterActive](https://github.com/user-attachments/assets/ca8f49e3-0305-497c-a00a-59236c0be21c | width=100)
## No Recipes/ Error State
![NoRecipeFound](https://github.com/user-attachments/assets/783123fb-1c10-401f-8a77-d040daa36ff3 | width=100)

### Steps to Run the App
1. Clone this repo to your local machine

2. Open FetchRecipeTV.xcodeproj in Xcode
3. Press Cmd + R to run the app.

### Focus Areas: What specific areas of the project did you prioritize? Why did you choose to focus on these areas?

I prioritized adding enhanced filtering options, such as filter chips, to improve usability. This implementation highlights my ability to design new views with well-structured APIs.

### Time Spent: Approximately how long did you spend working on this project? How did you allocate your time?

I dedicated approximately 6 hours to this project. The first hour was spent implementing the core MVP features. The majority of my time was then focused on creating a dual-caching system, as disk caching was an unusual requirement. Additionally, I spent time developing dependency injection patterns to facilitate effective unit testing.

### Trade-offs and Decisions: Did you make any significant trade-offs in your approach?

I spent roughly 6 hours on this project. Within the first hour I felt like I had the core MVP set of features. However the bulk of my time was spent creating a dual caching system since I thought in-memory caching would be better suited than disk-caching. In-memory caching alone achieves an optimal balance by reducing redundant API calls and mitigating stale data risks. I also spent additional time developing dependency injection patterns in order to create unit tests effective unit tests.

### Weakest Part of the Project: What do you think is the weakest part of your project?

The project’s weakest aspect is the design, as I typically work with design partners who provide specifications based on user research.

### External Code and Dependencies: Did you use any external code, libraries, or dependencies?

I intentionally chose not to include external dependencies, as the project requirements were achievable with native Swift APIs. Introducing additional dependencies was unnecessary and would have introduced a steeper learning curve and potential maintenance requirements.
