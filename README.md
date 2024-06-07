# YouTube Video Sharing App

## Introduction

This application provides a platform for users to share their favorite YouTube videos with others. Whether it's an entertaining clip, a tutorial, or an inspiring talk, users can easily discover and share content that resonates with them.

### Main Features:
- Login/Logout: Users can securely log in and out of the platform. If a user doesn't have an account, they can quickly register to gain access to all features.

- List of Shared Videos: Explore a curated list of videos shared by users. Discover new content across various categories and genres.

- Share YouTube Videos: Share YouTube videos directly within the app. Whether it's a captivating story, a thought-provoking documentary, or a helpful tutorial, users can share content they find interesting or valuable.

- Real-time Notifications: Stay updated with real-time notifications. Receive alerts when someone shares a video, ensuring you never miss out on the latest content.

- Direct Video Playback: Enjoy seamless video playback directly within the app. With integrated YouTube support, users can watch videos without leaving the platform, providing a seamless viewing experience.

## Prerequisites

- Ruby (3.3.1)
- Rails (7.1.3.3)
- PostgreSQL 14.12
- Firebase Realtime Database
- YouTube Data API v3

## Installation & Configuration

1. Clone the repository:

```
git clone https://github.com/andreephan/ytb-sharing-backend.git
```

2. Navigate to the project directory:
```
cd ytb-sharing-backend
```

3. Create `.env` file from sample and fill coresponding value:
```
cp .env_sample.erb .env
```

4. Install dependencies:
```
bundle install
```

5. Setup database:
```
rails db:create
rails db:migrate
```

6. Start server:
```
rails server
```

Run Rspec:
```
rspec
```
