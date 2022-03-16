# A2S Case Management System

A case management system that allows customers to submit cases via web or email and for consulants to view these cases, implement solutions and resolve the cases. Case management and a knowledge base are the two key features for this solution.

### Case Management

A case management system with the following functionalities:
- Web-to-case
- Email-to-case
- Automatic case assignment by Industry or Product

### Solution Knowledge Base

- Store solutions to common issues for easy acccess by consultants
- FAQ section with search capabilities for previously resolved issues

## How to Install

Make sure to start from a brand-new environment to avoid conflicts with previous work you may have done.

### Unlocked Package

1. Log in to your org.
2. Click this link to install the A2S Case Management unlocked package in your org.
3. Select **Install for All Users**.

### Salesforce CLI

1. Clone this repository:
```
git clone https://github.com/atosdk/A2S.git
cd A2S
```
2. Authorise with your Trailhead Playground or Developer org and provide it with an alias:
```
sfdx auth:web:login -s -a <alias>
```
3. Run this command in a terminal to deploy the app:
```
sfdx force:source:deploy -p force-app
```

## Team
- Jess
- David
- Miron
- Jack
