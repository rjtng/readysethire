// models/aptitude_test_data.dart

import 'package:flutter/material.dart';

// --- Data Models ---

// This is the model required for the Situational Judgement Questions.
class Question {
  final String questionText;
  final String? scenarioDescription;
  final List<String> options;
  final int correctOptionIndex;
  final String explanation;
  final String? category; // made optional to match your data
  final List<int>? optionPoints; // optional per-option scoring (e.g., [3,2,1,0])

  Question({
    required this.questionText,
    this.scenarioDescription,
    required this.options,
    required this.correctOptionIndex,
    required this.explanation,
    this.category, // optional named parameter
    this.optionPoints,
  });
}

// --- Other models (from your original file) ---

class Content {
  final String title;
  final String text;

  Content({required this.title, required this.text});
}

class Guide {
  final IconData icon;
  final String title;
  final String subtitle;
  final List<Content> content;

  Guide({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.content,
  });
}

class Flashcard {
  final String question;
  final String explanation;
  final String exampleAnswer;

  Flashcard({
    required this.question,
    required this.explanation,
    required this.exampleAnswer,
  });
}

// --- Main Data Class ---

class AptitudeTestData {
  // ... (interviewFlashcards list remains the same)
  static List<Flashcard> interviewFlashcards = [
    Flashcard(
      question: 'Describe a project you worked on.',
      explanation:
      'In this question, the interviewer is asking for details about a specific project you have worked on to gain insights about your project experience, your approach to problem-solving, your teamwork and collaboration skills, and how you handle challenges and setbacks. This is your opportunity to showcase a project that makes you proud, or one where you made a significant contribution.\n\nWhen answering this question:\nChoose a project that is relevant to the job role you are applying for.\nDescribe the project briefly. What was the goal/end result?\nExplain your role in the project.\nDiscuss the methods or steps you took to execute this project. This will help show your problem-solving skills.\nTalk about the outcome. Did it meet its objectives? What was your learning from it?\nHighlight any challenges or roadblocks you encountered, and how you overcame them.\n\nAlways remember, the goal is to portray not just what you did, but how you did it, and its impact.',
      exampleAnswer:
      'In my previous job as a software developer, one of the projects I am most proud of is the development of a company-wide, real-time reporting system. The purpose of this project was to improve the efficiency and quality of management reports.\n\nI served as the lead developer on a team of five. I was responsible for overseeing the technical aspects of development, including writing code, debugging, and ensuring the quality and timeliness of deliverables.\n\nOne challenge we faced was integrating our new system with the different existing databases. Through careful analysis, brainstorming sessions with the team, and constant trial and error, we successfully resolved the issue.\n\nThe project was a success, it improved the accuracy and speed of producing reports by 30%. Working on this project, I developed my leadership skills, became more proficient with a couple of programming languages, and learned how to effectively solve problems as a team and integrate different databases.',
    ),
    Flashcard(
      question:
      'Tell me about a situation that required you to dig deep to get to the root cause.',
      explanation:
      'The interviewer asking "Tell me about a situation that required you to dig deep to get to the root cause" wants to explore your problem-solving skills. They want to understand how you handle problems, what steps you take to identify the issue, and how you work towards implementing a solution. This question also gives them insights into your ability to remain focused, show resilience, and work independently under challenging situations.\n\nWhen answering this question, you should aim to express:\nA significant problem or challenge that you faced.\nHow you analyzed the situation to identify the issue.\nThe steps and strategies you took to overcome the problem.\nThe results of your action.',
      exampleAnswer:
      'During my tenure as a Project Manager with XYZ corp., we encountered a situation where three out of five projects were significantly over budget and delayed. Recognizing its impact, I took the initiative to get at the root of the problem.\n\nAfter going through project budget reports and talking to team leaders, I discovered that the main issue was the ineffective use of resources. There was a clear lack of understanding amongst team members about project goals, timelines, and a lot of time was wasted on rework.\n\nI proposed and implemented a new protocol, which included weekly team meetings for clear communication, documented project plans with defined milestones, and regular training programs to improve skills. These changes helped in eliminating ambiguity and improved the efficiency of teams. Within six months, all three projects were back on track and we not only saved the company a significant amount of money but also improved the client’s confidence in our ability to deliver.',
    ),
    Flashcard(
      question: 'Tell me about yourself.',
      explanation:
      'When an interviewer asks the question, "Tell me about yourself," it\'s an invitation for the interviewee to highlight their professional background, skills, and achievements. This is typically the first question in an interview, and it\'s a fantastic opportunity to set the tone for the rest of the interview.\n\nWhile answering this question, follow a structured method. One such method is the Present-Past-Future formula:\nPresent: Talk about what you are currently doing.\nPast: Discuss your past experiences and achievements that brought you to the present stage in your career.\nFuture: Highlight your future ambitions and why you are excited about the job you are applying for.\nAvoid sharing personal information unless it directly relates to the job for which you are being interviewed. Keep your answer concise and focused on your career.',
      exampleAnswer:
      'I\'m a recent graduate with a degree in [your course] from [university graduated]. Right now, I\'m actively seeking opportunities where I can apply the knowledge and skills I’ve developed during my academic journey, particularly in areas like [mention a specialization or field you\'re interested in]. In my final year, I worked on several projects that challenged me to think critically and collaborate effectively with a team, especially when solving real-world problems.\n\nBack in university, I took every opportunity to get involved in activities beyond the classroom—from volunteering in tech events to joining student-led organizations. These experiences helped me improve not just my technical abilities, but also my communication and leadership skills. I also spent a lot of time learning tools and platforms on my own, which allowed me to build confidence in handling different types of challenges.\n\nNow, I’m eager to begin the next phase of my career where I can grow further, contribute to meaningful projects, and continuously improve. I’m particularly excited about roles that offer mentorship and hands-on experience, as I believe that being in a supportive learning environment is key to professional growth.',
    ),
    Flashcard(
      question: 'What are your weaknesses and strengths?',
      explanation:
      'This question is a classic one used by interviewers to evaluate your self-awareness, honesty, and ability to improve from past experiences. They want to know if you can be objective about your skills and abilities, highlighting what you do well, but also showing that you have humility to acknowledge areas where you can be improved.\n\nYour strengths must demonstrate abilities and skills relevant to the job role, while your weaknesses must show both self-awareness and an initiative to learn and progress. Remember, don\'t mention a weakness that is a critical requirement for the job. It\'s beneficial to choose a weakness that you\'re actively working on improving, this shows the interviewer that you can take initiative in personal development.',
      exampleAnswer:
      'Strengths: "One of my key strengths is communication. I can comfortably speak in large groups, write comprehensive reports, and can establish rapport with a wide variety of people. During my last job at XYZ Company, I often had to present complex information to clients, which was a task I excelled at.\n\nWeaknesses: My biggest weakness is that I\'m a perfectionist. I have often found myself spending too much time checking over my work for the smallest mistakes that might not even exist; to overcome it, I\'ve learned to set deadlines for reviews which has improved my efficiency.\n\nExample Answer 2:\nStrengths: "I pride myself on my problem-solving skills. They have been very useful throughout my career especially when dealing with issues like software bugs and production disruptions. It\'s satisfying to resolve issues quickly and efficiently to maintain workflow continuity.\n\nWeaknesses: In terms of weaknesses, I\'m aware that I can get too engrossed in the details of a project and lose sight of the bigger picture. To balance this, I\'ve started practicing time-management techniques, and I am learning to delegate tasks more effectively."',
    ),
    Flashcard(
      question:
      'How do you approach debugging a complex software issue when the root cause is not immediately apparent?',
      explanation:
      'This question is asking about your problem-solving approach when facing unclear or difficult issues in software debugging. It\'s important to demonstrate a structured method. Key points to consider in your response include: identifying and isolating the problem, using data analysis and logging tools, researching known issues, collaborating with team members, and being methodical in testing solutions to narrow down potential causes. Also, highlighting a positive outcome from your approach can be beneficial.',
      exampleAnswer:
      'When I encounter a complex software issue, I start by clearly defining the problem and gathering any relevant context. I check logs and error messages to gather statistics that may guide my investigation. After that, I create a hypothesis based on my findings and conduct tests to confirm or deny my assumptions. For instance, in my previous project, I faced a persistent crash issue. By analyzing usage patterns and error frequencies, I discovered that a specific user action triggered a race condition. This led us to apply a patch that resolved the issue without further complaints.\n\nExample Answer 2:\nIn situations where the root cause of a software issue isn\'t clear, I first replicate the problem in a controlled environment. I utilize tools to collect metrics and logs related to the issue. I also consult documentation and resources to determine if the problem might be a known issue. Once I have sufficient data, I perform a series of tests, focusing on one component at a time to identify abnormalities. For example, I once dealt with a performance drop in a web application. After isolating the components, it became evident that a third-party API was introducing latency, which I mitigated with caching strategies.',
    ),
    Flashcard(
      question:
      'How do you approach problem-solving in high-pressure situations while maintaining productivity and focus?',
      explanation:
      'This question is asking you to articulate your process for problem-solving specifically when under high-pressure circumstances. \n\nTo answer effectively, consider the following points: \n1. Describe your initial reaction to pressure situations. \n2. Explain your problem-solving methodology (e.g., breaking down the issue, prioritizing tasks). \n3. Share an example showcasing your focus and productivity in such scenarios. \n4. Reflect on what you learned from these experiences.',
      exampleAnswer:
      'In high-pressure situations, I first take a deep breath and assess the situation to avoid making rash decisions. I break down the problem into smaller, manageable parts and prioritize them based on urgency and impact. For instance, during a project deadline crunch, I once faced a critical issue with a client\'s software. I quickly gathered my team, delegated tasks based on each member’s strengths, and established clear deadlines. By maintaining open communication and focusing on solutions rather than the pressure, we met the deadline and exceeded client expectations.\n\nExample Answer 2:\nWhen confronted with high-pressure scenarios, I maintain my productivity by implementing a structured approach. I often start by identifying the core issue at hand and outline a plan of action. For instance, during a recent event planning crisis where key vendors pulled out last minute, I immediately created a list of alternative vendors and prioritized outreach based on availability. By keeping my focus on solutions and using a systematic approach, I managed to secure replacements in time for the event, ensuring everything ran smoothly despite the initial setbacks.',
    ),
    Flashcard(
      question:
      'What strategies do you use to prioritize tasks and manage time effectively in high-pressure environments?',
      explanation:
      'This question is designed to assess your ability to manage time and prioritize tasks, especially in high-pressure situations. The interviewer wants to understand your thought process and strategies you employ to remain productive and organized. \n\nTo effectively answer this question, you should: \n1. Describe specific strategies or methods you use (e.g., prioritization frameworks like Eisenhower Matrix). \n2. Provide an example of a high-pressure situation where you applied these strategies effectively. \n3. Highlight the outcome of your approach to emphasize its effectiveness.',
      exampleAnswer:
      'In high-pressure situations, I rely on a combination of the Eisenhower Matrix and digital project management tools. For instance, during a recent project deadline, I identified urgent and important tasks using the matrix, allowing me to focus on what truly mattered. I made a detailed checklist in my project management software, breaking down tasks into manageable portions. As a result, I completed the project two days early, allowing additional time for final revisions.\n\nExample Answer 2:\nI prioritize tasks in high-pressure environments by implementing a daily planning routine and using time-blocking techniques. An example of this was when I was leading a critical client presentation. I started by listing all the tasks that needed completion, categorized them by urgency and importance, and allocated specific time slots for each task in my calendar. This method not only kept me organized but also helped me reduce stress, ultimately leading to a smooth presentation day and positive feedback from the client.',
    ),
    Flashcard(
      question:
      'Talk about a time when you worked on a team and demonstrated leadership',
      explanation:
      'This question is asking you to provide an example from your past experiences where you were part of a team and took on a leadership role. Ideally, your answer will demonstrate to the interviewer that you possess good teamwork and leadership skills, and you\'re able to collaborate with peers while also being capable of taking the lead when the situation demands it. When structuring your response, try to follow the STAR (Situation, Task, Action, Result) format. Elaborate on where you were working or what the project was (Situation). Then talk about what your team was asked to do (Task). Then describe what steps you took, specifically as a leader (Action). Lastly, how did your leadership contribute to the team\'s success (Result)?',
      exampleAnswer:
      'In my previous role as a project coordinator at an advertising company, I had the opportunity to lead a team of five to deliver a complex project for a major client (Situation). The project required us to develop a comprehensive digital marketing strategy within a highly tight deadline (Task). Recognizing the intense workload and time constraint, as a leader, I brainstormed with my team to arrange the tasks based on each individual\'s strengths and split the workload evenly amongst team members. I maintained open and regular communication to ensure we were all aligned with our goals. I also arranged weekly team meetings to discuss our progress and resolve any issues that arose (Action). The result was that we finished the task 3 days ahead of the deadline with an outcome that exceeded the client’s expectations. The client praised our team’s dedication and the quality of our recommended strategy (Result).\n\nExample Answer 2:\nIn my final year at [university graduated], I led our capstone project team in developing a web application. At first, we faced challenges in dividing responsibilities and staying on track. I stepped up by assigning clear roles, setting deadlines, and holding regular check-ins to keep everyone aligned. I also made sure each member’s input was valued to keep motivation high. In the end, we submitted the project ahead of time and received positive feedback from our panel. The experience helped me grow as a team player and as someone who can guide a group toward a shared goal.',
    ),
    Flashcard(
      question:
      'How do you approach troubleshooting a critical production system failure under tight deadlines?',
      explanation:
      'This question is about assessing your problem-solving skills and ability to work under pressure. Troubleshooting a critical production system failure requires a systematic approach, decisive action, and effective communication. \n\nTo answer this question, consider the following key points: \n1. Identify the problem: Quickly assess the situation to understand what exactly has failed. \n2. Gather relevant information: Collect data, logs, and user feedback to help diagnose the issue. \n3. Prioritize actions: Determine which issues are most critical to resolve first. \n4. Communicate clearly: Keep stakeholders informed of your progress and any potential impacts. \n5. Implement a solution and monitor: Once a potential fix is identified, apply it and monitor the system closely for any further issues. \n6. Post-mortem analysis: After resolution, review the incident to prevent future occurrences.',
      exampleAnswer:
      'When facing a critical production system failure under tight deadlines, my first step is to quickly identify the nature of the problem by checking the error logs and speaking to the affected users. I then prioritize the issues based on their impact on the system\'s functionality. For example, if the failure affects customer transactions, that would become my top priority. Once I have identified the primary issue, I communicate with my team and stakeholders to keep everyone informed about the status. After implementing the fix, such as rolling back a recent deployment or modifying configuration settings, I continuously monitor the system for stability. Finally, I ensure that a thorough post-mortem is conducted to analyze what went wrong and develop preventive measures for the future.\n\nExample Answer 2:\nIn the event of a critical failure in a production system, I adopt a structured approach to troubleshooting. First, I assess the situation by gathering all relevant data and alerts to pinpoint the source of the failure. For instance, if I notice a spike in error rates following a new feature launch, that would be my starting point. I prioritize resolving the issue that has the greatest impact, focusing on restoring system functionality as quickly as possible. I communicate my findings and actions to the team while collaborating to brainstorm additional solutions. After applying a fix, like optimizing the code or scaling the database, I closely monitor performance metrics. Once stability is achieved, I lead a review meeting to discuss the incident and document lessons learned for future reference.',
    ),
    Flashcard(
      question:
      'How would you approach handling a difficult client and provide a solution that satisfies both parties?',
      explanation:
      'This question is trying to assess your conflict resolution skills, as well as your abilities to maintain good client relationships and deliver customer satisfaction. The employer wants to understand how you deal with challenging situations and difficult stakeholders, and how you strive towards proposing solutions that are mutually beneficial to both the client and the organization. \n\nWhen answering this question, make sure to emphasize your:\nProblem-solving abilities\nCommunication skills\nEmpathy and understanding towards the client\nNegotiation skills\nBalancing clients’ needs and organization’s interests\nProfessionalism and patience\n\nYou should sequence your answer in terms of identifying the problem, understanding the client\'s perspective, developing a solution, and negotiating to ensure that both parties are satisfied with the outcome.',
      exampleAnswer:
      'During our internship project at [company or university program], we had a client who kept requesting changes that weren’t aligned with the initial scope. Instead of pushing back right away, I first listened to understand their concerns. I acknowledged their needs, then explained the limitations and how it could affect our timeline. After discussing with my team, I proposed a compromise — we prioritized the most critical changes within the deadline and scheduled the rest for future iterations. The client appreciated the transparency, and we maintained a good working relationship. I learned that empathy, clear communication, and setting expectations early can turn a difficult situation into a productive one.',
    ),
  ];

  static List<Question> situationalJudgementQuestions = [
    // --- COMMUNICATION ---
    Question(
      category: 'Communication',
      scenarioDescription:
      "You've been chosen to present your team's progress during the company's monthly performance review. As you're presenting, a senior manager interrupts you mid-sentence with a question about a topic you were planning to discuss later. Everyone looks to you, waiting for your reaction as the interruption throws off your momentum.", // [cite: 20, 21, 22]
      questionText: "How should you respond?", // [cite: 22
      options: [
        "Acknowledge the question respectfully and explain that it will be covered later in your presentation.", // [cite: 23]
        "Ask the manager to hold questions until the end of your presentation.", // [cite: 25]
        "Continue presenting while speaking louder to finish your point.", // [cite: 26]
        "Get nervous, skip that section, and move on to another topic.", // [cite: 27]
      ],
      correctOptionIndex: 0, // [cite: 23]
      explanation:
      "This response shows high Communication and Emotional Intelligence. It respects the manager's query while confidently maintaining the presentation's structure.", //
    ),
    Question(
      category: 'Communication',
      scenarioDescription:
      "After sending a project update via email, you learn that a colleague felt your message sounded harsh and dismissive. Since then, they've been avoiding you in meetings and collaboration tasks. You realize your tone may have been misinterpreted due to how you phrased things.", // [cite: 28, 29, 30]
      questionText:
      "What would be the best way to handle this misunderstanding?", // [cite: 31]
      options: [
        "Approach them in person, clarify your intentions, and apologize for any miscommunication.", // [cite: 32]
        "Reply to the same email thread and explain what you really meant.", // [cite: 44]
        "Avoid the issue since it might resolve itself with time.", // [cite: 45]
        "Tell other coworkers that your colleague is being overly sensitive.", // [cite: 46]
      ],
      correctOptionIndex: 0, // [cite: 32]
      explanation:
      "This response demonstrates high Emotional Intelligence and Communication. Addressing the conflict directly and in person is the most effective way to resolve a tonal misinterpretation and mend the working relationship.", // [cite: 32]
    ),
    Question(
      category: 'Communication',
      scenarioDescription:
      "You've been asked to train a group of new hires on using your company's software tools. Ten minutes into your presentation, you notice most of them are staring blankly and not taking notes. You realize your explanation might be too technical.", // [cite: 47, 48, 49]
      questionText: "What's the most effective way to continue?", // [cite: 49]
      options: [
        "Pause to simplify your explanation using visual examples and relatable terms.", // [cite: 50]
        "Continue your presentation but slow down slightly.", // [cite: 51]
        "Finish quickly so you can share the full manual instead.", // [cite: 52]
        "End the session early since they seem uninterested.", // [cite: 53]
      ],
      correctOptionIndex: 0, // [cite: 50]
      explanation:
      "This shows strong Communication and Adaptability. Noticing the audience's confusion and changing your approach is key to effective training.", // [cite: 50]
    ),
    Question(
      category: 'Communication',
      scenarioDescription:
      "In a weekly meeting, your teammate presents a report that includes incorrect data from a file you shared. The manager questions the accuracy, and the teammate looks embarrassed. You know the mistake was due to a miscommunication between both of you.", // [cite: 54, 55, 56]
      questionText: "How should you handle the situation?", // [cite: 56]
      options: [
        "Clarify the misunderstanding respectfully during the meeting and take shared responsibility.", // [cite: 57]
        "Stay quiet and explain the mistake privately afterward.", // [cite: 58]
        "Correct the teammate immediately in front of everyone.", // [cite: 59]
        "Let the manager assume the teammate made the mistake alone.", // [cite: 60]
      ],
      correctOptionIndex: 0, // [cite: 57]
      explanation:
      "Taking shared responsibility immediately demonstrates excellent Communication and Teamwork. It clears up the confusion without placing blame on a single person.", // [cite: 57]
    ),
    Question(
      category: 'Communication',
      scenarioDescription:
      "Your manager sends an unclear message about an urgent task, but they're in back-to-back meetings all day. The deadline is tomorrow, and you don't want to deliver the wrong output.", // [cite: 61, 62]
      questionText: "How would you handle this communication gap?", // [cite: 62]
      options: [
        "Send a short message asking for clarification and proceed only once you're sure of the requirements.", // [cite: 63]
        "Make your best guess and complete the task based on past examples.", // [cite: 65]
        "Wait until your manager is available to ask in person, even if it delays work.", // [cite: 66]
        "Ask a coworker to decide for you since they might know.", // [cite: 67]
      ],
      correctOptionIndex: 0, // [cite: 63]
      explanation:
      "This response shows good Communication and Problem-Solving. It's crucial to get clarity before starting urgent work to avoid wasting time on the wrong output.", // [cite: 64]
    ),
    Question(
      category: 'Communication',
      scenarioDescription:
      "During a department presentation, you notice your audience starting to lose focus—people are checking their phones and whispering. You still have 10 minutes left to present.", // [cite: 77, 78]
      questionText: "How could you keep their attention effectively?", // [cite: 78]
      options: [
        "Switch to a more engaging tone, summarize key points, and relate your topic to their roles.", // [cite: 79]
        "Continue reading from your slides to stay on track.", // [cite: 81]
        "Skip sections to finish faster and avoid boring them.", // [cite: 82]
        "Ask a few quick questions to re-engage them before continuing.", // [cite: 83]
      ],
      correctOptionIndex: 0, // [cite: 79]
      explanation:
      "This is the most effective strategy, demonstrating Communication and Adaptability. You are actively adjusting your style to meet the audience's needs and re-engage them.", // [cite: 80]
    ),
    Question(
      category: 'Communication',
      scenarioDescription:
      "You are collaborating with another department that prefers different communication tools. They often miss your updates because they use a different platform. This is starting to slow down the project.", // [cite: 86, 87]
      questionText: "What's the most practical step you can take?", // [cite: 88]
      options: [
        "Suggest setting a common communication platform or routine update schedule.", // [cite: 89]
        "Continue sending messages through your preferred tool.", // [cite: 90]
        "Wait for them to adjust to your system.", // [cite: 91]
        "Follow up using their preferred channel while coordinating with your team.", // [cite: 92]
      ],
      correctOptionIndex: 0, // [cite: 89]
      explanation:
      "This is a proactive, long-term solution that shows strong Communication and Problem-Solving. It aims to fix the root cause of the issue for the benefit of the project.", // [cite: 89]
    ),
    Question(
      category: 'Communication',
      scenarioDescription:
      "You're part of a virtual meeting where a coworker's internet connection keeps cutting out. They're responsible for sharing critical updates but can't be heard clearly. The group starts getting frustrated.", // [cite: 93, 94]
      questionText: "How should you manage the situation?", // [cite: 95]
      options: [
        "Suggest pausing their update and having them send a written summary afterward.", // [cite: 96]
        "Let them continue even if no one understands.", // [cite: 97]
        "Interrupt frequently to ask them to repeat parts you missed.", // [cite: 98]
        "Offer to summarize what they said so far and confirm details later.", // [cite: 99]
      ],
      correctOptionIndex: 0, // [cite: 96]
      explanation:
      "This demonstrates good Communication and Adaptability. It respects everyone's time by finding the most efficient way to get the critical information without causing more frustration.", // [cite: 96]
    ),
    Question(
      category: 'Communication',
      scenarioDescription:
      "You've noticed your team's group chat has become filled with off-topic jokes and distractions. Important updates are getting buried in the thread, causing confusion about tasks.", // [cite: 100, 101]
      questionText: "What's the best way to address this?", // [cite: 101]
      options: [
        "Politely remind the team to keep work-related discussions in the main channel.", // [cite: 102]
        "Leave the group chat until it becomes more professional.", // [cite: 104]
        "Report the behavior to your supervisor immediately.", // [cite: 112]
        "Ignore it since it doesn't directly affect your work.", // [cite: 113]
      ],
      correctOptionIndex: 0, // [cite: 102]
      explanation:
      "This is a direct, professional, and respectful approach that shows good Communication and Teamwork. It addresses the problem without escalating it unnecessarily.", // [cite: 103]
    ),
    Question(
      category: 'Communication',
      scenarioDescription:
      "You're asked to communicate an unpopular policy change to your coworkers. You know it will affect their workload and morale.", // [cite: 115, 116]
      questionText: "How would you deliver the message effectively?", // [cite: 116]
      options: [
        "Explain the reason behind the policy and allow open discussion for concerns.", // [cite: 117]
        "Read the memo word-for-word to stay neutral.", // [cite: 119]
        "Announce it casually without context to avoid negativity.", // [cite: 120]
        "Wait for your supervisor to make the announcement instead.", // [cite: 121]
      ],
      correctOptionIndex: 0, // [cite: 117]
      explanation:
      "This shows high Communication and Emotional Intelligence. Being transparent about the 'why' and allowing people to voice concerns builds trust, even when the news is bad.", // [cite: 118]
    ),

    // --- TEAMWORK ---
    Question(
      category: 'Teamwork',
      scenarioDescription:
      "Your project team is working on a major deliverable due in two days. One teammate messages the group saying they can't finish their part on time due to a family emergency. Everyone looks stressed, and deadlines are at risk.", // [cite: 124, 125, 126]
      questionText: "How should you respond?", // [cite: 126]
      options: [
        "Offer to take part of their workload and ask the team how to reorganize tasks.", // [cite: 127]
        "Tell them not to worry but continue working on your own section only.", // [cite: 129]
        "Suggest informing the supervisor that the delay isn't your fault.", // [cite: 130]
        "Complain that they should've planned better.", // [cite: 131]
      ],
      correctOptionIndex: 0, // [cite: 127]
      explanation:
      "This is a highly effective combination of Teamwork and Adaptability. You are showing empathy, taking initiative, and collaborating to solve the problem.", // [cite: 128]
    ),
    Question(
      category: 'Teamwork',
      scenarioDescription:
      "Two teammates are having a disagreement about the best way to complete a task, and it's holding up progress. The discussion is getting heated.", // [cite: 132, 133]
      questionText: "What would be the best way to handle this conflict?", // [cite: 133]
      options: [
        "Step in calmly, summarize both sides, and help them find a middle ground.", // [cite: 134]
        "Tell them to stop arguing and just decide quickly.", // [cite: 135]
        "Let them argue since it's not your business.", // [cite: 136]
        "Suggest escalating the issue to your team leader.", // [cite: 137]
      ],
      correctOptionIndex: 0, // [cite: 134]
      explanation:
      "This response shows strong Teamwork and Communication. Acting as a calm mediator helps de-escalate the conflict and refocuses the team on a productive solution.", // [cite: 134]
    ),
    Question(
      category: 'Teamwork',
      scenarioDescription:
      "Your team just completed a major presentation, and your manager congratulates you publicly. However, they mention your name only, even though the success was a team effort.", // [cite: 138, 139]
      questionText: "How should you react?", // [cite: 146]
      options: [
        "Thank your manager and emphasize the team's contribution.", // [cite: 150]
        "Accept the praise quietly and move on.", // [cite: 151]
        "Correct your manager in front of everyone.", // [cite: 152]
        "Mention the team's role privately later.", // [cite: 153]
      ],
      correctOptionIndex: 0, // [cite: 150]
      explanation:
      "This demonstrates excellent Teamwork and Emotional Intelligence. You accept the praise gracefully while immediately and publicly sharing the credit with your team.", // [cite: 150]
    ),
    Question(
      category: 'Teamwork',
      scenarioDescription:
      "You're working with a new colleague who's unfamiliar with the company's workflow. They make frequent mistakes that slow the team down.", // [cite: 154, 155]
      questionText: "How would you handle this situation?", // [cite: 155]
      options: [
        "Offer to guide them through the process and answer their questions.", // [cite: 156]
        "Tell them to review the manual before asking for help.", // [cite: 157]
        "Ignore their mistakes since it's not your role to train them.", // [cite: 158]
        "Inform your supervisor that extra support may be needed.", // [cite: 159]
      ],
      correctOptionIndex: 0, // [cite: 156]
      explanation:
      "This is a supportive response that shows strong Teamwork and Communication. Helping a new colleague get up to speed benefits the entire team in the long run.", // [cite: 156]
    ),
    Question(
      category: 'Teamwork',
      scenarioDescription:
      "A group project has uneven task distribution—some members are overloaded while others have little to do. Tension is growing.", // [cite: 160, 161, 162]
      questionText: "What would you do to restore balance?", // [cite: 162]
      options: [
        "Suggest a quick team meeting to discuss fair workload distribution.", // [cite: 163]
        "Quietly take on extra work yourself to keep peace.", // [cite: 164]
        "Vent your frustration to another group.", // [cite: 165]
        "Do only your assigned part and ignore the imbalance.", // [cite: 166]
      ],
      correctOptionIndex: 0, // [cite: 163]
      explanation:
      "This is the most effective Teamwork and Communication approach. Addressing the issue openly and collaboratively as a team is the only way to find a fair, sustainable solution.", // [cite: 163]
    ),
    Question(
      category: 'Teamwork',
      scenarioDescription:
      "A team member regularly misses meetings and doesn't communicate updates. It's causing delays.", // [cite: 167]
      questionText: "What should be your first step?", // [cite: 167]
      options: [
        "Check in privately to ask if something's preventing their attendance.", // [cite: 168]
        "Report them directly to your supervisor.", // [cite: 169]
        "Confront them during the next meeting.", // [cite: 170]
        "Ignore it since it's not your responsibility.", // [cite: 171]
      ],
      correctOptionIndex: 0, // [cite: 168]
      explanation:
      "This approach shows high Teamwork and Emotional Intelligence. Checking in privately first is empathetic and assumes there may be a valid reason, avoiding public confrontation.", // [cite: 168]
    ),
    Question(
      category: 'Teamwork',
      scenarioDescription:
      "You and your team are struggling to complete a task due to unclear instructions. Everyone looks to you for guidance.", // [cite: 172, 173]
      questionText: "How would you support your team?", // [cite: 173]
      options: [
        "Reach out to your supervisor for clarification and share updates with the group.", // [cite: 174]
        "Guess the instructions and move forward to save time.", // [cite: 176]
        "Tell everyone to wait until the manager sends an update.", // [cite: 186]
        "Discuss the unclear parts as a group and find the best logical approach.", // [cite: 187]
      ],
      correctOptionIndex: 0, // [cite: 174]
      explanation:
      "This demonstrates clear Teamwork and Communication. You are taking charge of the ambiguity, going to the source for clarification, and committing to keeping the team informed.", // [cite: 175]
    ),
    Question(
      category: 'Teamwork',
      scenarioDescription:
      "Your team has just finished a long, stressful project. Everyone feels drained, but there's still one minor follow-up task left.", // [cite: 188, 189]
      questionText: "What would you do?", // [cite: 189]
      options: [
        "Volunteer to complete the final task to support your team.", // [cite: 190]
        "Ask someone else to handle it since you've already done your part.", // [cite: 191]
        "Suggest delaying it until next week.", // [cite: 192]
        "Leave immediately after your assigned tasks are done.", // [cite: 193]
      ],
      correctOptionIndex: 0, // [cite: 190]
      explanation:
      "This shows excellent Teamwork and Emotional Intelligence. Recognizing your team is drained and taking the initiative to handle the last task is a strong supportive action.", // [cite: 190]
    ),
    Question(
      category: 'Teamwork',
      scenarioDescription:
      "A new teammate struggles to fit in and rarely speaks up during meetings. The rest of the group has started ignoring their input.", // [cite: 194, 195]
      questionText: "How should you handle this dynamic?", // [cite: 195]
      options: [
        "Invite their opinions and help them share ideas during discussions.", // [cite: 196]
        "Let them stay quiet until they become more comfortable.", // [cite: 197]
        "Talk to your leader privately about their behavior.", // [cite: 199]
        "Joke about it to lighten the mood.", // [cite: 199]
      ],
      correctOptionIndex: 0, // [cite: 196]
      explanation:
      "This is a proactive and inclusive action demonstrating high Teamwork and Communication. You are actively creating a safe space for the new member to contribute.", // [cite: 196]
    ),
    Question(
      category: 'Teamwork',
      scenarioDescription:
      "Your team's task relies on multiple departments. One department is late with their part, and your teammates are blaming them in group chat messages.", // [cite: 200]
      questionText: "What's the best way to keep the team focused?", // [cite: 201]
      options: [
        "Encourage everyone to stay professional and ask how you can support the other team.", // [cite: 202]
        "Join in complaining since the other department caused delays.", // [cite: 204]
        "Tell your team to stop talking about it.", // [cite: 205]
        "Offer to contact the other department to check on progress.", // [cite: 206]
      ],
      correctOptionIndex: 0, // [cite: 202]
      explanation:
      "This response shows strong Teamwork and Emotional Intelligence. It de-escalates the negativity and shifts the team's perspective from blame to constructive support.", // [cite: 203]
    ),

    // --- PROBLEM-SOLVING ---
    Question(
      category: 'Problem-Solving',
      scenarioDescription:
      "You notice that your company's report submission system often crashes before deadlines, causing delays. It has happened three times this month.", // [cite: 209, 210]
      questionText: "What would you do?", // [cite: 210]
      options: [
        "Document the problem and suggest a permanent technical solution.", // [cite: 211]
        "Report the issue every time it happens without proposing solutions.", // [cite: 221]
        "Find a temporary workaround and continue using it quietly.", // [cite: 222]
        "Ignore it and hope IT fixes it eventually.", // [cite: 223]
      ],
      correctOptionIndex: 0, // [cite: 211]
      explanation:
      "This is the best example of Problem-Solving and Communication. You aren't just reporting an issue; you are analyzing a pattern, documenting it, and proposing a long-term fix.", // [cite: 219]
    ),
    Question(
      category: 'Problem-Solving',
      scenarioDescription:
      "A client calls with a complaint about an error in their invoice. You're unsure who made the mistake.", // [cite: 224]
      questionText: "How would you handle this situation?", // [cite: 225]
      options: [
        "Check the records, identify the cause, and provide a corrected invoice.", // [cite: 226]
        "Tell the client you'll get back to them later and forward it to someone else.", // [cite: 227]
        "Apologize but do nothing since it wasn't your error.", // [cite: 228]
        "Defend your team by insisting the client must be wrong.", // [cite: 229]
      ],
      correctOptionIndex: 0, // [cite: 226]
      explanation:
      "This response shows strong Problem-Solving and client-facing Communication. You are taking ownership of the problem, investigating the root cause, and providing a solution.", // [cite: 226]
    ),
    Question(
      category: 'Problem-Solving',
      scenarioDescription:
      "You've been assigned to optimize a process that seems outdated. Your team is used to it and doesn't see the need for change.", // [cite: 230, 231]
      questionText: "What's your best move?", // [cite: 231]
      options: [
        "Analyze current inefficiencies and propose small, data-supported improvements.", // [cite: 232]
        "Suggest major changes immediately to get faster results.", // [cite: 233]
        "Do nothing since the team is resistant to change.", // [cite: 234]
        "Ask for team feedback before finalizing your recommendations.", // [cite: 235]
      ],
      correctOptionIndex: 0, // [cite: 232]
      explanation:
      "This approach demonstrates strategic Problem-Solving and Communication. Using data to support your proposal and suggesting small changes is more effective at overcoming resistance.", // [cite: 232]
    ),
    Question(
      category: 'Problem-Solving',
      scenarioDescription:
      "You're given a task with incomplete information and a short deadline.", // [cite: 236]
      questionText: "What's the smartest way to proceed?", // [cite: 236]
      options: [
        "Ask clarifying questions to ensure you understand the requirements.", // [cite: 237]
        "Start working immediately based on assumptions.", // [cite: 239]
        "Wait until all details are given, even if it causes delay.", // [cite: 240]
        "Ask a coworker how they would approach it.", // [cite: 241]
      ],
      correctOptionIndex: 0, // [cite: 237]
      explanation:
      "This is the most effective Problem-Solving and Communication strategy. Asking clarifying questions *before* starting prevents wasted work and ensures the final product is correct.", // [cite: 238]
    ),
    Question(
      category: 'Problem-Solving',
      scenarioDescription:
      "You discover a recurring mistake in your team's reports that no one has addressed.", // [cite: 242]
      questionText: "What should you do first?", // [cite: 242]
      options: [
        "Identify the root cause and suggest a fix to prevent it.", // [cite: 243]
        "Quietly correct it in your own work only.", // [cite: 244]
        "Blame whoever handled the reports last.", // [cite: 253]
        "Inform your supervisor and provide examples of the issue.", // [cite: 255]
      ],
      correctOptionIndex: 0, // [cite: 243]
      explanation:
      "This shows high-level Problem-Solving and Teamwork. Instead of just fixing the symptom (the one mistake) or blaming, you are looking for the root cause to help the whole team.", // [cite: 245]
    ),
    Question(
      category: 'Problem-Solving',
      scenarioDescription:
      "A client requests a sudden change to a project that's almost finished. The change is possible but will take extra time.", // [cite: 256, 257]
      questionText: "What's the most reasonable response?", // [cite: 257]
      options: [
        "Evaluate the impact and discuss timeline adjustments with your leader.", // [cite: 258]
        "Decline the request immediately since it's late.", // [cite: 260]
        "Accept the request without consulting anyone.", // [cite: 261]
        "Inform the client that you'll try but results may be delayed.", // [cite: 262]
      ],
      correctOptionIndex: 0, // [cite: 258]
      explanation:
      "This response shows strong Problem-Solving and Communication. You are not saying 'no' or 'yes' immediately, but rather 'let me assess the impact' so you can set realistic expectations.", // [cite: 259]
    ),
    Question(
      category: 'Problem-Solving',
      scenarioDescription:
      "Your manager gives you two urgent tasks due at the same time. Both are important.", // [cite: 263]
      questionText: "How should you approach this?", // [cite: 264]
      options: [
        "Prioritize based on urgency and communicate timelines clearly.", // [cite: 265, 267]
        "Work on both tasks simultaneously without planning.", // [cite: 269]
        "Ask which one to finish first and then focus.", // [cite: 270]
        "Complete whichever one you prefer.", // [cite: 271]
      ],
      correctOptionIndex: 0, // [cite: 265, 267]
      explanation:
      "This is the ideal Problem-Solving and Communication approach. It demonstrates that you can analyze, prioritize, and manage expectations by communicating your plan.", // [cite: 268]
    ),
    Question(
      category: 'Problem-Solving',
      scenarioDescription:
      "Your team's usual software suddenly stops working during a client presentation.", // [cite: 272]
      questionText: "What should you do?", // [cite: 272]
      options: [
        "Stay calm and quickly switch to an alternative method (PDF/backup slides).", // [cite: 273]
        "Apologize and end the presentation early.", // [cite: 275]
        "Ask the client to wait while you restart your computer.", // [cite: 276]
        "Keep presenting verbally while explaining visuals.", // [cite: 277]
      ],
      correctOptionIndex: 0, // [cite: 273]
      explanation:
      "This shows excellent Problem-Solving and Adaptability. Having a backup plan and switching to it calmly minimizes disruption and shows professionalism.", // [cite: 274]
    ),
    Question(
      category: 'Problem-Solving',
      scenarioDescription:
      "You find two employees submitting conflicting data reports.", // [cite: 278]
      questionText: "How do you resolve the inconsistency?", // [cite: 278]
      options: [
        "Compare both reports, verify data, and consolidate accurate figures.", // [cite: 279]
        "Choose the report from the more senior employee.", // [cite: 280]
        "Forward both reports to the manager without review.", // [cite: 281]
        "Discuss discrepancies with both employees before resubmitting.", // [cite: 282]
      ],
      correctOptionIndex: 0, // [cite: 279]
      explanation:
      "This is the most thorough Problem-Solving approach. You are taking ownership to find the objective truth in the data before involving others, ensuring accuracy.", // [cite: 279]
    ),
    Question(
      category: 'Problem-Solving',
      scenarioDescription:
      "You receive feedback that a process you designed is confusing others.", // [cite: 285]
      questionText: "How should you respond?", // [cite: 291]
      options: [
        "Review their concerns, simplify the process, and provide clear documentation.", // [cite: 296]
        "Defend your design and insist it's efficient.", // [cite: 298]
        "Ask someone else to rewrite it for clarity.", // [cite: 299]
        "Thank them for the feedback and plan revisions collaboratively.", // [cite: 300]
      ],
      correctOptionIndex: 0, // [cite: 296]
      explanation:
      "This response shows good Problem-Solving and Communication. It demonstrates that you are receptive to feedback and focused on creating a solution that works for everyone.", // [cite: 297]
    ),

    // --- ADAPTABILITY (Note: PDF has a typo, labels this section 'EMOTIONAL INTELLIGENCE') ---
    Question(
      category: 'Adaptability',
      scenarioDescription:
      "Your company announces a sudden restructuring... You'll have a new supervisor and slightly different tasks. Some of your coworkers are anxious... You feel uneasy too, but the transition begins next week.", // [cite: 304, 305, 306, 307]
      questionText: "How should you handle the situation?", // [cite: 307]
      options: [
        "Stay positive, review the new structure, and prepare to adapt to your updated responsibilities.", // [cite: 308]
        "Complain privately with colleagues about how confusing everything is.", // [cite: 310]
        "Ignore the changes until your supervisor gives direct instructions.", // [cite: 311]
        "Reach out to the new supervisor to clarify expectations early.", // [cite: 312]
      ],
      correctOptionIndex: 0, // [cite: 308]
      explanation:
      "This is the ideal combination of Adaptability and Emotional Intelligence. You are managing your own unease and focusing on positive, proactive steps to handle the change.", // [cite: 309]
    ),
    Question(
      category: 'Adaptability',
      scenarioDescription:
      "Midway through a large project, your manager changes the requirements after receiving new client feedback. The adjustments affect your timeline... Some teammates are frustrated and want to ignore the new directions.", // [cite: 313, 314, 315]
      questionText: "What's the best way to respond?", // [cite: 315]
      options: [
        "Accept the new instructions, reorganize your tasks, and encourage your team to adjust with you.", // [cite: 316]
        "Express your frustration but continue working as planned.", // [cite: 318]
        "Delay your work until the manager confirms the changes again.", // [cite: 320]
        "Discuss how to adjust deadlines or priorities with your manager.", // [cite: 322]
      ],
      correctOptionIndex: 0, // [cite: 316]
      explanation:
      "This response shows strong Adaptability and Teamwork. You are not only accepting the change but also leading your team to adapt and move forward constructively.", // [cite: 317]
    ),
    Question(
      category: 'Adaptability',
      scenarioDescription:
      "Your supervisor suddenly assigns you to a new role while a coworker is on leave. You're unfamiliar with some of the tasks... you only have one day to learn the basics.", // [cite: 324, 332, 333]
      questionText: "How would you approach this challenge?", // [cite: 333]
      options: [
        "Accept the assignment, seek guidance from experienced teammates, and learn quickly on the job.", // [cite: 334]
        "Focus only on tasks you already know and skip the rest.", // [cite: 335]
        "Refuse the assignment until you're formally trained.", // [cite: 336]
        "Attempt the tasks immediately without asking for help.", // [cite: 337]
      ],
      correctOptionIndex: 0, // [cite: 334]
      explanation:
      "This is a 'can-do' attitude that demonstrates high Adaptability and Teamwork. You are willing to step up and are resourceful enough to seek help to get the job done.", // [cite: 334]
    ),
    Question(
      category: 'Adaptability',
      scenarioDescription:
      "Your department adopts new project management software... The new tool feels complicated... Some coworkers are resistant, saying they'll stick to the old system.", // [cite: 338, 339, 340]
      questionText: "How should you handle this change?", // [cite: 340]
      options: [
        "Explore the new software, attend training, and help others adjust to it.", // [cite: 341]
        "Wait until management enforces the change before using it.", // [cite: 342]
        "Use both systems to avoid mistakes.", // [cite: 343]
        "Continue using the old software since it's faster for you.", // [cite: 344]
      ],
      correctOptionIndex: 0, // [cite: 341]
      explanation:
      "This shows excellent Adaptability and Teamwork. You are not only learning the new tool yourself but also acting as a positive agent of change by helping your colleagues.", // [cite: 341]
    ),
    Question(
      category: 'Adaptability',
      scenarioDescription:
      "You arrive at work to learn that your scheduled meeting has been moved up by two hours. The presentation you were preparing is only halfway done... the team is counting on you.", // [cite: 347, 348, 349]
      questionText: "What's your best course of action?", // [cite: 349]
      options: [
        "Prioritize key slides, finalize core information, and present confidently with what's ready.", // [cite: 350]
        "Inform your manager you can't present and ask for a postponement.", // [cite: 351]
        "Skip some important data to finish faster.", // [cite: 355]
        "Show up unprepared and explain you weren't given enough notice.", // [cite: 356]
      ],
      correctOptionIndex: 0, // [cite: 350]
      explanation:
      "This demonstrates strong Adaptability and Problem-Solving. You are making the best of a difficult situation by prioritizing the most critical information and delivering what you can.", // [cite: 350]
    ),
    Question(
      category: 'Adaptability',
      scenarioDescription:
      "You've been transferred to another branch to assist temporarily. The team there follows a very different workflow... You start feeling out of place and unproductive.", // [cite: 357, 358, 359]
      questionText: "How should you adapt?", // [cite: 359]
      options: [
        "Observe how they work, ask respectful questions, and adjust to their system.", // [cite: 360]
        "Try to impose your team's usual style to maintain consistency.", // [cite: 361]
        "Do the bare minimum until your transfer ends.", // [cite: 362]
        "Slowly integrate your methods while learning theirs through collaboration.", // [cite: 363]
      ],
      correctOptionIndex: 0, // [cite: 360]
      explanation:
      "This shows high Adaptability and Communication. When in a new environment, the first step is always to observe and learn, rather than impose your own methods.", // [cite: 360]
    ),
    Question(
      category: 'Adaptability',
      scenarioDescription:
      "You've been asked to support another team while maintaining your current workload. The schedule is tight, and you're worried about balancing both responsibilities.", // [cite: 376, 377]
      questionText: "How should you manage the situation effectively?", // [cite: 377]
      options: [
        "Discuss priorities with your supervisor and organize your schedule to handle both roles efficiently.", // [cite: 378]
        "Focus on your main role and ignore the extra assignment.", // [cite: 379]
        "Accept all tasks without discussing time constraints.", // [cite: 380]
        "Ask a coworker to help manage your added tasks temporarily.", // [cite: 381]
      ],
      correctOptionIndex: 0, // [cite: 378]
      explanation:
      "This is the most professional response, showing Adaptability and Problem-Solving. You are willing to help but are also proactively managing expectations and priorities with your supervisor.", // [cite: 378]
    ),
    Question(
      category: 'Adaptability',
      scenarioDescription:
      "A sudden power outage occurs in your office just before your deadline. Most systems shut down... Your manager still expects an update before the end of the day.", // [cite: 382, 383, 384]
      questionText: "How would you handle this unexpected obstacle?", // [cite: 384]
      options: [
        "Switch to backup tools (mobile hotspot, offline docs) and submit a simplified update.", // [cite: 385]
        "Wait until power returns before doing anything.", // [cite: 386]
        "Leave work early since the systems aren't functioning.", // [cite: 387]
        "Inform your manager about the issue and propose submitting later.", // [cite: 388]
      ],
      correctOptionIndex: 0, // [cite: 385]
      explanation:
      "This response shows maximum Adaptability and Problem-Solving. You are resourceful and find a way to meet the deadline despite a major technical failure.", // [cite: 385]
    ),
    Question(
      category: 'Adaptability',
      scenarioDescription:
      "Your company decides to relocate the office to a new city within three months. Some colleagues are stressed... You're also uncertain but want to set a good example.", // [cite: 389, 390, 391]
      questionText: "How should you react to this major change?", // [cite: 391]
      options: [
        "Stay calm, focus on understanding the relocation plan, and prepare early.", // [cite: 392]
        "Join others in expressing frustration and doubt.", // [cite: 394]
        "Wait until HR contacts you personally before deciding what to do.", // [cite: 395]
        "Ask management for relocation details and offer to help others prepare.", // [cite: 396]
      ],
      correctOptionIndex: 0, // [cite: 392]
      explanation:
      "This demonstrates high Adaptability and Emotional Intelligence. You are managing your own uncertainty and focusing on practical, logical steps to prepare for the change.", // [cite: 393]
    ),
    Question(
      category: 'Adaptability',
      scenarioDescription:
      "You're managing a small project when a critical team member suddenly resigns. The workload increases for everyone, and morale drops. Your manager asks you to take the lead...", // [cite: 397, 398]
      questionText: "How would you handle this transition?", // [cite: 399]
      options: [
        "Reassign tasks fairly, keep communication open, and motivate the team to stay focused.", // [cite: 400]
        "Focus on your own tasks and wait for a new member to arrive.", // [cite: 409]
        "Ask your manager to delay the project timeline immediately.", // [cite: 411]
        "Express frustration and tell the team it's impossible to continue.", // [cite: 411]
      ],
      correctOptionIndex: 0, // [cite: 400]
      explanation:
      "This is a strong leadership response, showing Adaptability and Teamwork. You are stepping up to manage the workload, support morale, and keep the project moving forward.", // [cite: 407]
    ),

    // --- EMOTIONAL INTELLIGENCE (Note: PDF has a typo, labels this section 'ADAPDABILITY') ---
    Question(
      category: 'Emotional Intelligence',
      scenarioDescription:
      "You've just received tough feedback from your supervisor during a team meeting... in front of your colleagues. You feel embarrassed and defensive... The room falls silent.", // [cite: 415, 416, 417, 418]
      questionText: "How should you respond in this situation?", // [cite: 418]
      options: [
        "Thank your supervisor for the feedback, acknowledge the points made, and schedule a follow-up to improve.", // [cite: 419]
        "Stay silent during the meeting but avoid your supervisor afterward.", // [cite: 421]
        "Interrupt and defend your work immediately to justify your side.", // [cite: 422]
        "Calmly explain that you appreciate the feedback and will review the specific issues raised.", // [cite: 423]
      ],
      correctOptionIndex: 0, // [cite: 419]
      explanation:
      "This shows high Emotional Intelligence and Communication. You are managing your defensive feelings and responding professionally, showing you are open to feedback and improvement.", // [cite: 420]
    ),
    Question(
      category: 'Emotional Intelligence',
      scenarioDescription:
      "You've been managing multiple tasks all week, and the workload is starting to take a toll... a coworker unintentionally makes a sarcastic comment about your performance. You feel irritated.", // [cite: 425, 426, 427]
      questionText:
      "What would be the most appropriate way to handle this?", // [cite: 428]
      options: [
        "Take a short break, reflect on your emotions, and address the comment privately later.", // [cite: 429]
        "Respond sarcastically to show you're not affected.", // [cite: 431]
        "Ignore it but hold a grudge toward your coworker.", // [cite: 432]
        "Bring up the issue calmly after the meeting to clarify intent.", // [cite: 433]
      ],
      correctOptionIndex: 0, // [cite: 429]
      explanation:
      "This response demonstrates strong Emotional Intelligence and Adaptability. You are aware of your own irritation and choosing to de-escalate, process, and handle the situation professionally later.", // [cite: 430]
    ),
    Question(
      category: 'Emotional Intelligence',
      scenarioDescription:
      "A new intern accidentally deleted an important document you were working on. You spent hours completing it... your frustration is rising as they start apologizing repeatedly. Other coworkers are watching.", // [cite: 434, 435, 436]
      questionText: "How should you handle the situation?", // [cite: 436]
      options: [
        "Take a deep breath, assure the intern it's okay, and guide them on preventing it next time.", // [cite: 446]
        "Express your anger so they understand the seriousness of their mistake.", // [cite: 448]
        "Stay silent but avoid assigning them future work.", // [cite: 449]
        "Explain calmly that mistakes happen and request help from IT to recover the file.", // [cite: 450]
      ],
      correctOptionIndex: 0, // [cite: 446]
      explanation:
      "This shows high Emotional Intelligence and Teamwork. You are managing your frustration and turning a negative event into a constructive teaching moment for the intern.", // [cite: 447]
    ),
    Question(
      category: 'Emotional Intelligence',
      scenarioDescription:
      "You've noticed that a usually cheerful teammate has been unusually quiet and disengaged... Their performance is starting to drop. You suspect they might be struggling with something personal.", // [cite: 451, 452]
      questionText: "What's the most emotionally intelligent response?", // [cite: 453]
      options: [
        "Approach them privately, express concern, and offer to listen if they need to talk.", // [cite: 454]
        "Report their behavior to the supervisor right away.", // [cite: 456]
        "Wait until they speak up about their issue.", // [cite: 457]
        "Send a kind message checking in and offer small assistance if needed.", // [cite: 458]
      ],
      correctOptionIndex: 0, // [cite: 454]
      explanation:
      "This demonstrates high Emotional Intelligence and Teamwork. Showing genuine, private concern and offering support without being intrusive is the most empathetic approach.", // [cite: 455]
    ),
    Question(
      category: 'Emotional Intelligence',
      scenarioDescription:
      "You're leading a team meeting when two members start arguing over a miscommunication... Their voices get louder, and the discussion becomes personal. The rest of the team looks uncomfortable.", // [cite: 459, 460]
      questionText: "How should you handle this situation effectively?", // [cite: 461]
      options: [
        "Intervene calmly, remind them of the meeting's purpose, and suggest discussing it privately later.", // [cite: 462]
        "Let them continue arguing to release tension before returning to the agenda.", // [cite: 464]
        "End the meeting abruptly without addressing the issue.", // [cite: 465]
        "Interrupt firmly and assign blame to whoever started it.", // [cite: 466]
      ],
      correctOptionIndex: 0, // [cite: 462]
      explanation:
      "This is the best response for a leader, showing Emotional Intelligence and Communication. You are de-escalating the conflict, maintaining control of the meeting, and setting a professional boundary.", // [cite: 463]
    ),
    Question(
      category: 'Emotional Intelligence',
      scenarioDescription:
      "You've been feeling stressed about a tight project deadline. When a colleague asks for your help... you're tempted to snap... However, they genuinely seem lost and need quick guidance.", // [cite: 467, 468, 469]
      questionText: "What's the best approach?", // [cite: 469]
      options: [
        "Take a few seconds to compose yourself, then help briefly or schedule another time.", // [cite: 470]
        "Refuse abruptly and explain you're too busy.", // [cite: 472]
        "Ignore their request and focus on your own deadline.", // [cite: 473]
        "Agree to help immediately even if it worsens your stress.", // [cite: 474]
      ],
      correctOptionIndex: 0, // [cite: 470]
      explanation:
      "This shows high Emotional Intelligence and Communication. You are managing your stress (composing yourself) and finding a way to be a good teammate without sacrificing your own deadline.", // [cite: 471]
    ),
    Question(
      category: 'Emotional Intelligence',
      scenarioDescription:
      "A coworker takes credit during a presentation for an idea you originally suggested... Your manager praises them... You feel disrespected and angry but don't want to create conflict.", // [cite: 483, 484]
      questionText: "What should you do next?", // [cite: 485]
      options: [
        "Approach your coworker privately after the meeting to clarify and express how it made you feel.", // [cite: 486]
        "Interrupt during the presentation to point out it was your idea.", // [cite: 488]
        "Say nothing but start distancing yourself from them.", // [cite: 489]
        "Wait until one-on-one with your manager to explain your side calmly.", // [cite: 490]
      ],
      correctOptionIndex: 0, // [cite: 486]
      explanation:
      "This is the most emotionally intelligent response. It addresses the conflict directly with the person involved, in private, and focuses on your feelings ('how it made you feel') rather than just accusation.", // [cite: 487]
    ),
    Question(
      category: 'Emotional Intelligence',
      scenarioDescription:
      "You're collaborating with a teammate who tends to dominate discussions, often dismissing your input. During a planning session, they interrupt you once again... The rest of the group notices.", // [cite: 491, 492]
      questionText: "How should you manage your emotions and response?", // [cite: 493]
      options: [
        "Wait for them to finish, then politely assert your turn and share your thoughts clearly.", // [cite: 494]
        "Interrupt them back to show you deserve equal time.", // [cite: 496]
        "Avoid contributing to the discussion anymore.", // [cite: 497]
        "After the meeting, talk privately and express that you'd like to be heard equally.", // [cite: 498]
      ],
      correctOptionIndex: 0, // [cite: 494]
      explanation:
      "This demonstrates high Emotional Intelligence and Communication. You are managing your frustration, staying composed, and assertively (not aggressively) reclaiming your time to contribute.", // [cite: 495]
    ),
    Question(
      category: 'Emotional Intelligence',
      scenarioDescription:
      "Your supervisor assigns you to mentor a new hire who's struggling to meet expectations. You're already busy... The new hire looks nervous and discouraged.", // [cite: 500, 501, 502]
      questionText:
      "What's the best way to balance empathy with responsibility?", // [cite: 502]
      options: [
        "Support them by setting clear goals, offering feedback, and managing your time efficiently.", // [cite: 504]
        "Tell them you're too busy and ask someone else to help.", // [cite: 505]
        "Offer help only when you have free time.", // [cite: 506]
        "Encourage them with tips but make it clear they must learn independently.", // [cite: 507]
      ],
      correctOptionIndex: 0, // [cite: 504]
      explanation:
      "This is a balanced approach showing Emotional Intelligence and Teamwork. You are providing the structured support the intern needs while also being mindful of your own responsibilities.", // [cite: 504]
    ),
    Question(
      category: 'Emotional Intelligence',
      scenarioDescription:
      "After months of hard work, your project proposal gets rejected by upper management. You feel disappointed and demotivated... They're now looking to you for guidance on what to do next.", // [cite: 508, 509, 510]
      questionText:
      "How would you demonstrate emotional intelligence here?", // [cite: 510]
      options: [
        "Acknowledge your disappointment, thank the team for their effort, and refocus everyone on the next opportunity.", // [cite: 523]
        "Blame management for being unreasonable.", // [cite: 525]
        "Stay silent for days until you've processed your frustration.", // [cite: 526]
        "Tell the team to take a break until you can think of what's next.", // [cite: 527]
      ],
      correctOptionIndex: 0, // [cite: 523]
      explanation:
      "This response demonstrates high Emotional Intelligence and leadership. It validates the team's disappointment while resiliently and constructively refocusing them on future goals.", // [cite: 524]
    ),
  ];


  // ... (interviewGuides list remains the same)
  static List<Guide> interviewGuides = [
    Guide(
      icon: Icons.article_outlined,
      title: 'Job Interview Tips',
      subtitle:
      'Master your next job interview with tips that turn opportunities into offers',
      content: [
        Content(
          title: 'What is the STAR Method?',
          text:
          'The STAR method is a structured way of responding to behavioral interview questions by discussing a specific Situation, Task, Action, and Result of the situation you are describing. It provides a clear, concise, and compelling narrative for your answers.',
        ),
        Content(
          title: 'Situation',
          text:
          'Describe the context and background of the situation. Provide enough detail for the interviewer to understand the scenario, but keep it concise.',
        ),
        Content(
          title: 'Task',
          text:
          'Explain your role and responsibility in the situation. What was the goal or objective you were working towards? What was expected of you?',
        ),
        Content(
          title: 'Action',
          text:
          'Describe the specific steps you took to address the situation. What did you do? Why did you do it? Focus on "I" statements to highlight your personal contribution.',
        ),
        Content(
          title: 'Result',
          text:
          'Explain the outcome of your actions. What happened as a result of what you did? What did you learn? Quantify your results whenever possible to demonstrate impact.',
        ),
      ],
    ),
    Guide(
      icon: Icons.group_outlined,
      title: 'Teamwork and Collaboration',
      subtitle: 'Strategies for effective team collaboration and communication',
      content: [
        Content(
          title: 'Active Listening',
          text:
          'Pay full attention to what others are saying, both verbally and non-verbally. Show understanding through verbal and non-verbal cues. This helps in avoiding misunderstandings and building trust.',
        ),
        Content(
          title: 'Clear Communication',
          text:
          'Express your thoughts and ideas clearly and concisely. Use simple language and avoid jargon. Ensure that messages are understood by all team members to prevent errors and delays.',
        ),
        Content(
          title: 'Conflict Resolution',
          text:
          'Approach disagreements with a problem-solving mindset. Focus on the issue, not the person. Seek mutually agreeable solutions. This helps in maintaining a positive team environment.',
        ),
        Content(
          title: 'Constructive Feedback',
          text:
          'Provide feedback that is specific, timely, and focused on behavior rather than personal traits. Be open to receiving feedback yourself. This promotes continuous improvement and growth within the team.',
        ),
        Content(
          title: 'Respecting Diversity',
          text:
          'Value and respect different perspectives, backgrounds, and working styles. Embrace diversity as a strength that brings richer ideas and solutions to the team.',
        ),
      ],
    ),
    Guide(
      icon: Icons.lightbulb_outline,
      title: 'Problem-Solving Techniques',
      subtitle: 'Develop critical thinking and effective problem-solving skills',
      content: [
        Content(
          title: 'Define the Problem',
          text:
          'Clearly articulate the problem. What is happening? Who is affected? What are the symptoms? A well-defined problem is half-solved.',
        ),
        Content(
          title: 'Gather Information',
          text:
          'Collect all relevant data, facts, and opinions related to the problem. The more information you have, the better equipped you are to make informed decisions.',
        ),
        Content(
          title: 'Brainstorm Solutions',
          text:
          'Generate a wide range of potential solutions without judgment. Encourage creative and unconventional ideas. Quantity over quality at this stage.',
        ),
        Content(
          title: 'Evaluate Alternatives',
          text:
          'Assess each potential solution based on criteria such as feasibility, cost, impact, and time. Weigh the pros and cons of each option.',
        ),
        Content(
          title: 'Implement the Solution',
          text:
          'Put the chosen solution into action. Develop a clear plan with steps, responsibilities, and timelines. Monitor the implementation process.',
        ),
        Content(
          title: 'Review and Learn',
          text:
          'After implementation, evaluate the effectiveness of the solution. Did it solve the problem? What lessons were learned? Use this experience for future problem-solving.',
        ),
      ],
    ),
    Guide(
      icon: Icons.access_time_outlined,
      title: 'Time Management',
      subtitle: 'Strategies to maximize productivity and meet deadlines',
      content: [
        Content(
          title: 'Prioritize Tasks',
          text:
          'Use methods like the Eisenhower Matrix (Urgent/Important) to categorize and prioritize tasks. Focus on high-impact activities first.',
        ),
        Content(
          title: 'Set SMART Goals',
          text:
          'Ensure your goals are Specific, Measurable, Achievable, Relevant, and Time-bound. This provides clarity and direction.',
        ),
        Content(
          title: 'Avoid Multitasking',
          text:
          'Focus on one task at a time to improve concentration and efficiency. Switching between tasks frequently reduces productivity.',
        ),
        Content(
          title: 'Use Productivity Tools',
          text:
          'Leverage tools like calendars, to-do lists, and project management software to organize tasks and track progress effectively.',
        ),
        Content(
          title: 'Take Regular Breaks',
          text:
          'Short breaks can improve focus and prevent burnout. The Pomodoro Technique (25 minutes work, 5 minutes break) is a popular method.',
        ),
        Content(
          title: 'Delegate When Possible',
          text:
          'Identify tasks that can be assigned to others. Delegation frees up your time for more critical activities and empowers team members.',
        ),
      ],
    ),
  ];

  // Provide a categorized view of the situational judgement questions. This
  // infers a category for each Question using simple keyword matching and
  // returns a new list of Question instances that include the `category` field.
  // This is a non-destructive approach so we don't have to edit all entries
  // manually; the inference is conservative but effective for the current
  // dataset. If you prefer explicit tags, we can update each Question directly.
  static List<Question> get situationalJudgementQuestionsCategorized {
    String inferCategory(Question q) {
      final text = ('${q.questionText} ${q.scenarioDescription ?? ''}').toLowerCase();
      if (text.contains('team') || text.contains('teammate') || text.contains('teamwork') || text.contains('group')) {
        return 'Teamwork';
      }
      if (text.contains('present') || text.contains('email') || text.contains('manager') || text.contains('meeting') || text.contains('audience') || text.contains('communication') || text.contains('communicat')) {
        return 'Communication';
      }
      if (text.contains('client') || text.contains('process') || text.contains('task') || text.contains('deadline') || text.contains('issue') || text.contains('problem') || text.contains('invoice') || text.contains('optimi')) {
        return 'Problem-Solving';
      }
      if (text.contains('change') || text.contains('adapt') || text.contains('transfer') || text.contains('role') || text.contains('software') || text.contains('relocate') || text.contains('moved')) {
        return 'Adaptability';
      }
      // Fallback to Emotional Intelligence when no stronger clue is found.
      return 'Emotional Intelligence';
    }

    // Mapping from exact questionText to per-option points [A,B,C,D].
    // Build programmatically to avoid duplicate-key warnings when the same
    // questionText appears in multiple conceptual sections.
    final Map<String, List<int>> pointsMap = {};

    void add(String key, List<int> pts) => pointsMap.putIfAbsent(key, () => pts);

    // COMMUNICATION
    add("How should you respond?", [3, 2, 1, 0]);
    add("What would be the best way to handle this misunderstanding?", [3, 2, 1, 0]);
    add("What's the most effective way to continue?", [3, 2, 1, 0]);
    add("How should you handle the situation?", [3, 2, 1, 0]);
    add("How would you handle this communication gap?", [3, 2, 1, 0]);
    add("How could you keep their attention effectively?", [3, 1, 0, 2]);
    add("What's the most practical step you can take?", [3, 1, 0, 2]);
    add("How should you manage the situation?", [3, 0, 1, 2]);
    add("What's the best way to address this?", [3, 1, 2, 0]);
    add("How would you deliver the message effectively?", [3, 2, 1, 0]);

    // TEAMWORK
    add("What would be the best way to handle this conflict?", [3, 1, 0, 2]);
    add("How should you react?", [3, 1, 0, 2]);
    add("How would you handle this situation?", [3, 1, 0, 2]);
    add("What would you do to restore balance?", [3, 2, 0, 1]);
    add("What should be your first step?", [3, 2, 1, 0]);
    add("How would you support your team?", [3, 1, 0, 2]);
    add("What would you do?", [3, 1, 2, 0]);
    add("How should you handle this dynamic?", [3, 1, 2, 0]);
    add("What's the best way to keep the team focused?", [3, 0, 1, 2]);

    // PROBLEM-SOLVING
    add("What's your best move?", [3, 1, 0, 2]);
    add("What's the smartest way to proceed?", [3, 1, 0, 2]);
    add("What's the most reasonable response?", [3, 1, 0, 2]);
    add("How should you approach this?", [3, 1, 2, 0]);
    add("How do you resolve the inconsistency?", [3, 1, 0, 2]);

    // ADAPTABILITY / EMOTIONAL INTELLIGENCE
    add("What's the best way to respond?", [3, 1, 0, 2]);
    add("How would you approach this challenge?", [3, 1, 0, 2]);
    add("How should you handle this change?", [3, 1, 2, 0]);
    add("What's your best course of action?", [3, 1, 2, 0]);
    add("How should you adapt?", [3, 1, 0, 2]);
    add("How should you manage the situation effectively?", [3, 0, 1, 2]);
    add("How would you handle this unexpected obstacle?", [3, 1, 0, 2]);
    add("How should you react to this major change?", [3, 0, 1, 2]);
    add("How would you handle this transition?", [3, 1, 2, 0]);

    // EMOTIONAL INTELLIGENCE
    add("How should you respond in this situation?", [3, 1, 0, 2]);
    add("What would be the most appropriate way to handle this?", [3, 0, 1, 2]);
    add("How should you handle this situation effectively?", [3, 1, 0, 2]);
    add("What's the best approach?", [3, 1, 0, 2]);
    add("What's the best way to balance empathy with responsibility?", [3, 0, 1, 2]);
    add("How would you demonstrate emotional intelligence here?", [3, 0, 1, 2]);

    // End programmatic map build

    return situationalJudgementQuestions
        .map((q) {
          final defaultPoints = [3, 2, 1, 0];
          final mapped = pointsMap[q.questionText];
          final points = mapped ?? defaultPoints;
          return Question(
            questionText: q.questionText,
            scenarioDescription: q.scenarioDescription,
            options: List.of(q.options),
            correctOptionIndex: q.correctOptionIndex,
            explanation: q.explanation,
            // Prefer an explicit category on the original Question if present;
            // otherwise fall back to the conservative inference function. This
            // allows you to add `category: 'Teamwork'` (etc.) to individual
            // Questions later and guarantees exact per-category selection.
            category: q.category ?? inferCategory(q),
            optionPoints: points,
          );
        })
        .toList();
  }
}

// ---
// --- REMOVED ALL WIDGETS AND PAINTERS for Visual Diagrammatic Questions ---
// ---

