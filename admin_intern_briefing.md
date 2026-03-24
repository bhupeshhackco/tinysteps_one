# 🛡️ TinySteps — Admin Section | Your Task Guide
**Your Role:** UI Builder (Beginner Intern)
**Deadline:** Saturday, March 22, 2026
**Section:** Admin Dashboard

---

## 👋 Before You Start

You are building the **visual side** of the Admin Dashboard. Your job is to make the screens look correct. Your project handler will later connect your UI to real data from Supabase.

### Two Important Rules
1. **Never use hardcoded colors** like `Colors.green` or `Colors.blue`. Always use `AppColors.*`.
2. **Never use hardcoded spacing** like `SizedBox(height: 16)`. Always use `AppSpacing.*`.

> Type `AppColors.` or `AppSpacing.` in your editor and the IDE will show you all available options.

---

## 📂 Your Files

You will create these files **inside** `lib/features/admin/`:

| File | Where |
|------|-------|
| `admin_home_screen.dart` | `lib/features/admin/screens/` |
| `classrooms_screen.dart` | `lib/features/admin/screens/` |
| `referral_codes_screen.dart` | `lib/features/admin/screens/` |
| `admin_settings_screen.dart` | `lib/features/admin/screens/` |

---

## 📅 Day 1 — Setup + Admin Home Screen UI

### Step 1: Environment Setup (Morning, 30 min)
1. Pull the latest project from Git.
2. Open terminal and run: `flutter pub get`
3. Run the app on your emulator. Make sure it opens without errors.
4. Ask your project handler if anything does not work.

---

### Step 2: Create Your Screen Files (Stubs)
Create all 4 files listed in the table above. For each file, put this exact starting code so the app doesn't break:
```dart
import 'package:flutter/material.dart';
import '../../../core/constants/app_theme.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      appBar: AppBar(title: Text('Admin Home', style: AppTextStyles.heading2)),
      body: const Center(child: Text('Coming soon...')),
    );
  }
}
```
> Change the class name and title for each file (e.g., `ClassroomsScreen`, `ReferralCodesScreen`, `AdminSettingsScreen`).

---

### Step 3: Build the Admin Home Screen UI
**File:** `admin_home_screen.dart`

Replace the `body` with a `Padding` + `Column` containing the following sections in order from top to bottom:

#### Section A — Greeting Card
```dart
Text('Good morning, Admin! 🌅', style: AppTextStyles.heading1),
Text('Here\'s what\'s happening today.', style: AppTextStyles.bodyMuted),
const SizedBox(height: AppSpacing.lg),
```
> Note: The greeting text will be made dynamic by your project handler later. Just hardcode this for now.

#### Section B — Stats Grid (4 cards in a 2×2 grid)
Use a `GridView.count` with `crossAxisCount: 2`:
```dart
GridView.count(
  crossAxisCount: 2,
  shrinkWrap: true,
  physics: const NeverScrollableScrollPhysics(),
  crossAxisSpacing: AppSpacing.md,
  mainAxisSpacing: AppSpacing.md,
  childAspectRatio: 1.4,
  children: [
    _StatCard(label: 'Total Teachers', value: '0', color: AppColors.primary),
    _StatCard(label: 'Pending Approvals', value: '0', color: AppColors.secondary),
    _StatCard(label: 'Total Parents', value: '0', color: AppColors.success),
    _StatCard(label: 'Total Children', value: '0', color: AppColors.accent),
  ],
),
```

Build the `_StatCard` private widget:
```dart
class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _StatCard({required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.12),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(value, style: AppTextStyles.heading1.copyWith(color: color)),
          const SizedBox(height: 4),
          Text(label, style: AppTextStyles.bodyMuted),
        ],
      ),
    );
  }
}
```

#### Section C — Quick Actions Row
After the grid, add a section header and 3 action buttons:
```dart
const SizedBox(height: AppSpacing.lg),
Text('Quick Actions', style: AppTextStyles.heading2),
const SizedBox(height: AppSpacing.md),
Wrap(
  spacing: AppSpacing.sm,
  children: [
    _ActionChip(icon: Icons.card_membership, label: 'Referral Code', color: AppColors.secondary),
    _ActionChip(icon: Icons.school, label: 'Add Classroom', color: AppColors.primary),
    _ActionChip(icon: Icons.bar_chart, label: 'Attendance Report', color: AppColors.success),
  ],
),
```

Build the `_ActionChip` private widget:
```dart
class _ActionChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _ActionChip({required this.icon, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      avatar: Icon(icon, color: color, size: 18),
      label: Text(label, style: AppTextStyles.labelBold.copyWith(color: color)),
      backgroundColor: color.withValues(alpha: 0.1),
      side: BorderSide(color: color.withValues(alpha: 0.3)),
      onPressed: () {},
    );
  }
}
```

> ✅ **Day 1 Done When:** Admin home screen renders with the greeting, the 4 stat cards showing "0", and the 3 action chips.

---

## 📅 Day 2 — Classrooms Screen UI

**File:** `classrooms_screen.dart`

### Step 1 — Classrooms List
Replace the `body` with a `ListView.builder`. Use placeholder data for now:

```dart
final _placeholderClassrooms = [
  {'name': 'Sunshine Room', 'ageGroup': '2-3 years', 'teacher': 'Ms. Sarah', 'count': 12, 'capacity': 20},
  {'name': 'Rainbow Room', 'ageGroup': '3-4 years', 'teacher': 'Unassigned', 'count': 8, 'capacity': 15},
];
```

For each classroom, build a `Card` containing:
- **Row 1:** Classroom name (bold) + Age group (muted)
- **Row 2:** Teacher name with a person icon
- **Row 3:** "12 / 20 children" text
- **Row 4:** A `LinearProgressIndicator` showing `value: count / capacity`
  - Use `color: AppColors.primary` and `backgroundColor: AppColors.primary.withValues(alpha: 0.1)`

When the card is tapped, open a detail bottom sheet (Step 2).

### Step 2 — Add Classroom FAB
Add a `FloatingActionButton` in the bottom-right corner:
```dart
floatingActionButton: FloatingActionButton(
  onPressed: () {},
  backgroundColor: AppColors.primary,
  child: const Icon(Icons.add, color: AppColors.white),
),
```

### Step 3 — Classroom Detail Bottom Sheet
When a classroom card is tapped, open a `showModalBottomSheet`. Inside the sheet, build:
1. A title: "Edit Classroom" using `AppTextStyles.heading2`
2. A `TextFormField` for Classroom Name (pre-filled with the classroom's name)
3. A `TextFormField` for Age Group
4. A `TextFormField` for Capacity (keyboard type: number)
5. A `DropdownButton` for Teacher — use the placeholder list `["Ms. Sarah", "Mr. John", "Unassigned"]`
6. A divider + subtitle "Children in this classroom"
7. A placeholder `Text('No children assigned yet', style: AppTextStyles.bodyMuted)`
8. A full-width `ElevatedButton('Save Changes', onPressed: () {})`

> ✅ **Day 2 Done When:** Classrooms list renders with placeholder data and capacity bars. Tapping a card opens the detail bottom sheet with the form.

---

## 📅 Day 3 — Referral Codes UI + Settings Screen

### Referral Codes UI
**File:** `referral_codes_screen.dart`

This screen is opened as a modal bottom sheet from the Home screen's "Referral Code" action chip. Build it as a regular screen for now (your project handler will convert it to a sheet later).

#### Section A — Generate Code Form
1. A title: "Generate Referral Code" using `AppTextStyles.heading2`
2. `DropdownButton` for Role — options: `["Parent", "Teacher", "Admin"]`
3. A `TextButton` row: `"📅 Pick Expiry Date"` — when tapped, open `showDatePicker`. Display the chosen date next to the button as text.
4. A full-width `ElevatedButton('Generate Code', onPressed: () {})`

#### Section B — Existing Codes List
Add a `Divider` below the button, then a subtitle "Existing Codes". Build a `ListView` with placeholder codes:

```dart
final _placeholderCodes = [
  {'code': 'TINY-4821', 'role': 'Parent', 'status': 'Active', 'expires': '2026-03-25'},
  {'code': 'TINY-3350', 'role': 'Teacher', 'status': 'Used', 'expires': '2026-03-18'},
  {'code': 'TINY-7712', 'role': 'Admin', 'status': 'Expired', 'expires': '2026-03-10'},
];
```

For each code, build a `ListTile`:
- **Title:** Code text in bold (e.g., `TINY-4821`)
- **Subtitle:** Role + expiry date
- **Trailing:** A status chip — green for Active, grey for Used, red for Expired

---

### Admin Settings Screen
**File:** `admin_settings_screen.dart`

1. Fetch admin name/email from: `Supabase.instance.client.auth.currentUser?.userMetadata`
2. Show a profile section at the top:
   - A `CircleAvatar` with the first initial of the admin's name
   - Name in bold below it
   - Email in muted text
3. A `Divider`
4. A `ListTile` with icon `Icons.info_outline` and title `"App Version: 1.0.0"`
5. A red `TextButton` at the bottom: "Logout"
   ```dart
   onPressed: () async {
     await Supabase.instance.client.auth.signOut();
   }
   ```

> ✅ **Day 3 Done When:** Referral codes screen shows the form and placeholder code list. Settings screen shows profile info and logout button.

---

## 📅 Day 4 — Bug Fixing & Cleanup

### Morning — Self-Test Checklist
Go through every screen you built and check each item:
- [ ] Does every screen open without a red error screen?
- [ ] Are all colors using `AppColors.*` — no plain `Colors.green` anywhere?
- [ ] Are all paddings using `AppSpacing.*` — no hardcoded numbers?
- [ ] Do all `DropdownButton` widgets have a proper label?
- [ ] Does the Settings screen show the logout button?
- [ ] Does the Classrooms detail sheet open when you tap a card?
- [ ] Does the Date Picker open when you tap "Pick Expiry Date"?
- [ ] Do any texts overflow or get cut off on a small screen?

### Afternoon — Handoff
1. Remove all `print()` statements from your code.
2. Add a one-line comment above each section of your code explaining what it does.
3. Open a Pull Request with the title: `feat/admin-ui-screens`
4. Write a short description of which screens you built and any known issues.

---

> 🚨 **Reminder:** If you are stuck on any error for more than **1 hour**, immediately ask your project handler. Don't spend time guessing! There is no shame in asking.
