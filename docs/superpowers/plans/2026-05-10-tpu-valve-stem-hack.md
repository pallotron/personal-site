# TPU Valve Stem Hack Blog Post Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Publish a short (400–500 word) blog post about bending a TPU valve stem with a frame pump and the flexible adapter hack built to prevent it.

**Architecture:** Hugo page bundle under `content/posts/2026/05/10/tpu-valve-stem-hack/` — an `index.md` with front matter plus four JPEG images copied from `~/Downloads`. No code, no shortcodes beyond standard markdown image syntax.

**Tech Stack:** Hugo static site generator, Markdown, JPEG images.

---

### Task 1: Create post directory and copy images

**Files:**
- Create: `content/posts/2026/05/10/tpu-valve-stem-hack/` (directory)
- Copy: `~/Downloads/IMG_0711.jpeg` → `content/posts/2026/05/10/tpu-valve-stem-hack/IMG_0711.jpeg`
- Copy: `~/Downloads/IMG_0712.jpeg` → `content/posts/2026/05/10/tpu-valve-stem-hack/IMG_0712.jpeg`
- Copy: `~/Downloads/IMG_0713.jpeg` → `content/posts/2026/05/10/tpu-valve-stem-hack/IMG_0713.jpeg`
- Copy: `~/Downloads/IMG_0714.jpeg` → `content/posts/2026/05/10/tpu-valve-stem-hack/IMG_0714.jpeg`

- [ ] **Step 1: Create the directory and copy images**

```bash
mkdir -p content/posts/2026/05/10/tpu-valve-stem-hack
cp ~/Downloads/IMG_0711.jpeg content/posts/2026/05/10/tpu-valve-stem-hack/
cp ~/Downloads/IMG_0712.jpeg content/posts/2026/05/10/tpu-valve-stem-hack/
cp ~/Downloads/IMG_0713.jpeg content/posts/2026/05/10/tpu-valve-stem-hack/
cp ~/Downloads/IMG_0714.jpeg content/posts/2026/05/10/tpu-valve-stem-hack/
```

- [ ] **Step 2: Verify**

```bash
ls content/posts/2026/05/10/tpu-valve-stem-hack/
```

Expected output:
```
IMG_0711.jpeg  IMG_0712.jpeg  IMG_0713.jpeg  IMG_0714.jpeg
```

---

### Task 2: Write the post

**Files:**
- Create: `content/posts/2026/05/10/tpu-valve-stem-hack/index.md`

- [ ] **Step 1: Create `index.md` with the following exact content**

```markdown
---
title: "The crooked valve stem: a TPU tube lesson from the Fleche and the 600"
date: 2026-05-10T08:00:00+01:00
draft: false
tags: ["cycling", "audax", "randonneuring", "tpu", "tubes", "maintenance", "hack", "silca", "lezyne"]
featured_image: "IMG_0711.jpeg"
images: ["IMG_0711.jpeg"]
---

At the [Easter Fleche](https://www.strava.com/activities/17975409428) this year I
had a puncture. I swapped in a fresh TPU tube roadside, pulled out the
[Silca Impero Ultimate II](https://silca.cc/products/impero-ultimate-frame-pump)
and pumped it up. As I screwed the pump head off I noticed the valve stem looked
slightly crooked. Not dramatically — just a few degrees off-centre. I told myself
it was fine and got back on the bike.

The Fleche finished without further incident.

A few weeks later I rode the [Eoin McLove 600](https://www.strava.com/activities/18364161281).
Six hundred kilometres, no mechanicals, bike felt completely normal all the way
through. I got home, put the bike away, went to bed.

The next morning the rear tyre was soft.

It took me a moment to connect the dots. The crooked valve stem wasn't just
cosmetic — it had been stressed at the base and was leaking slowly. The Silca
Impero is a frame pump: you brace it against the valve and push hard. That force
isn't purely axial. There's always some lateral component, and for a butyl tube
that's fine — the valve stem is stiff enough to take it. But TPU valve stems are
thinner and more flexible. Push hard at the wrong angle and they bend. Once bent,
the seal at the base can start to weep.

Rather than relying on willpower to be more careful next time (mid-event,
four hundred kilometres in), I built a small adapter from salvaged parts:

- the ABS hose from a broken Lezyne Pocket Drive
- a Schrader/Presta adapter
- a valve extender
- a valve core

The extender threads onto the valve stem. The adapter bridges Presta to Schrader.
The Lezyne ABS hose connects the adapter to the pump head. The hose is flexible —
any angular force from the pump is absorbed by the hose, not transmitted to the
valve stem.

![Parts disassembled](IMG_0714.jpeg)

![Assembled adapter](IMG_0711.jpeg)

![Chuck end detail](IMG_0713.jpeg)

It adds about thirty seconds to the inflation process, which is nothing compared
to diagnosing a slow leak four hundred kilometres into a 600.

TPU tubes are worth it. They are significantly lighter than butyl and robust
enough for long-distance riding. But they reward care at the valve — especially
when using a frame pump. If you are buying new, some manufacturers now offer TPU
tubes with metal valve stems, which are much more resistant to this kind of
damage. Worth considering if you pump roadside regularly.
```

---

### Task 3: Verify the site builds

**Files:** No changes — read-only verification step.

- [ ] **Step 1: Run Hugo in draft mode and check for errors**

```bash
hugo server -D --renderToMemory 2>&1 | head -40
```

Expected: no `ERROR` lines. You should see the new post listed in the build output.

- [ ] **Step 2: Check the post URL resolves in the build output**

Look for a line like:
```
content/posts/2026/05/10/tpu-valve-stem-hack/index.md
```
in the build output, confirming Hugo picked up the new page bundle.

- [ ] **Step 3: Commit**

```bash
jj describe -m "Add blog post: TPU valve stem hack"
jj new
```

---
