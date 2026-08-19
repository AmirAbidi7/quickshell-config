# Design: Sliding Yellow Workspace Indicator

Date: 2026-08-19

## Goal

Replace the per-button color change in the Workspaces widget (`Navbar/Workspaces/Workspace.qml`) with a single slanted yellow container that slides to whichever workspace is active.

## Current Behavior

- Outer `Slice` shell (`mode: "lean"`, `skew: Style.navbarSkew`) containing a `FlexboxLayout` (`gap: -1`) with a `Repeater` of 5 `Slice` buttons (width 32).
- The active button fills with `Style.buttonActiveBg` (`#FFF000`), animated via `Behavior on fillColor { ColorAnimation { duration: 100 } }`.
- Hovered (non-active) buttons fill with `Style.buttonHoverBg`.
- Text color: `Style.bg` when active, `Style.text` when the workspace exists, `Style.inactive` otherwise.
- Click dispatches `workspace <n>` (or Lua equivalent).

## Design

### 1. Active index at root

Compute a single active index once at the root:

```
activeIndex = focusedWorkspace.id - 1  if id in 1..5, else -1
```

### 2. Indicator Slice

Add a yellow `Slice` as a sibling *before* `flexboxLayout` (later siblings draw on top, so it renders behind the buttons):

- Same shape as buttons: `mode: "lean"`, `skew: root.skew`
- `width: 32`, full height, `fillColor: Style.buttonActiveBg`
- `x` bound to the active button's live position: find the Repeater child whose `index == activeIndex` via `flexboxLayout.children` and use `button.mapToItem(root, 0, 0).x`. Robust to future layout/width changes.
- `Behavior on x { NumberAnimation { duration: 180; easing.type: Easing.OutCubic } }` produces the slide.
- `visible`/`opacity` bound to `activeIndex >= 0` with a 100ms fade so the indicator hides when a workspace above 5 is focused.

### 3. Simplified buttons

- `fillColor` becomes `!isActive && ma.containsMouse ? Style.buttonHoverBg : "transparent"` — the per-button active fill and its `ColorAnimation` are removed (the indicator replaces them).
- Text color logic unchanged.

### 4. Unchanged

- Outer shell, hover `MouseArea`, `Hyprland.dispatch` click handling, `FlexboxLayout`/gap, fixed model of 5.

## Edge Cases

- Focused workspace id > 5: indicator hides (fade out), reappears on return to 1-5.
- Hover on the active button: no tint (indicator already marks it).
- Skew seam alignment between indicator and neighboring buttons may need a ±1px width tweak; verify visually.

## Scope

- Single file: `Navbar/Workspaces/Workspace.qml`. No new files, no changes to `Slice.qml`, `Style.qml`, or `Navbar.qml`.

## Verification

- `quickshell check` for QML errors (if available).
- Reload config and visually confirm: slide animation, hover tint, hide on ws > 5, text contrast on yellow, skew alignment.
- Backup point exists: git commit `56d47bd` plus `Workspace.qml.backup`.
