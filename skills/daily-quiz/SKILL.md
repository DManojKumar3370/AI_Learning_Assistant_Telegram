# SKILL: Daily Tech Brief and Quiz Generation

## GOAL
Your goal is to generate a high-quality, personalized daily tech brief for a user and send it via Telegram. The brief must contain exactly 5 interview questions and 3-5 technical tidbits, all tailored to the user's stored preferences.

## CONTEXT
This skill is triggered automatically by a cron job every evening at 9 PM in the user's local timezone. You have access to the user's stored profile, which contains their technical domains, experience level, learning goals, and timezone.

## GENERATION WORKFLOW

### Step 1: Retrieve User Profile
- Use the `memory_store` tool to fetch the user's profile using their ID (e.g., key: `user_profile_{{user.id}}`).
- Verify that the profile exists and contains all required fields: `domains`, `level`, `goals`, and `timezone`.
- If the profile doesn't exist, stop and inform the user that they need to complete onboarding first.

### Step 2: Conduct Intelligent Web Search
- Perform targeted `web_search` queries for each of the user's specified domains.
- **Search Strategy:**
  - For each domain, craft a specific search query focused on recent developments, best practices, or trending topics.
  - Examples:
    - For "Go": `"Go programming language performance optimization 2024"`
    - For "distributed systems": `"distributed systems design patterns latest trends"`
    - For "machine learning": `"machine learning prompt engineering best practices"`
  - Include freshness indicators in your search (e.g., "2024", "latest", "recent").
  - Perform 1-2 searches per domain to gather diverse content.
- Prioritize results that are recent, authoritative, and aligned with the user's experience level.

### Step 3: Synthesize Technical Tidbits
- Based on the search results, extract and synthesize 3 to 5 interesting technical tidbits.
- **Criteria for Tidbits:**
  - **Accuracy:** Ensure the fact is technically correct and verifiable.
  - **Relevance:** Must relate to the user's domains and be useful for their learning goals.
  - **Novelty:** Present fresh insights, not generic or well-known facts.
  - **Clarity:** Written concisely (1-2 sentences), easily understood on a mobile device.
  - **Actionability:** Ideally, tidbits should be insights the user can apply or think about.
- **Examples of Good Tidbits:**
  - "Go's memory model guarantees visibility: writes happen-before all subsequent reads on the same channel."
  - "Claude 3.5 Sonnet now achieves 92% on SWE-bench, surpassing GPT-4 on code understanding tasks."
  - "Container orchestration best practice: always set resource requests and limits to prevent node starvation."

### Step 4: Generate Interview Questions
- Generate exactly 5 interview questions adhering to the following criteria:
  - **Relevance:** All questions must relate to the user's specified `domains`.
  - **Difficulty Calibration:**
    - **Junior:** Fundamental concepts, basic algorithms, explanatory questions.
    - **Mid-level:** Practical problem-solving, design decisions, edge cases.
    - **Senior:** System design, trade-offs, architecture, leadership scenarios.
    - **Staff:** Scaling challenges, organizational impact, complex multi-system thinking.
  - **Variety:** Include a mix of question types:
    - 1-2 Conceptual Questions (e.g., "What is the difference between...?")
    - 1-2 Coding/Algorithmic Questions (e.g., "How would you implement...?")
    - 1 System Design Question (e.g., "Design a system that...")
    - 0-1 Behavioral/Open-Ended Question (e.g., "Tell us about a time...")
  - **Novelty:** Do not repeat questions from previous days. Use memory to track recently asked topics.
  - **Clarity:** Questions should be clear, specific, and answerable in 5-10 minutes.
  - **Interview-Relevant:** Questions should be typical of technical interviews for the user's level.
- **Examples:**
  - Junior/Go: "Explain how goroutines differ from OS threads and why Go's scheduler is efficient."
  - Mid-level/Distributed Systems: "How would you implement a consensus algorithm for a replicated state machine?"
  - Senior/System Design: "Design a globally distributed cache that maintains consistency across regions."

### Step 5: Format the Message
- Assemble the final message using Telegram's Markdown formatting for optimal readability.
- Follow this exact structure:

```
🦞 *Your Daily Tech Brief* — [Today's Date]

━━━━━━━━━━━━━━━━━━━━
🧠 *Interview Questions*
━━━━━━━━━━━━━━━━━━━━

*Q1: [Question Type — Domain]*
[Full question text here. Make it clear and specific.]

*Q2: [Question Type — Domain]*
[Full question text here.]

*Q3: [Question Type — Domain]*
[Full question text here.]

*Q4: [Question Type — Domain]*
[Full question text here.]

*Q5: [Question Type — Domain]*
[Full question text here.]

━━━━━━━━━━━━━━━━━━━━
💡 *Today's Tidbits*
━━━━━━━━━━━━━━━━━━━━

• [Tidbit 1: A concise, actionable technical insight or recent development]

• [Tidbit 2: Another valuable piece of information]

• [Tidbit 3]

• [Tidbit 4 (optional if only 4 tidbits)]

• [Tidbit 5 (optional if only 5 tidbits)]

━━━━━━━━━━━━━━━━━━━━
Reply *answers* to get feedback, or *more* for extra questions.
```

- **Formatting Guidelines:**
  - Use `*text*` for bold (titles, question numbers).
  - Use `━` for visual separators.
  - Use emoji (🦞, 🧠, 💡) for visual appeal and categorization.
  - Ensure questions are readable on mobile (not too long).
  - Date format: Use the user's local date (e.g., "May 22, 2024").

### Step 6: Send the Message
- Send the formatted message to the user via Telegram.
- Include an error handling note: If sending fails, log the error and attempt to notify the user.

## CONSTRAINTS
- **Quality Over Quantity:** The accuracy and relevance of questions and tidbits are paramount. Do not sacrifice quality for speed.
- **Autonomy:** This entire process must be autonomous. Do not ask for user clarification; make informed decisions based on the profile.
- **Timing:** Respect the user's timezone. The job must execute at exactly 9 PM in their local timezone.
- **Consistency:** The message structure and formatting must be consistent daily.
- **Search Freshness:** Prioritize recent content (within the last 1-3 months) unless the user is learning about foundational topics.
- **Error Handling:** If any step fails (e.g., profile missing, search results empty), handle gracefully:
  - Missing profile: Prompt user to complete onboarding.
  - No search results: Generate questions based on general knowledge in the domain.
  - Empty results: Use fallback content but acknowledge to the user that results were limited.

## DAILY VARIABILITY GUIDELINES
- Change question types and domains daily to maintain engagement.
- Track previously asked topics in memory to avoid repetition.
- If the user has expressed interest in "interview preparation," prioritize realistic interview questions.
- If the user is "staying up-to-date," include more news and trend-focused tidbits.

## SUCCESS CRITERIA
✓ Retrieves user profile successfully
✓ Performs 1-2 web searches per domain
✓ Generates exactly 5 interview questions appropriate to user's level
✓ Synthesizes 3-5 high-quality technical tidbits
✓ Formats message correctly with Markdown and emoji
✓ Sends message to user via Telegram
✓ Message is mobile-friendly and readable
