# 🚀 TinySteps Intern Onboarding & 4-Day Plan

Welcome to the TinySteps team! We're thrilled to have you here. Over the next 4 days, you’re going to build out the **Parent Dashboard** of the TinySteps app. 

### 💡 Your Starting Point
We already have an early version of the **Parent Home Screen** (`lib/features/parent/screens/parent_home_screen.dart`). This file is your blueprint! If you look at it, you’ll notice:
1. **Design System:** It uses `AppColors`, `AppTextStyles`, `AppSpacing`, and `AppRadius`. Always use these across your new screens! Do not hardcode colors or fonts.
2. **Existing Widgets:** It has a `_ChildAvatar` and a `_QuickActionCard` built-in right now.
3. **Supabase Example:** It shows how to get the current user and how to sign out.

Here is exactly what you need to do over the next 4 days. If you ever get stuck for more than 1 hour, immediately ask your project handler for help!

---

## 📅 Day 1: Setup & Foundations (Tuesday)

**Goal:** Get your environment running and extract our shared components so everyone can use them.

### All Interns: Morning Setup (1-2 Hours)
1. Pull the latest project from Git.
2. Open terminal and run: `flutter pub add mobile_scanner qr_flutter table_calendar url_launcher intl`
3. Run `flutter pub get` and ensure the app builds on your emulator.

### **Intern 1: Shared Widgets**
Your job is to build the LEGO blocks everyone else will use. Take the private widgets inside `parent_home_screen.dart` and make them public!
- **Task 1:** Create `lib/features/parent/widgets/child_avatar.dart`. Move `_ChildAvatar` here and rename it to `ChildAvatar`. Make it accept the `size` property. 
- **Task 2:** Create `status_chip.dart`. This is a little UI badge. Make it green for "Checked In", red/grey for "At Home", and blue for "Checked Out".
- **Task 3:** Create `empty_state.dart`. Just a simple column with an icon and text for when a list has nothing to show yet.

### **Intern 5: Navigation & QR Modal**
- **Task 1:** Create a `BottomNavBar` with 4 tabs (Home, My Children, Attendance, Settings). Make it look like a floating pill using `BoxDecoration` and shadows.
- **Task 2:** Create a `qr_display_sheet.dart`. It should be a bottom sheet that shows a QR code using the `qr_flutter` package.

### **Interns 2, 3 & 4:**
Create blank files for your screens. Put a simple `Scaffold` with an `AppBar` in each so the app doesn't break when we try to navigate! Look at the queries listed in the main plan and paste them into your code as comments so they are ready for Day 2.

---

## 📅 Day 2: Core Screens (Wednesday)

**Goal:** Fetch real data from Supabase and show it on the UI.

### **Intern 2: Parent Home Screen** 
*You're working in the existing `parent_home_screen.dart` file.*
- **Task 1:** Make the greeting dynamic. Use `DateTime.now().hour` to say "Good morning", "Good afternoon", etc., instead of just "Hello".
- **Task 2:** Update the "Children List" to fetch real child data from Supabase instead of the hardcoded Leo and Mia. Build a list of `Card` widgets using Intern 1's `ChildAvatar`.
- **Task 3:** Wire up the "Show My QR Code" button to open Intern 5's QR bottom sheet.

### **Intern 3: Managing Children Profiles**
*You are building two screens to manage child data.*
- **Task 1 (`child_profile_screen.dart`):** Fetch a single child's data. Build a form so the parent can edit Name, Date of Birth, Gender, Allergies, and Medical Notes. Add a "Save" button to update Supabase.
- **Task 2 (`add_child_screen.dart`):** Create the exact same form, but empty. When the parent hits "Save", insert a new row into the `children` table in Supabase.

### **Intern 4: Attendance History**
*You are building the screen that shows when the child checked in/out.*
- **Task 1 (`attendance_history_screen.dart`):** Fetch attendance data from Supabase for the selected child.
- **Task 2:** Build a simple List View showing Date, Check-In time, Check-Out time, and the Teacher's Name doing the scanning.

---

## 📅 Day 3: Integration & Settings (Thursday)

**Goal:** Connect all the screens together so it feels like a real app.

### **Intern 3: "My Children" Tab**
- Build `my_children_screen.dart` which just lists all the parent's children. Tap a child to go to their profile screen. Add a `+` Floating Action Button to go to the Add Child screen.

### **Intern 5: Parent Settings Screen**
- Build `parent_settings_screen.dart`. Fetch the parent's profile and show their Name, Email, and Phone.
- Put a "Logout" button at the bottom. The code to log out is already inside `parent_home_screen.dart`! Just copy it over.

### **Intern 2: Wire up the Navigation**
- Take Intern 5's `BottomNavBar` and wrap all the screens together into one `parent_shell.dart`. Ensure switching tabs works perfectly without breaking the app.

### **Intern 4: Loading & Errors**
- Go through everyone's screens. If a screen is fetching data from Supabase, add a `CircularProgressIndicator()` so the user knows it's loading. If an error happens, show a red `SnackBar` message.

---

## 📅 Day 4: Bug Fixing & Play-testing (Friday)

**Goal:** Test every button, fix every bug, and prepare for code review. You should have a fully working, demo-ready app by the afternoon.

**Morning Bug Hunt (Everyone):**
1. Run the app on an Android emulator or iPhone Simulator.
2. Click every single button. Does it crash? Look at your console!
3. Check for exact colors. Are you using `AppColors.success` instead of `Colors.green`?
4. Clean your code: delete old commented-out code and `print()` statements.

**Afternoon Review:**
1. The project handler will review your code. We will ensure all Supabase queries are secure.
2. We will merge all your code together into the main app.
3. You will each write a short summary of what you learned and what your screen does.

---

## 🌳 Git Branching & Merge Order (Crucial!)

To prevent merge conflicts, we will use a strict order for merging code into the main branch. **Do not merge your own code.** Open a Pull Request (PR) and the Sub-handler will review and merge it.

**Naming your branch:** `feature/parent-yourname-task` (e.g., `feature/parent-john-widgets`)

### 🥇 Priority 1: The Foundation (Day 1/2)
These must be reviewed and merged **first** before anyone else's code can use them.
1. **Intern 1:** Shared Widgets (`ChildAvatar`, `StatusChip`, `EmptyState`).
   * *Why:* Interns 2, 3, and 4 need these widgets to build their screens.
2. **Intern 5:** `BottomNavBar` & `QRDisplaySheet`.
   * *Why:* Intern 2 needs the QR modal for the Home screen, and the Nav Bar is needed to wire up the app shell.

> **What the rest of the team does while waiting:** Interns 2, 3, and 4 should build their screens using standard Flutter widgets (like a plain `Text` or `Container`) as placeholders. Once Intern 1 & 5's code is merged into `main`, pull the latest `main` branch and replace your placeholders with the real custom widgets.

### 🥈 Priority 2: Standalone Screens (Day 2/3)
Once the foundation is merged, these screens can be built and merged in any order because they don't overlap much.
* **Intern 3:** `child_profile_screen.dart` and `add_child_screen.dart`
* **Intern 4:** `attendance_history_screen.dart`
* **Intern 5:** `parent_settings_screen.dart`

### 🥉 Priority 3: The Integrators (Day 3/4)
These files touch multiple areas and should be merged **last** to avoid conflicts.
1. **Intern 3:** `my_children_screen.dart` (depends on the add/profile screens existing to link to them).
2. **Intern 2:** `parent_home_screen.dart` (depends on the QR modal existing).
3. **Intern 2:** `parent_shell.dart` (The master navigation file — must be merged absolute last, as it imports every single screen built by the team).

---

### 🚨 Golden Rules for this Week
1. **Never block on a problem:** If you're stuck on a red error screen for more than 1 hour, **ASK FOR HELP**. That's what we are here for!
2. **Use the Design System:** Don't guess paddings or colors. Type `AppSpacing.` or `AppColors.` and let your IDE show you the options.
3. **Work as a Team:** Interns 2, 3, and 4 are depending on Interns 1 and 5 completing their widgets first! Communicate on Slack/Teams when your pieces are ready.

Good luck, squad! Let's build something awesome. 🚀
