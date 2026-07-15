# ✉️ Envelope

> **A University Postal System built for BRAC University students.**
>
> Write meaningful letters, attach an optional Polaroid, and send them through a real postal workflow instead of instant messaging.

---

# 📖 Overview

Envelope is a university-exclusive letter delivery platform where students exchange physical-style letters through a Central Post Office.

Unlike messaging apps, letters are **not delivered instantly**.

Every letter follows a real postal journey:

```
Write Letter
      │
      ▼
Save Draft
      │
      ▼
Scan Central Post Office QR
      │
      ▼
Stored at Central Post Office
      │
      ▼
Volunteer Mailman Claims Letter
      │
      ▼
Find Recipient
      │
      ▼
Scan Recipient QR
      │
      ▼
Delivered
      │
      ▼
Recipient Opens Letter
```

The goal is to recreate the excitement and anticipation of traditional mail inside a university campus.

---

# 🎯 Features

## Authentication

- Student Registration
- Login / Logout
- Email Verification
- Profile Creation

---

## Letter System

- Write Letters
- Save Drafts
- 300 Word Limit
- Anonymous Letters
- Optional Polaroid
- Stamp Selection

---

## Postal System

- Central Post Office
- QR Drop-off
- Volunteer Mailmen
- Manual Delivery
- Recipient QR Verification

---

## Collections

- Stamp Collection
- Letter History
- Notifications
- User Profiles

---

## Future Features

- Ghost Letters
- Dead Letters
- Seasonal Stamps
- Achievements
- Daily Tasks
- Campus Events
- Leaderboards

---

# 🏛 Tech Stack

## Frontend

- HTML
- CSS
- JavaScript

## Backend

- Supabase

## Database

- PostgreSQL

## Storage

- Supabase Storage

## Authentication

- Supabase Auth

---

# 📂 Project Structure

```
Envelope/

│
├── frontend/
│   ├── css/
│   ├── js/
│   ├── images/
│   ├── index.html
│   └── dashboard.html
│
├── database/
│   ├── 001_extensions_and_enums.sql
│   ├── 002_profiles.sql
│   ├── 003_qr_codes.sql
│   ├── 004_postal_hubs.sql
│   ├── 005_stamps.sql
│   ├── 006_letters.sql
│   ├── 007_letter_history.sql
│   ├── 008_notifications.sql
│   ├── 009_attachments.sql
│   ├── 010_reports.sql
│   ├── 011_settings.sql
│   ├── 012_functions.sql
│   ├── 013_triggers.sql
│   └── 014_rls.sql
│
├── docs/
│
└── README.md
```

---

# 🗄 Database

Main Tables

- profiles
- qr_codes
- postal_hubs
- letters
- letter_history
- stamps
- user_stamps
- attachments
- notifications
- reports
- system_settings

---

# ✉ Letter Rules

- Maximum **300 words**
- Optional **1 Polaroid**
- One stamp per letter
- Draft support
- Anonymous option
- QR delivery only

---

# 📮 Postal Workflow

```
Draft

↓

Central Post Office

↓

Waiting

↓

Claimed

↓

In Delivery

↓

Delivered

↓

Opened
```

---

# 🚀 Development Roadmap

## Phase 1

- [x] Authentication
- [x] Database
- [x] User Profiles

## Phase 2

- [ ] Letter Composer
- [ ] Drafts
- [ ] Stamp Selection
- [ ] Polaroid Upload

## Phase 3

- [ ] Inbox
- [ ] Sent Letters
- [ ] Notifications

## Phase 4

- [ ] QR Drop-off
- [ ] Volunteer Mailman Dashboard
- [ ] Delivery Workflow

## Phase 5

- [ ] Ghost Letters
- [ ] Dead Letters
- [ ] Achievements
- [ ] Campus Events

---

# 👥 Team

Developed as a Software Engineering project.

```
Contributors
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!- Fahim -!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!- sabik -!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!- karna -!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!- shounok -!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

---

# 📜 License

This project is developed for academic purposes.
