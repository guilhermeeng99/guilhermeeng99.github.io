# Output Format Guide for Widget Optimization

## 🎯 Golden Rule

**Show ONLY the changes, NOT the complete code.**

When the AI optimizes a widget:
1. ✅ **Apply the edits** using `replace_string_in_file` tool
2. ✅ **Show a summary** of what was changed
3. ✅ **Display metrics tables** (before/after)
4. ❌ **NEVER show** the full modified code

---

## 📋 Required Output Structure

Your optimization response MUST include these 5 sections in order:

### 1️⃣ Summary of Changes (Required)

```
✅ Optimization Complete: [filename.dart]

📝 Changes Applied:
• [Description] (Line X-Y)
• [Description] (Line X-Y)
• [Description] (Line X-Y)

🔧 Tools Used:
• replace_string_in_file (N edits)
```

**Example:**
```
✅ Optimization Complete: bottom_bar_shadow.dart

📝 Changes Applied:
• Removed Opacity widget wrapper (Line 9-11)
• Extracted LinearGradient to _kBottomBarGradient constant (Line 3-14)
• Replaced Container with SizedBox + DecoratedBox (Line 20-26)
• Converted .withOpacity() to hex alpha colors (Line 7-8)

🔧 Tools Used:
• replace_string_in_file (1 edit)
```

### 2️⃣ Issues Found Table (Required)

| Icon | Severity | Category | Issue Description | File:Line | Fix Applied |
|------|----------|----------|-------------------|-----------|-------------|
| 🔴 | CRITICAL | Performance | Opacity widget creates offscreen buffer | bottom_bar_shadow.dart:9 | Removed Opacity |
| 🟡 | MEDIUM | Performance | LinearGradient created each build | bottom_bar_shadow.dart:15 | Extracted to const |

### 3️⃣ Before/After Metrics (Required)

| Category | Metric | Before | After | Change | Target | Status |
|----------|--------|--------|-------|--------|--------|--------|
| **Code** | Lines of Code | 30 | 25 | -5 (-16.7%) | - | ✅ |
| **Performance** | Build Time | 2.5ms | 0.8ms | -1.7ms (-68%) | <8ms | ✅ |
| **Performance** | Memory Footprint | 1.2KB | 0.4KB | -0.8KB (-66.7%) | Min | ✅ |

### 4️⃣ Risk Assessment Summary (Required)

```
============================================================
                    RISK ASSESSMENT SUMMARY
============================================================
🔴 CRITICAL (Memory Leak/ANR):     2 found → 2 fixed ✅
🟠 HIGH (Performance):             1 found → 1 fixed ✅
🟡 MEDIUM (Optimization):          2 found → 2 fixed ✅
🟢 LOW (Code Quality):             1 found → 1 fixed ✅
------------------------------------------------------------
   TOTAL ISSUES:                   6 found → 6 fixed
============================================================
```

### 5️⃣ Performance Gain Estimation (Required)

```
============================================================
                 PERFORMANCE IMPROVEMENT
============================================================
📊 Frame Build Time:    ~2.5ms → ~0.8ms     (68% faster ⚡)
📊 Memory Footprint:    ~1.2KB → ~0.4KB     (66.7% smaller 📉)
📊 Widget Tree Depth:   5 → 3                (40% reduction 📐)
📊 Offscreen Buffers:   1 → 0                (100% removal ✅)
------------------------------------------------------------
🎯 TARGET: Smooth 60 FPS on 2GB RAM Android devices
============================================================
```

---

## ❌ What NOT to Do

### ❌ DON'T: Show Complete Code

```dart
// ❌ WRONG - Don't output like this
part of theme;

const _kBottomBarGradient = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [
    Color(0x00110C24),
    Color(0x33110C24),
    Color(0x80110C24),
    Color(0xBF110C24),
    Color(0xE6110C24),
  ],
);

class BottomBarShadow extends StatelessWidget {
  const BottomBarShadow({super.key});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: SizedBox(
        height: 207.sz,
        width: double.infinity,
        child: const DecoratedBox(
          decoration: BoxDecoration(
            gradient: _kBottomBarGradient,
          ),
        ),
      ),
    );
  }
}
```

### ❌ DON'T: Show "Before and After" Code Blocks

```
BEFORE:
Container(
  height: 207.sz,
  decoration: BoxDecoration(...)
)

AFTER:
SizedBox(
  height: 207.sz,
  child: DecoratedBox(...)
)
```

---

## ✅ What TO Do

### ✅ DO: Show Summary Only

```
✅ Optimization Complete: bottom_bar_shadow.dart

📝 Changes Applied:
• Replaced Container with SizedBox + DecoratedBox (Line 20-26)
• Extracted LinearGradient to _kBottomBarGradient constant (Line 3-14)
• Removed Opacity widget (Line 9-11)
• Converted .withOpacity() to hex alpha colors (Line 7-8)

🔧 Tools Used:
• replace_string_in_file (1 edit)
```

### ✅ DO: Use the replace_string_in_file Tool

The tool automatically applies changes to the file. The user will see:
- The file is modified in their IDE
- The editor shows the changes
- You don't need to display the code

### ✅ DO: Focus on Metrics

Show the performance improvement clearly:
- Frame build time
- Memory usage
- Widget tree depth
- Specific improvements (removed widgets, extracted constants)

---

## 📐 Metrics Template

Use this template for EVERY optimization:

| Category | Metric | Before | After | Change | Target | Status |
|----------|--------|--------|-------|--------|--------|--------|
| **Code** | Lines of Code | X | Y | -Z% | - | ✅ |
| **Code** | Cyclomatic Complexity | X | Y | -Z% | <10 | ✅ |
| **Code** | Widget Tree Depth | X | Y | -Z | <15 | ✅ |
| **Memory** | Controllers Created | X | Y | - | - | ✅ |
| **Memory** | Controllers Disposed | X/Y | Y/Y | - | 100% | ✅ |
| **Memory** | Potential Memory Leaks | X | 0 | -100% | 0 | ✅ |
| **Performance** | const Widgets Used | X | Y | +Z% | Max | ✅ |
| **Performance** | Expensive Widgets | X | 0 | -100% | 0 | ✅ |
| **Performance** | Build Time (est.) | Xms | Yms | -Z% | <8ms | ✅ |

---

## 🎯 Examples

### ✅ Good Example Output

```
✅ Optimization Complete: loading_spinner.dart

📝 Changes Applied:
• Replaced Opacity with FadeTransition (Line 15-20)
• Extracted CircularProgressIndicator to const _kSpinner (Line 5)
• Removed unnecessary Container wrapper (Line 12)
• Added vsync to AnimationController (Line 8)

🔧 Tools Used:
• replace_string_in_file (2 edits)

📊 Issues Found and Fixed:

| Icon | Severity | Category | Issue | File:Line | Fix |
|------|----------|----------|-------|-----------|-----|
| 🔴 | CRITICAL | Performance | Opacity widget | loading_spinner.dart:15 | Replaced with FadeTransition |
| 🟡 | MEDIUM | Performance | Repeated CircularProgressIndicator | loading_spinner.dart:22,35,48 | Extracted to const |

📈 Before/After Metrics:

| Category | Metric | Before | After | Change | Status |
|----------|--------|--------|-------|--------|--------|
| **Code** | Lines | 40 | 32 | -8 (-20%) | ✅ |
| **Performance** | Build Time | 2.1ms | 0.6ms | -1.5ms (-71%) | ✅ |
| **Performance** | Memory | 0.8KB | 0.2KB | -0.6KB (-75%) | ✅ |

============================================================
                    RISK ASSESSMENT SUMMARY
============================================================
🟠 HIGH (Performance):             1 found → 1 fixed ✅
🟡 MEDIUM (Optimization):          1 found → 1 fixed ✅
------------------------------------------------------------
   TOTAL ISSUES:                   2 found → 2 fixed
============================================================

============================================================
                 PERFORMANCE IMPROVEMENT
============================================================
📊 Frame Build Time:    ~2.1ms → ~0.6ms     (71% faster ⚡)
📊 Memory Footprint:    ~0.8KB → ~0.2KB     (75% smaller 📉)
------------------------------------------------------------
🎯 TARGET: Smooth 60 FPS on 2GB RAM Android devices
============================================================
```

---

## 📝 Summary

| Aspect | ✅ DO | ❌ DON'T |
|--------|--------|----------|
| **Code Display** | Summary only | Full code blocks |
| **Edits** | Use tool to apply | Show in message |
| **Metrics** | Display tables | Hide numbers |
| **Line Changes** | Mention (Line X-Y) | Hide details |
| **Total Output** | 2-3 paragraphs + tables | Pages of code |

---

**Last Updated:** December 6, 2025  
**Required For:** All widget optimizations in the site
