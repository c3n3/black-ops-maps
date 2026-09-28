# BO3 Custom zombies

Each folder in this repo is a custom zombies map, unless told to do so, work on one item at a time

## Design usage

- Design files located in <project>/ai/**
- When a design is first executed, mark the top of the file with a time in this format:
  - `January 1 2027 10:00pm`
- All designs should have a Q/A session initially
  - Append all questions and answers to a new `# Q/A` section at the bottom of the design
- Once a design is complete, the engineer may have corrections / fixes
  - Append all corrections / fixes to a new `# Corrections` section at the bottom of the design
- Do not add your descisions into the design plans. Only feedback from the user: Q/A + Corrections

## Rules

- When you are done working on a project, make / update a skills file in the proper location so you can re-read it and reduce AI usage
- When you start a task, search for a skills file first to make things faster
- Do not run `git commit`
- Use uv when possible in place of bare python commands
- Do not make assumptions, instead ask questions 'Q/A'

