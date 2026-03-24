# TinySteps — Intern Task Plan (Parent Section)
**Sub-project Handler:** Parent Dashboard
**Team:** 5 Interns (Beginner level)
**Deadline:** Saturday, March 21, 2026
**Focus:** UI + Implementation of Parent Section

---

## 👥 Team Roles

| Person | Assignment |
|--------|------------|
| **You (Sub-handler)** | Code review, Supabase queries, unblocking interns |
| **Intern 1** | Shared Widgets — `ChildAvatar`, `StatusChip`, `EmptyState` |
| **Intern 2** | `parent_home_screen.dart` — Dashboard + QR Button |
| **Intern 3** | `child_profile_screen.dart` + `add_child_screen.dart` |
| **Intern 4** | `attendance_history_screen.dart` — Calendar + List |
| **Intern 5** | `BottomNavBar` widget + `QRDisplaySheet` + `parent_settings_screen.dart` |

---

## 📅 Day 1 — Tuesday, March 18 | Setup + Shared Components

### All Interns — Morning Setup (1–2 hrs)
1. Pull the latest project from the repo.
2. Run `flutter pub get` to ensure the app builds cleanly.
3. Install required packages:
   ```bash
   flutter pub add mobile_scanner qr_flutter table_calendar url_launcher intl
   ```
4. Read your assigned section in `dashboard_plan.md`.
5. Attend 15-min briefing by sub-handler: folder structure (`lib/features/parent/`), Supabase client usage, naming conventions.

---

### Intern 1 — Shared Widgets
**Location:** `lib/features/parent/widgets/` (or `lib/shared/widgets/`)

**Step 1 — `child_avatar.dart`**
- Accept `childName` (String) and optional `size` (double, default `48`)
- Extract initials (first letter of first + last name)
- Show a circular `Container` with Sunrise palette background color (cycle colors per child index)
- Center white bold initials text inside

**Step 2 — `status_chip.dart`**
- Accept a `status` string: `'At Home'`, `'Checked In'`, `'Checked Out'`
- Return a styled `Chip` or `Container`:
  - 🟢 Green → `Checked In`
  - 🔴 Red/Grey → `At Home`
  - 🔵 Blue → `Checked Out`

**Step 3 — `empty_state.dart`**
- Accept `message` (String) and optional `icon` (IconData)
- Return a centered `Column` with icon + styled message text

> ✅ **Done when:** All 3 widgets render without errors in a test screen.

---

### Intern 5 — BottomNavBar + QRDisplaySheet
**Step 1 — `bottom_nav_bar.dart`**
- 4 tabs: Home 🏠, My Children 🧒, Attendance 📋, Settings ⚙️
- Style: floating pill shape with `borderRadius` + drop shadow
- Highlight selected tab with Sunrise accent color

**Step 2 — `qr_display_sheet.dart`**
- A `showModalBottomSheet` widget that accepts `childId` (String) and `childName` (String)
- Render QR code using `qr_flutter`:
  ```dart
  QrImageView(
    data: jsonEncode({'child_id': childId, 'type': 'checkin'}),
    size: 240,
    backgroundColor: Colors.white,
  )
  ```
- Add child name label above QR and a "Close" button below

> ✅ **Done when:** Nav bar renders and switches tabs; QR sheet opens and shows a scannable code.

---

### Intern 2, 3, 4 — Afternoon
1. Create stub screen files (empty `Scaffold` with AppBar + placeholder text).
2. Re-read their assigned section in `dashboard_plan.md`.
3. Write all needed Supabase queries as comments in their screen files.

---

## 📅 Day 2 — Wednesday, March 19 | Core Screen Implementation

### Intern 2 — `parent_home_screen.dart`

**Step 1 — Greeting Card**
- Get `DateTime.now().hour`
- Display time-aware greeting:
  - 05–11 → Good morning 🌅
  - 12–14 → Good afternoon ☀️
  - 15–17 → Good evening 🌇
  - 18–04 → Good night 🌙
- Show parent name from Supabase auth user metadata

**Step 2 — Fetch Children + Build Cards**
```dart
supabase
  .from('children')
  .select('*, classrooms(name), teachers(full_name)')
  .eq('parent_id', supabase.auth.currentUser!.id)
```
- For each child, build a `Card` with `ChildAvatar`, name, age (calculated from DOB), and `StatusChip`

**Step 3 — Fetch Today's Attendance**
```dart
supabase
  .from('attendance')
  .select('child_id, checked_in_at, checked_out_at')
  .eq('date', DateTime.now().toIso8601String().split('T').first)
```
- Match results to children to set correct status

**Step 4 — "Show QR" Button**
- Coral/Sunrise styled `ElevatedButton`
- On tap → open `QRDisplaySheet(childId: child.id, childName: child.name)`
- If multiple children → show a selector dialog first

**Step 5 — Quick Info**
- Display teacher name + classroom name below child cards

> ✅ **Done when:** Screen loads with real data and QR sheet opens correctly.

---

### Intern 3 — `child_profile_screen.dart` + `add_child_screen.dart`

#### `child_profile_screen.dart`

**Step 1 — Fetch child data by `childId`:**
```dart
supabase
  .from('children')
  .select('*, classrooms(name), teachers(full_name)')
  .eq('id', childId)
  .single()
```

**Step 2 — Build editable form fields:**
- Full name, DOB (`showDatePicker`), gender (dropdown), allergies, medical notes
- Use a `TextEditingController` for each field

**Step 3 — Save button:**
```dart
supabase.from('children').update({
  'full_name': nameCtrl.text,
  'dob': selectedDob.toIso8601String(),
  'gender': selectedGender,
  'allergies': allergiesCtrl.text,
  'medical_notes': notesCtrl.text,
}).eq('id', childId)
```

**Step 4 — Display-only section:**
- Assigned Classroom + Teacher name (add note: "Assignment managed by admin")

---

#### `add_child_screen.dart`

**Step 1:** Build form with: name, DOB, gender, allergies, medical notes

**Step 2:** Validate all fields before submission

**Step 3 — Insert to Supabase:**
```dart
supabase.from('children').insert({
  'full_name': nameCtrl.text,
  'dob': selectedDob.toIso8601String(),
  'gender': selectedGender,
  'allergies': allergiesCtrl.text,
  'medical_notes': notesCtrl.text,
  'parent_id': supabase.auth.currentUser!.id,
})
```

**Step 4:** On success → show `SnackBar` "Child added! Awaiting classroom assignment." → navigate back

> ✅ **Done when:** Profile edits save correctly; Add Child inserts and navigates back.

---

### Intern 4 — `attendance_history_screen.dart`

**Step 1 — Child Selector**
- If parent has multiple children, show a `DropdownButton` or tab chips at the top

**Step 2 — Fetch attendance history:**
```dart
supabase
  .from('attendance')
  .select('date, checked_in_at, checked_out_at, method, teachers(full_name)')
  .eq('child_id', selectedChildId)
  .order('date', ascending: false)
```

**Step 3 — List View (default)**
- Each record as a card: date, check-in time, check-out time, method badge (QR/Manual), teacher name

**Step 4 — Calendar View (toggle)**
- Use `table_calendar` package
- Mark present days with a green dot
- On day tap → show that day's detail in a bottom sheet

**Step 5 — Monthly Summary Row**
- "X days present this month" — filter list by current month and count

> ✅ **Done when:** List shows real data, toggle works, calendar marks attendance days.

---

## 📅 Day 3 — Thursday, March 20 | My Children Screen + Settings + Integration

### Intern 3 — `my_children_screen.dart` (Tab 2)

**Step 1:** Fetch all children for current parent (same query as home screen)

**Step 2:** Build child list cards with `ChildAvatar`, name, DOB, classroom name
- Tap → navigate to `ChildProfileScreen(childId: child.id)`

**Step 3:** FAB `+` button → navigate to `AddChildScreen`

**Step 4:** If no children → show `EmptyState` with "No children added yet"

---

### Intern 5 — `parent_settings_screen.dart`

**Step 1 — Fetch parent profile:**
```dart
supabase.from('parents').select('*').eq('id', currentUserId).single()
```

**Step 2:** Display-only: full name, email, phone, emergency contact

**Step 3:** Editable fields: phone, emergency contact name + phone, with a Save button

**Step 4 — Logout button:**
```dart
await supabase.auth.signOut();
// Navigate to login screen
```

---

### Intern 2 — Wire Up Navigation Shell

**Step 1 — Create `parent_shell.dart`:**
- A `Scaffold` wrapping `BottomNavBar` + `IndexedStack` of 4 screens:
  1. `ParentHomeScreen`
  2. `MyChildrenScreen`
  3. `AttendanceHistoryScreen`
  4. `ParentSettingsScreen`

**Step 2:** Ensure data passes correctly between screens (e.g. `selectedChildId` to attendance history)

**Step 3:** Test all 4 tabs switch correctly and back button behaves properly

---

### Intern 4 — Error Handling + Loading States (all parent screens)

**Step 1:** Wrap all Supabase calls in `try/catch`

**Step 2:** Show `CircularProgressIndicator` while data is loading

**Step 3:** Show `EmptyState` widget if list is empty

**Step 4:** Show `SnackBar` on error: "Something went wrong. Please try again."

---

### Intern 1 — Widget Review + Polish

**Step 1:** Walk through all screens and confirm `ChildAvatar`, `StatusChip`, `EmptyState` are used wherever applicable

**Step 2:** Verify all colors match the Sunrise theme constants in the codebase

**Step 3:** Adjust padding and sizes for consistent spacing across screens

---

## 📅 Day 4 — Friday, March 21 | Testing + Polish + Handoff

### Morning — All Interns (Bug Fixing, 3 hrs)
Each intern:
1. Run the app and go through your assigned screens completely on an emulator/device
2. Fix: null pointer errors, UI overflow, data not loading, broken navigation
3. Remove all debug `print()` statements
4. Add comments to complex logic (Supabase queries, QR logic)
5. Ensure no hardcoded strings — use variables and constants

---

### You (Sub-handler) — Code Review Checklist
- [ ] Supabase queries always filter by `parent_id` / child owned by current user (RLS safe)
- [ ] No sensitive data is logged
- [ ] Widgets are reusable and accept parameters
- [ ] Navigation uses `Navigator.push` / `Navigator.pop` correctly
- [ ] All forms validate before submit
- [ ] Loading + error states exist on all data screens

---

### End-to-End Test Flow (Sub-handler + Intern 2)
1. Log in as a Parent user
2. ✅ Greeting shows correct time-based message
3. ✅ Child card shows correct status (At Home / Checked In / Checked Out)
4. ✅ "Show QR" → QR code displays and is scannable
5. ✅ My Children tab → list loads → tap child → profile screen opens
6. ✅ Edit child allergies → save → reload → change persists
7. ✅ Add Child → fill form → submit → appears in list
8. ✅ Attendance History → list loads → calendar toggle → days marked correctly
9. ✅ Settings → profile info shows → logout works

---

### Afternoon — Final Handoff (1 hr)
1. Merge all intern branches into the parent feature branch
2. Run `flutter analyze` and fix any warnings
3. Write a 5-sentence summary of what each screen does for the main project handler
4. App must launch and reach the parent dashboard without crashes — **demo ready**

---

## 📊 Quick Summary Table

| Day | Intern 1 | Intern 2 | Intern 3 | Intern 4 | Intern 5 |
|-----|----------|----------|----------|----------|----------|
| **Day 1** | Shared Widgets (Avatar, Chip, Empty) | Stub + plan Home screen | Stub + plan Profile/Add screens | Stub + plan Attendance screen | BottomNavBar + QR Sheet |
| **Day 2** | Polish widgets | Home screen (greeting, child cards, QR) | Profile edit + Add child form | Attendance list + calendar | Settings screen |
| **Day 3** | Review + integration support | Wire navigation shell | My Children tab (list + FAB) | Error handling + loading states | Settings screen polish |
| **Day 4** | Bug fix + cleanup | E2E testing | Bug fix + cleanup | Bug fix + cleanup | Bug fix + cleanup |

---

> 💡 **Sub-handler tip:** Check in with each intern at the **start and end of every day** (10 mins each).
> If any intern is blocked for more than **1 hour**, step in immediately — with a 4-day deadline, there is no buffer for long blocks.
