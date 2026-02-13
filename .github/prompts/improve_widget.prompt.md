# Flutter Mobile Performance Optimization Guide

Improve the following Flutter widget code for maximum performance and maintainability on mobile platforms.

---

## Critical App Health Metrics (Current Status)

The app is currently **ABOVE Google Play thresholds**. Every optimization must prioritize:

| Metric                 | Current | Threshold | Status      |
| ---------------------- | ------- | --------- | ----------- |
| ANR Rate               | >2.44%  | 0.47%     | 🔴 CRITICAL |
| Crash Rate             | >0.54%  | 1.09%     | 🟠 WARNING  |
| Slow Cold Start        | 24.80%  | -         | 🟠 HIGH     |
| Slow Sessions (30 FPS) | 13.02%  | -         | 🟠 HIGH     |

---

# SECTION 1: MEMORY LEAK PREVENTION (CRITICAL)

Memory leaks are the PRIMARY cause of crashes and ANRs on low-end Android devices.

## 1.1 Controller Disposal (MANDATORY)

Every controller MUST be disposed in the dispose() method:

| Controller Type       | Dispose Method | Risk if Leaked                 |
| --------------------- | -------------- | ------------------------------ |
| AnimationController   | .dispose()     | HIGH - GPU memory              |
| TextEditingController | .dispose()     | MEDIUM - Native memory         |
| ScrollController      | .dispose()     | MEDIUM - Listener accumulation |
| PageController        | .dispose()     | MEDIUM - Listener accumulation |
| TabController         | .dispose()     | MEDIUM - Listener accumulation |
| FocusNode             | .dispose()     | LOW - Native focus handlers    |
| VideoPlayerController | .dispose()     | CRITICAL - Media memory        |
| WebViewController     | .dispose()     | CRITICAL - WebView process     |

## 1.2 Subscription Cancellation (MANDATORY)

| Subscription Type        | Cancel Method    | Common Mistake                      |
| ------------------------ | ---------------- | ----------------------------------- |
| StreamSubscription       | .cancel()        | Forgetting to store reference       |
| Timer                    | .cancel()        | Using Timer.periodic without cancel |
| Timer.periodic           | .cancel()        | Fire-and-forget pattern             |
| Ticker                   | .dispose()       | Not using vsync mixin               |
| ChangeNotifier listeners | removeListener() | Only adding, never removing         |
| ValueNotifier listeners  | removeListener() | Only adding, never removing         |

## 1.3 Context and Closure Safety (MANDATORY)

| Rule                     | Description                                   | Example                              |
| ------------------------ | --------------------------------------------- | ------------------------------------ |
| NEVER store BuildContext | Context becomes invalid after widget disposal | Bad: `_savedContext = context`       |
| ALWAYS check mounted     | Before any setState after async operation     | `if (!mounted) return;`              |
| AVOID capturing this     | In long-lived closures (timers, streams)      | Use weak references or mounted check |
| AVOID anonymous closures | That outlive the widget lifecycle             | Extract to named methods             |

## 1.4 Dispose Pattern Template

```dart
class _MyWidgetState extends State<MyWidget> with SingleTickerProviderStateMixin {
  late final AnimationController _animController;
  late final ScrollController _scrollController;
  StreamSubscription? _subscription;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _subscription?.cancel();
    _animController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}
```

---

# SECTION 2: ANR PREVENTION (CRITICAL)

ANR (Application Not Responding) occurs when main thread is blocked for >5 seconds. Target: <16ms per frame.

## 2.1 Main Thread Protection

| Rule                  | Description                                         | Solution                              |
| --------------------- | --------------------------------------------------- | ------------------------------------- |
| NO sync I/O           | File, database, network operations                  | Use async or Isolate                  |
| NO heavy computation  | JSON parsing, image processing, sorting large lists | Use compute() or Isolate.run()        |
| NO blocking loops     | While loops, heavy for loops                        | Break into chunks with Future.delayed |
| NO initState blocking | Heavy initialization in initState                   | Use addPostFrameCallback              |

## 2.2 Async Operations Guidelines

| Operation Duration | Recommended Approach                 |
| ------------------ | ------------------------------------ |
| < 1ms              | Inline in build (const only)         |
| 1-16ms             | initState or didChangeDependencies   |
| 16-100ms           | addPostFrameCallback                 |
| 100ms-1s           | compute() function                   |
| > 1s               | Isolate.run() with progress feedback |

## 2.3 Safe Async Pattern

```dart
Future<void> _loadData() async {
  final result = await compute(_heavyOperation, inputData);
  if (!mounted) return;
  setState(() => _data = result);
}

@override
void initState() {
  super.initState();
  WidgetsBinding.instance.addPostFrameCallback((_) {
    if (mounted) _loadData();
  });
}
```

## 2.4 Frame Budget Management

| Budget       | Available Time | Usage                         |
| ------------ | -------------- | ----------------------------- |
| 60 FPS       | 16.67ms        | Total frame time              |
| Build phase  | ~4ms           | Widget tree construction      |
| Layout phase | ~4ms           | Size and position calculation |
| Paint phase  | ~4ms           | Rendering to canvas           |
| Composite    | ~4ms           | GPU upload and display        |

---

# SECTION 3: WIDGET PERFORMANCE OPTIMIZATION

## 3.1 Expensive Widgets to Avoid

| Widget                           | Problem                                | Alternative                              | Performance Gain |
| -------------------------------- | -------------------------------------- | ---------------------------------------- | ---------------- |
| Container (only decoration/size) | Heavy widget with 30+ properties       | SizedBox + DecoratedBox                  | 70-75% faster    |
| Opacity                          | Creates offscreen buffer, full repaint | FadeTransition, Color with opacity       | 40-60% faster    |
| ClipRRect                        | Expensive clipping operation           | Container with borderRadius (decoration) | 30-50% faster    |
| ClipPath                         | Very expensive custom clipping         | Pre-clipped images or ShapeBorder        | 50-70% faster    |
| ClipOval                         | Expensive oval clipping                | CircleAvatar or circular Container       | 30-50% faster    |
| BackdropFilter                   | EXTREMELY expensive blur               | Pre-rendered blur images                 | 80-90% faster    |
| ColorFiltered                    | Runtime color manipulation             | Pre-colored assets                       | 40-60% faster    |
| ShaderMask                       | Shader compilation stutter             | Gradient in BoxDecoration                | 50-70% faster    |
| PhysicalModel                    | Complex shadow calculation             | Container with boxShadow (limited)       | 20-40% faster    |

## 3.2 Layout Optimization

| Avoid                   | Prefer                           | Reason                            |
| ----------------------- | -------------------------------- | --------------------------------- |
| Nested Column/Row       | CustomMultiChildLayout           | O(n) vs O(n²) layout              |
| Unbounded ListView      | ListView.builder with itemExtent | Lazy loading + predictable scroll |
| Expanded in ScrollView  | SliverFillRemaining              | Proper sliver protocol            |
| Multiple Stacks         | Single Stack with Positioned     | Reduced layout passes             |
| IntrinsicWidth/Height   | Fixed sizes or LayoutBuilder     | Avoids double layout pass         |
| Wrap with many children | Flow widget                      | Better performance for many items |

## 3.3 const Optimization

| Rule                   | Impact                              | Example                                     |
| ---------------------- | ----------------------------------- | ------------------------------------------- |
| Use const constructors | Compile-time constant, zero rebuild | `const Text('Hello')`                       |
| Use const variables    | Reuse across rebuilds               | `static const _padding = EdgeInsets.all(8)` |
| Extract const widgets  | Separate const widget classes       | `const _MyIcon()`                           |
| Use const collections  | Immutable lists/maps                | `const ['a', 'b', 'c']`                     |

## 3.4 Const Extraction Rules (PERFORMANCE CRITICAL)

When the same `const` object is used **3+ times** in a file, extract it to a **top-level private constant**:

```dart
// ✅ GOOD - Top-level const (zero runtime allocation)
const _kTextGradient = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [Color(0xFFFBF2D5), Color(0xFFEFD5B3)],
);

// Then use: linearGradient: _kTextGradient,

// ❌ BAD - Inline const (still allocates object reference per use)
linearGradient: const LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [Color(0xFFFBF2D5), Color(0xFFEFD5B3)],
),
```

**Common candidates for extraction:**

- `LinearGradient` / `RadialGradient`
- `BoxDecoration`
- `TextStyle`
- `EdgeInsets` / `EdgeInsetsDirectional`
- `BorderRadius`
- `BoxShadow` lists
- `Duration`
- Repeated `Color` values

## 3.5 Container vs Lightweight Alternatives (PERFORMANCE CRITICAL)

**Container is heavy with 30+ internal properties.** Use lightweight alternatives when possible:

| Use Case            | Container      | Better Alternative      | Performance Gain |
| ------------------- | -------------- | ----------------------- | ---------------- |
| Only size           | ✅ Works       | SizedBox                | 60% faster       |
| Size + decoration   | ✅ Works       | SizedBox + DecoratedBox | 70% faster       |
| Size + gradient     | ✅ Works       | SizedBox + DecoratedBox | 75% faster       |
| Size + border       | ✅ Works       | SizedBox + DecoratedBox | 70% faster       |
| Padding + content   | ✅ Works       | Padding + child         | 50% faster       |
| All features needed | ✅ Only option | Container               | Baseline         |

**Pattern:**

```dart
// ❌ BAD - Heavy Container with only gradient
Container(
  height: 207,
  decoration: const BoxDecoration(
    gradient: _kGradient,
  ),
)

// ✅ GOOD - Lightweight SizedBox + DecoratedBox
SizedBox(
  height: 207,
  width: double.infinity,
  child: const DecoratedBox(
    decoration: BoxDecoration(
      gradient: _kGradient,
    ),
  ),
)
```

## 3.6 RepaintBoundary Usage

| When to Use                  | When to Avoid            |
| ---------------------------- | ------------------------ |
| Animated widgets             | Static content           |
| Frequently updating sections | Simple text/icons        |
| Complex custom painters      | Transparent overlays     |
| Video/canvas content         | Already isolated widgets |

---

# SECTION 4: ANIMATION OPTIMIZATION

## 4.1 Animation Limits for Low-End Devices

| Constraint                 | Value               | Reason                      |
| -------------------------- | ------------------- | --------------------------- |
| Max concurrent animations  | 2-3                 | CPU/GPU bandwidth           |
| Animation duration minimum | 150ms               | Perceivable on slow devices |
| Animation duration maximum | 500ms               | User patience threshold     |
| Particles/objects          | <50                 | GPU fill rate               |
| Animation curves           | Use standard curves | Avoid custom heavy math     |

## 4.2 Animation Best Practices

| Rule                       | Description                    |
| -------------------------- | ------------------------------ |
| Always use vsync           | Prevents unnecessary frames    |
| Use AnimatedBuilder        | Isolates rebuilds to animation |
| Avoid setState in listener | Causes full widget rebuild     |
| Use Transform widget       | GPU accelerated, no layout     |
| Prefer SlideTransition     | Over AnimatedPositioned        |
| Prefer FadeTransition      | Over AnimatedOpacity           |
| Prefer ScaleTransition     | Over AnimatedScale             |

## 4.3 Rive Animation Guidelines

| Rule                      | Description                  |
| ------------------------- | ---------------------------- |
| Limit active artboards    | Max 2-3 visible at once      |
| Use simple state machines | Avoid complex nested states  |
| Disable when off-screen   | Pause animations not visible |
| Pre-load in cache         | Load before navigation       |
| Avoid masking             | Known performance issue      |
| Avoid image clipping      | Only shapes work efficiently |

---

# SECTION 5: MEMORY MANAGEMENT

## 5.1 Image Optimization

| Rule                        | Description              | Impact                  |
| --------------------------- | ------------------------ | ----------------------- |
| Use WebP format             | 30% smaller than PNG     | Memory reduction        |
| Limit dimensions            | Max 2x device resolution | Texture memory          |
| Use cacheWidth/cacheHeight  | Decode at display size   | 50-80% memory reduction |
| preAppImage                 | Load before navigation   | Smoother transitions    |
| Clear image cache           | When memory pressure     | imageCache.clear()      |
| Avoid large images in lists | Use thumbnails           | Massive memory savings  |

## 5.2 List Optimization

| Rule                             | Description                          |
| -------------------------------- | ------------------------------------ |
| Always use .builder              | ListView.builder, GridView.builder   |
| Set itemCount                    | Enables proper scroll estimation     |
| Set itemExtent                   | When items have fixed height         |
| Set cacheExtent                  | 250-500 pixels for low-end           |
| Use AutomaticKeepAlive sparingly | Retains memory for all kept items    |
| Dispose items off-screen         | Release resources when scrolled away |

## 5.3 Caching Strategy

| Data Type        | Cache Location                    | Eviction Strategy  |
| ---------------- | --------------------------------- | ------------------ |
| API responses    | Memory LRU cache                  | Time + count based |
| Images           | Disk cache (cached_network_image) | Size based         |
| User preferences | SharedPreferences/Hive            | Persistent         |
| Game state       | Memory                            | Session only       |
| Computed values  | late final fields                 | Widget lifetime    |

---

# SECTION 6: STATE MANAGEMENT OPTIMIZATION

## 6.1 Rebuild Minimization

| Pattern                | Description                      | Use Case              |
| ---------------------- | -------------------------------- | --------------------- |
| ValueListenableBuilder | Single value updates             | Counters, toggles     |
| AnimatedBuilder        | Animation updates                | Any animation         |
| StreamBuilder          | Stream updates                   | Real-time data        |
| Selector (Riverpod)    | Partial state selection          | Complex state objects |
| const child parameter  | Static parts of animated widgets | Labels, icons         |

## 6.2 Provider/Riverpod Guidelines

| Rule                       | Description                              |
| -------------------------- | ---------------------------------------- |
| Use select()               | Only rebuild on specific field changes   |
| Avoid watch() in loops     | Causes multiple subscriptions            |
| Dispose providers properly | Use autoDispose where appropriate        |
| Lazy initialization        | Don't eagerly create expensive providers |
| Scope providers            | Limit rebuild radius                     |

---

# SECTION 7: PLATFORM-SPECIFIC OPTIMIZATION

## 7.1 Android Specific

| Area       | Optimization                    |
| ---------- | ------------------------------- |
| Startup    | Minimize native splash duration |
| Background | Release resources in onPause    |
| Memory     | Handle onTrimMemory callbacks   |
| Threading  | Use platform channels carefully |
| Rendering  | Test on Skia and Impeller       |

## 7.2 iOS Specific

| Area      | Optimization                       |
| --------- | ---------------------------------- |
| Startup   | Optimize launch storyboard         |
| Memory    | iOS is more aggressive with memory |
| Gestures  | Avoid gesture recognizer conflicts |
| Scrolling | Match iOS physics expectations     |

---

# SECTION 8: CODE STANDARDS

## 8.1 General Rules

- Do not add any comments in the code
- Always use UIControl.width, UIControl.height or UIControl.mqSize instead of MediaQuery directly
- Always ensure that the visual output remains unchanged after improvements
- Do not remove super.key from public constructors of widgets
- Always verify context.mounted before calling setState after async operations
- Prefer const widgets and const constructors wherever possible
- Extract callback functions to methods instead of inline closures in build()
- Use Get.find<T>() for dependency access following project patterns
- **Extract repeated const values (3+ uses) to top-level private constants**

## 8.2 Import Organization

```dart
// Dart SDK
import 'dart:async';
import 'dart:math';

// Flutter SDK
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// External packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

// Project imports
import 'package:wsp/app/...';
```

## 8.3 Output Format (CRITICAL)

**NEVER output the complete modified code.** Instead:

1. **Apply edits using the appropriate tool** (replace_string_in_file)
2. **Show ONLY a summary** of what was changed
3. **Generate the required metrics tables** (before/after)
4. **Include the Issues Found table** with severity icons

**Example of CORRECT output:**

```
✅ Applied optimization to bottom_bar_shadow.dart

📝 Changes made:
• Removed Opacity widget (1 instance)
• Extracted LinearGradient to _kBottomBarGradient constant
• Replaced Container with SizedBox + DecoratedBox
• Converted .withOpacity() calls to hex alpha notation

Results:
- Build time: 2.5ms → 0.8ms (68% faster)
- Memory: 1.2KB → 0.4KB (66.7% smaller)
- Widget tree depth: 5 → 3 (40% reduction)
```

**Example of WRONG output (avoid):**

```dart
// ❌ DON'T DO THIS - Don't show the full modified code
part of theme;

const _kBottomBarGradient = LinearGradient(
  ... (30 lines of code)
)
```

---

# SECTION 9: REQUIRED OUTPUT FORMAT

## 9.0 Summary of Changes Section (MANDATORY)

At the beginning of your response, include a clear summary:

```
✅ Optimization Complete: [filename.dart]

📝 Changes Applied:
• [Description of change 1] (Line X)
• [Description of change 2] (Line Y)
• [Description of change 3] (Line Z)

🔧 Tools Used:
• replace_string_in_file (3 edits)
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

## 9.1 Issues Found Table

For each issue found, categorize by severity:

| Icon | Severity | Category     | Issue Description                   | File:Line         | Fix Applied                           |
| ---- | -------- | ------------ | ----------------------------------- | ----------------- | ------------------------------------- |
| 🔴   | CRITICAL | Memory Leak  | AnimationController not disposed    | file.dart:45      | Added dispose() call                  |
| 🔴   | CRITICAL | ANR Risk     | Sync JSON parsing in build()        | file.dart:78      | Moved to compute()                    |
| 🔴   | CRITICAL | Memory Leak  | StreamSubscription not cancelled    | file.dart:23      | Added cancel() in dispose             |
| 🟠   | HIGH     | Performance  | Container with only size/decoration | file.dart:50      | Replaced with SizedBox + DecoratedBox |
| 🟠   | HIGH     | Performance  | Opacity widget used                 | file.dart:120     | Replaced with FadeTransition          |
| 🟠   | HIGH     | Performance  | BackdropFilter on low-end path      | file.dart:95      | Used pre-rendered blur                |
| 🟡   | MEDIUM   | Performance  | Missing const constructor           | file.dart:15      | Added const                           |
| 🟡   | MEDIUM   | Performance  | Repeated LinearGradient (5x)        | file.dart:various | Extracted to \_kTextGradient          |
| 🟡   | MEDIUM   | Code Quality | Inline closure in build             | file.dart:88      | Extracted to method                   |
| 🟢   | LOW      | Code Quality | Import organization                 | file.dart:1-10    | Reorganized imports                   |

## 9.2 Before/After Metrics Table

| Category        | Metric                            | Before | After | Change | Target      | Status  |
| --------------- | --------------------------------- | ------ | ----- | ------ | ----------- | ------- |
| **Code**        | Lines of Code                     | X      | Y     | -Z%    | -           | -       |
| **Code**        | Cyclomatic Complexity             | X      | Y     | -Z%    | <10         | OK/FAIL |
| **Code**        | Widget Tree Depth                 | X      | Y     | -Z     | <15         | OK/FAIL |
| **Memory**      | Controllers Created               | X      | Y     | -      | -           | -       |
| **Memory**      | Controllers Disposed              | X/Y    | Y/Y   | -      | 100%        | OK/FAIL |
| **Memory**      | Subscriptions Cancelled           | X/Y    | Y/Y   | -      | 100%        | OK/FAIL |
| **Memory**      | Potential Memory Leaks            | X      | 0     | -100%  | 0           | OK/FAIL |
| **Performance** | const Widgets Used                | X      | Y     | +Z%    | Max         | -       |
| **Performance** | Repeated const Extracted          | X      | Y     | -      | All 3+ uses | OK/FAIL |
| **Performance** | Expensive Widgets Removed         | X      | 0     | -100%  | 0           | OK/FAIL |
| **Performance** | Container → SizedBox+DecoratedBox | X      | 0     | -100%  | 0           | OK/FAIL |
| **Performance** | ANR Risk Points                   | X      | 0     | -100%  | 0           | OK/FAIL |
| **Performance** | Estimated Build Time              | Xms    | Yms   | -Z%    | <8ms        | OK/FAIL |
| **Performance** | Estimated Build Time              | Xms    | Yms   | -Z%    | <8ms        | OK/FAIL |

## 9.3 Risk Assessment Summary

```
============================================================
                    RISK ASSESSMENT SUMMARY
============================================================
🔴 CRITICAL (Memory Leak/ANR):     X found → X fixed ✅
🟠 HIGH (Performance):             X found → X fixed ✅
🟡 MEDIUM (Optimization):          X found → X fixed ✅
🟢 LOW (Code Quality):             X found → X fixed ✅
------------------------------------------------------------
   TOTAL ISSUES:                   X found → X fixed
============================================================
```

## 9.4 Performance Gain Estimation

```
============================================================
                 PERFORMANCE IMPROVEMENT
============================================================
📊 Frame Build Time:    ~Xms → ~Yms     (Z% faster)
📊 Memory Footprint:    ~X KB → ~Y KB   (Z% smaller)
📊 Widget Rebuilds:     X → Y           (Z% reduction)
📊 Allocation in Build: X KB → Y KB     (Z% reduction)
------------------------------------------------------------
🎯 TARGET: Smooth 60 FPS on 2GB RAM Android devices
============================================================
```

---

# SECTION 10: FINAL VALIDATION CHECKLIST

Before submitting optimized code, ALL items must be verified:

## 10.1 Memory Safety Checklist

| #   | Check                                                  | Status |
| --- | ------------------------------------------------------ | ------ |
| 1   | All AnimationController instances disposed             | ⬜     |
| 2   | All TextEditingController instances disposed           | ⬜     |
| 3   | All ScrollController/PageController instances disposed | ⬜     |
| 4   | All TabController instances disposed                   | ⬜     |
| 5   | All FocusNode instances disposed                       | ⬜     |
| 6   | All StreamSubscription instances cancelled             | ⬜     |
| 7   | All Timer instances cancelled                          | ⬜     |
| 8   | All listeners removed with removeListener()            | ⬜     |
| 9   | No BuildContext stored in class fields                 | ⬜     |
| 10  | All async setState calls check mounted first           | ⬜     |
| 11  | No memory-retaining closures in callbacks              | ⬜     |

## 10.2 Performance Checklist

| #   | Check                                             | Status |
| --- | ------------------------------------------------- | ------ |
| 12  | No heavy computation in build() method            | ⬜     |
| 13  | No synchronous I/O on main thread                 | ⬜     |
| 14  | const used on all eligible constructors           | ⬜     |
| 15  | No inline closures creating objects in build()    | ⬜     |
| 16  | Widget tree depth is reasonable (<15 levels)      | ⬜     |
| 17  | No Opacity widget (use FadeTransition)            | ⬜     |
| 18  | No BackdropFilter without absolute necessity      | ⬜     |
| 19  | No ClipRRect where borderRadius suffices          | ⬜     |
| 20  | RepaintBoundary used for animated sections        | ⬜     |
| 21  | ListView.builder used instead of ListView         | ⬜     |
| 22  | itemExtent or itemCount set on lists              | ⬜     |
| 23  | Repeated const values (3+) extracted to top-level | ⬜     |

## 10.3 Code Quality Checklist

| #   | Check                                      | Status |
| --- | ------------------------------------------ | ------ |
| 24  | No comments added to code                  | ⬜     |
| 25  | Uses UIControl instead of MediaQuery       | ⬜     |
| 26  | Visual output unchanged                    | ⬜     |
| 27  | super.key preserved in public constructors | ⬜     |
| 28  | Imports properly organized                 | ⬜     |
| 29  | Follows project GetX patterns              | ⬜     |

---

# SECTION 11: ADDITIONAL GUIDELINES

## 11.1 Debugging Performance

| Tool                | Usage                                       |
| ------------------- | ------------------------------------------- |
| Flutter DevTools    | Timeline, memory profiler, widget inspector |
| Performance Overlay | showPerformanceOverlay: true                |
| dart:developer      | Timeline events for custom profiling        |
| SchedulerBinding    | Frame callback timing                       |

## 11.2 Testing on Low-End Devices

| Approach            | Description                          |
| ------------------- | ------------------------------------ |
| Real device testing | Test on actual budget Android phones |
| Throttle CPU        | Use DevTools to simulate slow CPU    |
| Reduce memory       | Android developer options            |
| Profile mode        | flutter run --profile                |

## 11.3 Terminal/Process Management

If any terminal or process is opened to run commands during the analysis or measurement, ensure that the terminal/process is properly closed at the end of execution.

## 11.4 Output File Format (CRITICAL - READ CAREFULLY)

**MANDATORY:** When outputting results, follow this exact structure:

### ✅ Step 1: Summary of Changes

Show what was modified (brief, clear):

```
✅ Optimization Complete: filename.dart

📝 Changes Applied:
• Change 1 description (Line X)
• Change 2 description (Line Y)
```

### ✅ Step 2: Issues Found Table

Table with severity, category, and fix applied (from section 9.1)

### ✅ Step 3: Before/After Metrics

Show metrics comparison (from section 9.2)

### ✅ Step 4: Risk Assessment

Show summary of fixes (from section 9.3)

### ✅ Step 5: Performance Gain Estimation

Show improvement percentages (from section 9.4)

### ❌ NEVER DO THIS:

- ❌ Output the entire modified code
- ❌ Show code blocks with all 50+ lines
- ❌ Include unchanged code sections
- ❌ Display the complete file content

### ✅ DO THIS INSTEAD:

- ✅ Show only the summary of what changed
- ✅ Display the metrics tables
- ✅ Include improvement percentages
- ✅ Let the replace_string_in_file tool handle the actual edits

**The user will see the file was edited in their IDE - they don't need to see the full code.**

---

# QUICK REFERENCE CARD

## Red Flags (Immediate Fix Required)

```
❌ AnimationController without dispose()
❌ StreamSubscription without cancel()
❌ Timer.periodic without cancel()
❌ setState without mounted check after async
❌ BuildContext stored in field
❌ Heavy computation in build()
❌ Sync I/O in main thread
❌ Opacity widget
❌ BackdropFilter widget
❌ ClipRRect where borderRadius works
❌ Container with only size/decoration (use SizedBox + DecoratedBox)
❌ Same const LinearGradient/BoxDecoration/TextStyle repeated 3+ times inline
```

## Green Patterns (Always Use)

```
✅ const constructors everywhere
✅ dispose() with all cleanup
✅ if (!mounted) return before setState
✅ compute() for heavy operations
✅ ListView.builder with itemCount
✅ FadeTransition instead of Opacity
✅ SizedBox + DecoratedBox instead of Container (only size/decoration)
✅ Container borderRadius instead of ClipRRect
✅ RepaintBoundary for animations
✅ late final for cached computations
✅ Extract callbacks to named methods
✅ Extract repeated const values to top-level _kConstants
✅ Extract repeated const values to top-level _kConstants
```
